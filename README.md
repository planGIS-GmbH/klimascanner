<p align="center">
  <img src="icon.png" alt="KLIMASCANNER" width="96">
</p>

<h1 align="center">KLIMASCANNER</h1>

<p align="center">
  KI-basiertes Screening-Instrument für Hitze und Kaltluft als QGIS-Plugin
</p>

<p align="center">
  <img src="https://img.shields.io/badge/QGIS-3.24%20bis%204.x-589632?logo=qgis&logoColor=white" alt="QGIS 3.24 bis 4.x">
  <img src="https://img.shields.io/badge/Qt-5%20%7C%206-41CD52?logo=qt&logoColor=white" alt="Qt 5 und 6">
  <img src="https://img.shields.io/badge/Version-2.2.0-blue" alt="Version 2.2.0">
  <img src="https://img.shields.io/badge/Lizenz-GPL%20v2%2B-lightgrey" alt="Lizenz GPL v2 oder neuer">
</p>

---

## Überblick

Mit dem KLIMASCANNER lassen sich die Auswirkungen von Anpassungs- und Stadtentwicklungsmaßnahmen auf das Stadtklima „auf Knopfdruck“ quantitativ ersteinschätzen. Betrachtet wird der Themenkomplex Thermischer Komfort mit Hitze und Kaltluft.

Grundlage der KI sind Trainingsdaten aus rund 100 Stadt- und Regionalklimaanalysen, die GEO-NET in den letzten Jahren mit dem Stadtklimamodell FITNAH-3D durchgeführt hat.
## Funktionen

| | Werkzeug | Beschreibung |
|:---:|---|---|
| <img src="icon_calculate.png" width="40"> | **Klimaberechnung** | Berechnet für einen Ist- und einen Planzustand die stadtklimatischen Kenngrößen und deren Differenz. |
| <img src="icon_picker.png" width="40"> | **Picker** | Bearbeitet Attributwerte wie Nutzungsklasse und Strukturhöhe direkt per Klick im Kartenfenster. |

Berechnete Kenngrößen:

| Kürzel | Kenngröße |
|---|---|
| PET14 | Physiologisch Äquivalente Temperatur um 14 Uhr |
| T14 | Lufttemperatur um 14 Uhr |
| T04 | Lufttemperatur um 4 Uhr |
| KLVSD | Kaltluftvolumenstromdichte |
| KPR | Kaltluftproduktionsrate |
| WS / WD | Windgeschwindigkeit und Windrichtung |

Die Ergebnisse werden als Raster mit passenden Darstellungsstilen direkt in QGIS geladen.
## Voraussetzungen

- QGIS 3.24 bis 4.x (Qt5 und Qt6)
- Eine gültige KLIMASCANNER-Lizenz
- Die Kalkulationsdaten (`klimascanner_calcdata`) für das jeweilige Untersuchungsgebiet
- Python-Abhängigkeiten, die das Plugin beim ersten Start bei Bedarf installiert:
  numpy, pandas, geopandas, rasterio, py-machineid, tensorflow, numba, certifi

## Installation

1. Plugin über das bereitgestellte Plugin-Repository installieren oder den Ordner `klimascanner/` in das QGIS-Plugin-Verzeichnis kopieren.
2. Kalkulationsdaten über das Repository installieren oder als ZIP-Archiv im Plugin importieren.
3. Plugin in QGIS unter *Erweiterungen → Erweiterungen verwalten und installieren* aktivieren.
4. Lizenzschlüssel unter *Erweiterungen → KLIMASCANNER → Über KLIMASCANNER* eintragen.

## Nutzung

- **Berechnung:** *Processing-Werkzeugkiste → KLIMASCANNER → Klimaberechnung*
- **Picker:** Werkzeug in der KLIMASCANNER-Werkzeugleiste aktivieren und Flächen im Kartenfenster anklicken

## Entwicklung

<table>
  <tr>
    <td align="center" width="50%">
      <a href="https://www.geo-net.de"><img src="docs/img/logo_geonet.jpg" alt="GEO-NET" height="80"></a><br><br>
      <a href="https://www.geo-net.de"><b>GEO-NET Umweltconsulting GmbH</b></a><br>
      Fachliche Konzeption, Stadtklimamodellierung mit FITNAH-3D und Trainingsdaten
    </td>
    <td align="center" width="50%">
      <a href="https://www.plangis.de"><img src="docs/img/logo_plangis.svg" alt="planGIS" height="40"></a><br><br>
      <a href="https://www.plangis.de"><b>planGIS GmbH</b></a><br>
      Software-Entwicklung des QGIS-Plugins
    </td>
  </tr>
  <tr>
    <td align="center">Kontakt: <a href="mailto:info@geo-net.de">info@geo-net.de</a></td>
    <td align="center">Kontakt: <a href="mailto:info@plangis.de">info@plangis.de</a></td>
  </tr>
</table>

## Lizenz

GNU General Public License v2 oder neuer
