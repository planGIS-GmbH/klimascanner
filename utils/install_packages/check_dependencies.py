import os
import sys
import subprocess
import tempfile
import time
import importlib
import importlib.metadata
import re
from qgis.core import QgsSettings
from qgis.PyQt.QtWidgets import QMessageBox, QApplication, QDialog, QVBoxLayout, QLabel
from qgis.PyQt.QtCore import Qt
from packaging.version import Version, InvalidVersion
from packaging.specifiers import SpecifierSet

_RESTART_MARKER_KEY = "klimascanner/pendingNumpyRestart"
_UPDATE_CONFIRMATION_KEY = "klimascanner/pendingUpdateConfirmation"

# Paketname (wie an pip uebergeben) -> Modulname (wie importiert wird), fuer die
# Faelle, in denen sich beides unterscheidet.
_IMPORT_NAME_OVERRIDES = {'py-machineid': 'machineid'}

_SPINNER_FRAMES = ['-', '\\', '|', '/']
_DOWNLOAD_RE = re.compile(r'^Downloading\s+\S+\s*\(([\d.]+\s*[KMGT]?i?B)\)', re.IGNORECASE)


def _normalize_pkg_name(name):
    return name.replace('_', '-').lower()


class _PackageInstallDialog(QDialog):
    """Zeigt je installiertem/importiertem Paket eine eigene Zeile mit Status
    (wartend / laedt mit Spinner / fertig), statt eines einzelnen Fortschrittsbalkens,
    der bei wenigen grossen Paketen kaum Bewegung zeigt."""

    def __init__(self, package_names, parent=None):
        super().__init__(parent)
        self.setWindowTitle("KLIMASCANNER")
        self.setWindowModality(Qt.WindowModality.ApplicationModal)
        self._intro = QLabel("Installiere fehlende Python-Pakete für KLIMASCANNER...")
        self._status = QLabel("")
        self._rows = {}
        self._spinner_index = 0
        self._active_name = None
        self._active_detail = ''

        layout = QVBoxLayout(self)
        layout.addWidget(self._intro)
        for name in package_names:
            row = QLabel("  •  " + name)
            layout.addWidget(row)
            self._rows[name] = row
        layout.addWidget(self._status)

    def _render_active(self):
        if self._active_name not in self._rows:
            return
        suffix = " ({})".format(self._active_detail) if self._active_detail else ""
        self._rows[self._active_name].setText("  {}  {}{}".format(
            _SPINNER_FRAMES[self._spinner_index], self._active_name, suffix))

    def set_active(self, name, detail=''):
        self._active_name = name
        self._active_detail = detail
        self._spinner_index = 0
        self._render_active()

    def set_active_detail(self, detail):
        self._active_detail = detail
        self._render_active()

    def advance_spinner(self):
        if self._active_name not in self._rows:
            return
        self._spinner_index = (self._spinner_index + 1) % len(_SPINNER_FRAMES)
        self._render_active()

    def mark_done(self, name):
        if name in self._rows:
            self._rows[name].setText("  ✓  " + name)
        if self._active_name == name:
            self._active_name = None
            self._active_detail = ''

    def mark_all_done(self):
        for name in self._rows:
            self.mark_done(name)

    def set_status(self, text):
        self._status.setText(text)

_OP_RE = re.compile(r"(==|!=|>=|<=|>|<|~=)")

# sys.executable points at the host application (e.g. qgis-bin.exe) when Python
# is embedded, not at a real python.exe - so it can't be used to run "-m pip".
# The actual interpreter lives directly under sys.prefix in QGIS/OSGeo4W installs.
def _get_python_executable():
    candidates = ['python.exe', 'python3.exe'] if os.name == 'nt' else ['python3', 'python']
    search_dirs = [sys.prefix, os.path.join(sys.prefix, 'bin')]
    for directory in search_dirs:
        for name in candidates:
            candidate = os.path.join(directory, name)
            if os.path.exists(candidate):
                return candidate
    return sys.executable

# check and install necessary packages ->  needs to be updated in the future, does not work stable

# =========================
# Sonderbehandlung für certifi
# =========================
_DATE_VER_RE = re.compile(r"^(\d{4})\.(\d{1,2})\.(\d{1,2})$")

def _parse_date_version(ver: str):
    """Parst YYYY.MM.DD in (YYYY, MM, DD) oder gibt None zurück."""
    if not isinstance(ver, str):
        return None
    m = _DATE_VER_RE.match(ver.strip())
    if not m:
        return None
    y, mth, d = (int(m.group(1)), int(m.group(2)), int(m.group(3)))
    return (y, mth, d)


def is_certifi_version_satisfied(installed_ver: str, operator: str | None, required_ver: str | None) -> bool:
    """
    Prüft certifi-Versionen im Format YYYY.MM.DD ohne PEP-440-Nebenwirkungen.
    Unterstützt Operatoren: ==, !=, >=, <=, >, <.
    Wenn keine Anforderung vorliegt (operator/required_ver None), wird True zurückgegeben.
    """
    if operator is None and required_ver is None:
        return True

    ti = _parse_date_version(installed_ver)
    tr = _parse_date_version(required_ver) if required_ver else None

    # Wenn das installierte Format kein Datum ist, gib konservativ False zurück
    if ti is None:
        return False

    if operator is None or tr is None:
        # Unvollständige Bedingung -> als erfüllt betrachten
        return True

    if operator == "==":
        return ti == tr
    elif operator == "!=":
        return ti != tr
    elif operator == ">=":
        return ti >= tr
    elif operator == "<=":
        return ti <= tr
    elif operator == ">":
        return ti > tr
    elif operator == "<":
        return ti < tr
    else:
        return False


def parse_package_info(pkg_str: str):
    """
    Gibt (name, operator, version_or_none) zurück.
    Beispiele:
      'numpy==1.26.4'   -> ('numpy','==','1.26.4')
      'numba>=0.62.1'   -> ('numba','>=','0.62.1')
      'pkg>=1.0,<2.0'   -> ('pkg','>=1.0,<2.0', None)  # Mehrfach-Constraints
      'pkg'             -> ('pkg', None, None)
      '=' wird zu '=='
    """
    s = pkg_str.strip()
    m = _OP_RE.search(s)
    if not m:
        return s, None, None

    name = s[:m.start()].strip()
    tail = s[m.start():].strip()

    # '=' zu '==' normalisieren, falls direkt am Anfang
    if tail.startswith("=") and not tail.startswith("=="):
        tail = "==" + tail[1:]

    # Mehrfach-Constraints
    if "," in tail:
        return name, tail, None

    op = m.group(1)
    if op == "=":
        op = "=="
    ver = s[m.end():].strip()
    if not ver and tail.startswith(("==", ">=", "<=", "!=", ">", "<", "~=")):
        ver = tail[len(op):].strip()
    return name, op, ver or None


def is_version_satisfied(installed_ver: str, operator: str | None, required_ver: str | None) -> bool:
    """Standardprüfung über packaging für alle Pakete außer certifi."""
    if operator is None and required_ver is None:
        return True

    try:
        inst = Version(installed_ver)
    except InvalidVersion:
        return False

    # Mehrfach-Constraints im operator (z. B. '>=1.0,<2.0')
    if operator and required_ver is None and _OP_RE.search(operator):
        try:
            spec = SpecifierSet(operator.strip())
            return inst in spec
        except Exception:
            return False

    if operator is None or required_ver is None:
        return True

    if operator == "=":
        operator = "=="

    try:
        req = Version(required_ver)
    except InvalidVersion:
        return False

    if operator == "==":
        return inst == req
    elif operator == "!=":
        return inst != req
    elif operator == ">=":
        return inst >= req
    elif operator == "<=":
        return inst <= req
    elif operator == ">":
        return inst > req
    elif operator == "<":
        return inst < req
    elif operator == "~=":
        try:
            spec = SpecifierSet(f"{operator}{required_ver}")
            return inst in spec
        except Exception:
            return False
    else:
        return False


def mark_restart_attempted(numpy_spec):
    """Vom Aufrufer zu benutzen, wenn der Nutzer tatsächlich einen QGIS-Neustart
    auslöst, um numpy_spec zu installieren (siehe check()). Erst dadurch weiß der
    nächste check()-Aufruf, dass ein Neustart schon versucht wurde."""
    QgsSettings().setValue(_RESTART_MARKER_KEY, numpy_spec)


def check(required_packages):
    """
    required_packages: Liste von Strings, z. B.:
    ['numpy>=2.0.0', 'pandas>=2.3.1', 'geopandas>=1.0.1', 'rasterio>=1.4.3',
     'machineid>=0.8.0','certifi>=2025.10.5', 'tensorflow==2.20.0', 'numba>=0.62.1']

    Rückgabe:
        True  -> Plugin kann in dieser Sitzung normal weiterladen.
        False -> numpy wurde gerade aktualisiert (oder die Aktualisierung ist
                 fehlgeschlagen, weil numpy in diesem Prozess schon geladen war und
                 pip die gesperrten .pyd-Dateien nicht zuverlässig ersetzen konnte -
                 teils WinError 5 "Zugriff verweigert", teils ein inkonsistenter
                 Zwischenzustand). In beiden Fällen darf dieser Prozess numpy nicht
                 mehr anfassen, der Aufrufer muss einen QGIS-Neustart anbieten.
    """
    missing_packages = []

    for pkg in required_packages:
        name, op, ver = parse_package_info(pkg)
        install_name = 'py-machineid' if name == 'machineid' else name

        try:
            dist = importlib.metadata.distribution(install_name)
            installed_ver = dist.version

            # certifi gesondert prüfen (Datumsversionen)
            if name == 'certifi':
                ok = is_certifi_version_satisfied(installed_ver, op, ver)
            else:
                ok = is_version_satisfied(installed_ver, op, ver)

            if not ok:
                missing_packages.append(pkg)
        except importlib.metadata.PackageNotFoundError:
            missing_packages.append(pkg)

    if not missing_packages:
        settings = QgsSettings()
        settings.remove(_RESTART_MARKER_KEY)
        if settings.value(_UPDATE_CONFIRMATION_KEY, False, bool):
            settings.remove(_UPDATE_CONFIRMATION_KEY)
            QMessageBox.information(
                None,
                "KLIMASCANNER",
                "KLIMASCANNER wurde erfolgreich aktualisiert."
            )
        return True

    numpy_spec = next((p for p in missing_packages if parse_package_info(p)[0] == 'numpy'), None)
    # Nur zur Entscheidung, was NACH dem Installationsversuch passieren soll (siehe unten) -
    # die Installation selbst wird trotzdem immer versucht, auch wenn numpy schon geladen ist.
    numpy_already_loaded = numpy_spec is not None and 'numpy' in sys.modules

    message = (
        "Die folgenden Python-Pakete (mit Versionen) werden für das Plugin Klimascanner benötigt:\n\n"
        + "\n".join(missing_packages)
        + "\n\nMöchten Sie diese jetzt installieren?"
    )

    reply = QMessageBox.question(
        None,
        'Fehlende Abhängigkeiten',
        message,
        QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No,
        QMessageBox.StandardButton.No
    )

    if reply == QMessageBox.StandardButton.No:
        return True

    install_specs = []
    install_names = []
    for pkg in missing_packages:
        name, op, ver = parse_package_info(pkg)

        if name == 'machineid':
            name = 'py-machineid'
        if name == 'certifi':
            op = '=='

        install_specs.append(f"{name}{op}{ver}" if op and ver else name)
        install_names.append(name)

    # Alle fehlenden Pakete in einem einzigen pip-Aufruf installieren, damit
    # der Resolver die Constraints gemeinsam aufloest (statt sich pro Paket
    # gegenseitig zu ueberschreiben, wie es bei sequentiellen Einzelaufrufen passieren kann).
    python_executable = _get_python_executable()
    print(f'"{python_executable}" -m pip install {" ".join(install_specs)}')
    print('Installation der fehlenden Pakete gestartet...')

    known_names_by_norm = {_normalize_pkg_name(n): n for n in install_names}
    dialog = _PackageInstallDialog(install_names)
    dialog.set_status("Bereite Installation vor…")
    dialog.show()
    QApplication.processEvents()

    # pip ist ein Konsolenprogramm, QGIS selbst hat aber keine Konsole angehängt -
    # ohne CREATE_NO_WINDOW würde Windows dafür ein sichtbares schwarzes Konsolenfenster öffnen.
    creationflags = subprocess.CREATE_NO_WINDOW if os.name == 'nt' else 0

    # stdout/stderr laufen in eine benannte Datei statt in eine PIPE: Bei PIPE wartet
    # niemand waehrend der Poll-Schleife auf Ausgaben, und pip blockiert beim Schreiben,
    # sobald der (kleine) Pipe-Puffer voll ist - bei grossen Paketen wie tensorflow mit
    # viel Download-/Build-Output ist das ein garantierter Deadlock. Fuer den Fortschritt
    # wird die Datei parallel ueber ein zweites, unabhaengiges Handle gelesen (ein Handle
    # zum Schreiben, eines zum Lesen - sonst wuerden sich Schreib- und Lesezugriff die
    # Dateiposition teilen).
    #
    # Ein einzelnes Paket wird nicht "prozentgenau" verfolgt: pips eigener Fortschrittsbalken
    # schreibt bei Umleitung in eine Datei nur den fertigen Endzustand, keine Zwischenwerte -
    # deshalb hier ein Spinner pro aktivem Paket statt einer (falschen) Prozentzahl.
    writer = tempfile.NamedTemporaryFile(mode='wb', suffix='.log', delete=False)
    log_path = writer.name
    try:
        process = subprocess.Popen(
            [python_executable, '-m', 'pip', 'install', *install_specs],
            stdout=writer,
            stderr=subprocess.STDOUT,
            creationflags=creationflags,
        )
        dialog.set_status("Installation läuft…")
        with open(log_path, 'rb') as reader:
            read_pos = 0
            while process.poll() is None:
                QApplication.processEvents()
                dialog.advance_spinner()
                time.sleep(0.1)
                reader.seek(read_pos)
                new_bytes = reader.read()
                if new_bytes:
                    read_pos += len(new_bytes)
                    for line in new_bytes.decode('utf-8', errors='replace').splitlines():
                        line = line.strip()
                        if line.startswith('Collecting '):
                            rest = line[len('Collecting '):].strip()
                            for sep in ('[', '==', '>=', '<=', '~=', '!=', '>', '<', ' ', ';'):
                                idx = rest.find(sep)
                                if idx != -1:
                                    rest = rest[:idx]
                            pkg_name = known_names_by_norm.get(_normalize_pkg_name(rest))
                            if pkg_name:
                                if dialog._active_name and dialog._active_name != pkg_name:
                                    dialog.mark_done(dialog._active_name)
                                dialog.set_active(pkg_name)
                        else:
                            match = _DOWNLOAD_RE.match(line)
                            if match and dialog._active_name:
                                dialog.set_active_detail("lädt: {}".format(match.group(1)))
        writer.close()
        with open(log_path, 'rb') as f:
            stderr = f.read().decode('utf-8', errors='replace')
    finally:
        try:
            os.unlink(log_path)
        except OSError:
            pass

    if process.returncode != 0:
        dialog.close()
        if numpy_already_loaded:
            # Fehlschlag ist hier typischerweise eine Folge gesperrter .pyd-Dateien
            # (WinError 5), weil numpy in diesem Prozess schon geladen war - nicht
            # unbedingt ein dauerhaftes Problem. Erst wenn das auch nach einem
            # tatsächlichen Neustart-Versuch wieder passiert, aufgeben und auf ein
            # Plugin-Update verweisen, statt endlos denselben Neustart anzubieten.
            settings = QgsSettings()
            if settings.value(_RESTART_MARKER_KEY, "") == numpy_spec:
                settings.remove(_RESTART_MARKER_KEY)
                QMessageBox.warning(
                    None,
                    "Aktualisierung nicht möglich",
                    "KLIMASCANNER konnte eine benötigte Python-Abhängigkeit (numpy) nicht "
                    "automatisch aktualisieren.\n\n"
                    "Bitte prüfen Sie, ob eine neuere Version von KLIMASCANNER verfügbar ist, "
                    "und aktualisieren Sie das Plugin."
                )
                return True
            return False

        QMessageBox.warning(
            None,
            "Fehler",
            f"Fehler bei der Installation der Pakete (Exit-Code {process.returncode}):\n{stderr}"
        )
        return True

    dialog.mark_all_done()

    if numpy_already_loaded:
        # Auf der Platte ist jetzt alles aktuell, aber dieser Prozess hatte die alte
        # numpy-Version schon geladen - erst ein Neustart macht den neuen Stand nutzbar.
        # Markierung setzen, damit der Nutzer nach dem Neustart eine Bestätigung sieht.
        dialog.close()
        QgsSettings().setValue(_UPDATE_CONFIRMATION_KEY, True)
        return False

    # Neu installierte Pakete jetzt schon selbst importieren, solange der Dialog noch
    # offen ist - sonst passiert dieser (bei z. B. tensorflow oft zig Sekunden dauernde)
    # erste Import unsichtbar erst spaeter beim eigentlichen Laden des Plugins, und die
    # "erfolgreich installiert"-Meldung waere verfrueht.
    dialog.set_status("Installation wird abgeschlossen…")
    for name in install_names:
        dialog.set_active(name)
        QApplication.processEvents()
        import_name = _IMPORT_NAME_OVERRIDES.get(name, name)
        try:
            importlib.import_module(import_name)
        except Exception:
            pass
        dialog.mark_done(name)
        QApplication.processEvents()

    dialog.set_status("Installation abgeschlossen.")
    QApplication.processEvents()
    time.sleep(0.6)
    dialog.close()
    return True
