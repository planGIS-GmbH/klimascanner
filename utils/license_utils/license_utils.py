import os
import zipfile
from qgis.core import QgsSettings
import json
from qgis.PyQt.QtWidgets import QDialogButtonBox, QMessageBox
from ...klimascanner_About import Klimascanner_About

def get_plugin_dir():
    return os.path.dirname(os.path.abspath(__file__)).replace('\\','/').replace('/utils/license_utils','')

def compute_calcDataDir():
    settings = QgsSettings()
    plugins_root = os.path.dirname(get_plugin_dir())
    calcdata_root = plugins_root+"/klimascanner_calcdata"
    subfolder = settings.value("klimascanner/calcDataSubfolder")

    if subfolder and os.path.isdir(os.path.join(calcdata_root, subfolder)):
        return calcdata_root+"/"+subfolder+"/"

    # Gespeicherte Einstellung fehlt oder ist veraltet (zeigt auf einen nicht
    # mehr vorhandenen Datensatz). Falls eindeutig genau ein Datensatz-Ordner
    # existiert, diesen automatisch verwenden statt hart zu scheitern.
    try:
        existing = [d for d in os.listdir(calcdata_root)
                    if os.path.isdir(os.path.join(calcdata_root, d))]
    except OSError:
        existing = []

    if len(existing) == 1:
        settings.setValue("klimascanner/calcDataSubfolder", existing[0])
        settings.sync()
        return calcdata_root+"/"+existing[0]+"/"

    if not subfolder:
        return None
    return calcdata_root+"/"+subfolder+"/"

def calc_data_available():
    try:
        calcDataDir = compute_calcDataDir()
        if not calcDataDir:
            return False
        return check_calcDataDir_exists(calcDataDir)
    except:
        return False

def get_calcDataDir(silent=False):
    try:
        calcDataDir = compute_calcDataDir()
        if not calcDataDir or not check_calcDataDir_exists(calcDataDir):
            if not silent:
                show_calcdatadir_not_set_message(calcDataDir or "")
            return None
        return calcDataDir
    except:
        return None

def _detect_calcdata_subfolders(zf):
    subfolders = set()
    for name in zf.namelist():
        parts = name.split('/')
        # parts[1] muss ein echter Unterordner sein (mit Inhalt darunter),
        # keine lose Datei direkt unter klimascanner_calcdata/ (z.B. icon.png,
        # metadata.txt, __init__.py - Reste der alten Plugin-Huelle).
        if len(parts) >= 3 and parts[0] == 'klimascanner_calcdata' and parts[1]:
            subfolders.add(parts[1])
    return subfolders

def import_calc_data_zip(zip_path, progress_callback=None):
    try:
        if not zip_path or not os.path.isfile(zip_path):
            return False, "Die ausgewählte Datei wurde nicht gefunden."
        if not zipfile.is_zipfile(zip_path):
            return False, "Die ausgewählte Datei ist kein gültiges ZIP-Archiv."

        plugins_root = os.path.dirname(get_plugin_dir())

        with zipfile.ZipFile(zip_path, 'r') as zf:
            subfolders = _detect_calcdata_subfolders(zf)
            if len(subfolders) == 0:
                return False, ("Im ZIP-Archiv wurde kein 'klimascanner_calcdata/…'-Verzeichnis gefunden. "
                                "Bitte prüfen Sie, ob das richtige Archiv ausgewählt wurde.")
            if len(subfolders) > 1:
                return False, ("Das ZIP-Archiv enthält mehrere Datensätze ({}). Bitte ein Archiv mit "
                                "genau einem Kalkulationsdatensatz auswählen.").format(", ".join(sorted(subfolders)))

            detected_subfolder = next(iter(subfolders))
            settings = QgsSettings()
            settings.setValue("klimascanner/calcDataSubfolder", detected_subfolder)
            settings.sync()

            # Nur den klimascanner_calcdata-Teil entpacken, falls das Archiv
            # zusätzlich (z.B. bei einer kombinierten Auslieferungs-ZIP) auch
            # das Hauptplugin enthält - das darf hier nicht überschrieben werden.
            members = [n for n in zf.namelist() if n.startswith('klimascanner_calcdata/')]
            total_size = sum(zf.getinfo(m).file_size for m in members) or 1
            extracted_size = 0
            for member in members:
                if progress_callback and progress_callback(extracted_size, total_size, member) is False:
                    return False, "Import abgebrochen."
                zf.extract(member, plugins_root)
                extracted_size += zf.getinfo(member).file_size
            if progress_callback:
                progress_callback(total_size, total_size, "")

        if calc_data_available():
            return True, "Die Kalkulationsdaten wurden erfolgreich importiert."
        else:
            return False, ("Das ZIP-Archiv wurde entpackt, die erwarteten Kalkulationsdaten wurden "
                            "anschließend jedoch nicht gefunden. Bitte prüfen Sie, ob das richtige "
                            "Archiv für diese Lizenz ausgewählt wurde, oder kontaktieren Sie den Support.")
    except PermissionError:
        return False, "Keine Schreibrechte im QGIS-Plugin-Verzeichnis. Bitte QGIS ggf. als Administrator ausführen."
    except Exception as e:
        return False, "Fehler beim Import der Kalkulationsdaten: {}".format(str(e))
    
def get_config(calcDataDir, silent=False):
    try:
        configPath = os.path.join(calcDataDir+"config/config.json")
        print(configPath)
        with open(configPath, 'r', encoding='utf-8') as f:
            config = json.load(f)
        return config
    except:
        if not silent:
            show_config_not_found_message()
        return None
    
def check_license_is_valid(module):
        if module == "calculation":
            userActivity = "calcData"
        elif module == "picker":
            userActivity = "picker"
        licenseIsValid, meldung = Klimascanner_About.checkLicense(Klimascanner_About, userActivity=userActivity)
        if not licenseIsValid:
            if "machine count has exceeded maximum allowed" in meldung:
                count = int(meldung.split('(')[-1].split(')')[0])
                if module == "picker":
                    text = 'Fehler: Maximale Anzahl ({}) aktivierter Maschinen für diese Lizenz überschritten!\n\nPicker ohne gültige Lizenz mit nicht verwendbar!'.format(count)
                else:
                    text = 'Fehler: Maximale Anzahl ({}) aktivierter Maschinen für diese Lizenz überschritten!\n\nBerechnungen sind nicht möglich und werde ohne gültige Lizenz mit einer Fehlermeldung abgebrochen!'.format(count)
                title = "Fehler: Maximale Anzahl aktivierter Maschinen überschritten!"
            else:
                if module == "picker":
                    text = "Keine gültige Lizenz gefunden! \n\nBitte aktivieren Sie den Klimascanner mit einer gültigen Lizenz über den Menüpunkt \"Über Klimascanner\".\n\nPicker ohne gültige Lizenz mit nicht verwendbar!"
                else:
                    text = "Keine gültige Lizenz gefunden! \n\nBitte aktivieren Sie den Klimascanner mit einer gültigen Lizenz über den Menüpunkt \"Über Klimascanner\".\n\nBerechnungen sind nicht möglich und werde ohne gültige Lizenz mit einer Fehlermeldung abgebrochen!"
                text += "\n\nDetails: {}".format(meldung)
                title = "Fehler: Keine gültige Lizenz gefunden!"
            msg = QMessageBox()
            msg.setIcon(QMessageBox.Icon.Critical)
            msg.setText(text)
            msg.setWindowTitle(title)
            msg.exec()
            return False
        else:
            return True
        
def check_calcDataDir_exists(calcDataDir):
    if os.path.exists(calcDataDir):
        return True
    else:
        return False

def show_license_invalid_message():
    msg = QMessageBox()
    msg.setIcon(QMessageBox.Icon.Warning)
    msg.setWindowTitle("KLIMASCANNER - Lizenz ungültig")
    msg.setText("Die Lizenz für KLIMASCANNER ist ungültig. Bitte überprüfen Sie Ihre Lizenzangaben im Info-Dialog.")
    msg.setStandardButtons(QMessageBox.StandardButton.Ok)
    msg.exec()
    
def show_calcdatadir_not_set_message(calcDataDir):    
    if calcDataDir or calcDataDir != "":
        i = calcDataDir.lower().find("/python/")
        shortPath = calcDataDir[i+1:] if i != -1 else calcDataDir
    if shortPath == "" or shortPath is None:
        text = "Der Kalkulationsdatenpfad konnte nicht gefunden werden.\n\nBitte installieren Sie das Plugin erneut oder kontaktieren den Support."
    else:   
        text = ("Der Kalkulationsdatenpfad ('{}') konnte nicht gefunden werden.\n\n"
                "Bitte installieren Sie das Plugin erneut oder kontaktieren den Support.").format(".../" + shortPath)
    msg = QMessageBox()
    msg.setIcon(QMessageBox.Icon.Critical)
    msg.setWindowTitle("KLIMASCANNER - Kalkulationsdatenpfad  nicht gesetzt")
    msg.setText(text)
    msg.setStandardButtons(QMessageBox.StandardButton.Ok)
    msg.exec()

def show_config_not_found_message():
    msg = QMessageBox()
    msg.setIcon(QMessageBox.Icon.Critical)
    msg.setWindowTitle("KLIMASCANNER - Konfiguration nicht gefunden ")
    msg.setText("Die Konfigurationsdatei konte nicht gefunden werden.\n\nBitte installieren Sie das Plugin erneut oder kontaktieren den Support.")
    msg.setStandardButtons(QMessageBox.StandardButton.Ok)
    msg.exec()
    