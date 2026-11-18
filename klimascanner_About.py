from qgis.PyQt.QtWidgets import QDialogButtonBox, QMessageBox, QFileDialog, QProgressDialog, QApplication
from qgis.PyQt.QtCore import Qt
from qgis.core import QgsSettings, QgsMessageLog, Qgis
from processing.core.ProcessingConfig import ProcessingConfig
from .klimascanner_About_Dialog import Klimascanner_About_Dialog
import os, json
from .utils.icon_utils.icon_utils import *
import machineid
import requests
import certifi
import json
import socket
import os
import configparser
import traceback
import threading
import urllib

def _get_qgis_proxies():
    s = QgsSettings()
    if not s.value("proxy/proxyEnabled", False, type=bool):
        return {}
    proxy_type = s.value("proxy/proxyType", "")
    if proxy_type not in ("HttpProxy", "HttpCachingProxy", ""):
        return {}
    host = s.value("proxy/proxyHost", "")
    port = s.value("proxy/proxyPort", "")
    user = s.value("proxy/proxyUser", "")
    password = s.value("proxy/proxyPassword", "")
    if not host:
        return {}
    auth = "{}:{}@".format(user, password) if user else ""
    proxy_url = "http://{}{}:{}".format(auth, host, port)
    return {"http": proxy_url, "https": proxy_url}


class Klimascanner_About():

    # Liest die Konfigurationsdatei ein
    def readConfig(self, calcDataInputPath):
        try:
            with open(calcDataInputPath+'/config/config.json', 'r') as f:
                return json.load(f)
        except Exception as e:
            pass
            #print(e)

    def __init__(self, iface, on_calc_data_updated=None):
        """ Constructor. """
        self.dlg = Klimascanner_About_Dialog()
        self.iface = iface
        self.calcDataInputPath = ProcessingConfig.getSetting("CALCDATAINPUTFOLDER")
        self.config = self.readConfig(self.calcDataInputPath)
        self.repodata = {}
        self.on_calc_data_updated = on_calc_data_updated

    def readVersionFromMetadata(self):
        try:
            config = configparser.ConfigParser()
            config.read(os.path.join(os.path.dirname(__file__), 'metadata.txt'))
            return config['general']['version']
        except Exception as e:
            pass
            #print(e)
                  
    def readNameFromMetadata(self):
        try:
            config = configparser.ConfigParser()
            config.read(os.path.join(os.path.dirname(__file__), 'metadata.txt'))
            return config['general']['name']
        except Exception as e:
            pass
            #print(e)


    # Einstiegspunkt
    def run(self):
        self.dlg = Klimascanner_About_Dialog()
        
        version = self.readVersionFromMetadata()
        self.dlg.lVersion.setText('Version '+version)
        licenseCheck = False
        # Setzen aus Config
        licenseKey, licenseMail  = self.readSettings()
        if licenseKey != '':
            self.dlg.leLizenz.setText(licenseKey)
        if licenseMail != '':
            self.dlg.leMail.setText(licenseMail)

        self.machineid = machineid.hashed_id('klimascanner')
        self.dlg.leFingerprint.setText(self.machineid)

        connOk, connMsg = self.checkConnectivity()
        self.dlg.lConnectivity.setText(connMsg)
        if connOk:
            self.dlg.lConnectivity.setStyleSheet("color: green; font-weight: bold;")
        else:
            self.dlg.lConnectivity.setStyleSheet("color: red; font-weight: bold;")

        if licenseKey != '' and licenseMail != '':
            licenseCheck, checkMessage = self.checkLicense(licenseKey,self.machineid,licenseMail, userActivity="aboutDialog")
            if licenseCheck:
                self.dlg.lLizenzInfo.setText(checkMessage)
            else:
                readableMessage = self.generateReadableErrorMessage(checkMessage)
                self.dlg.lLizenzInfo.setText(readableMessage)


        self.dlg.lKlimascanner.setText("Klimascanner " + self.repodata["name"] if "name" in self.repodata else "Klimascanner")

        try:
            self.setup_plugin_repos()
        except Exception as e:
            pass
            #print("Fehler beim Einrichten des Plugin-Repositories:", str(e))

        self.updateCalcDataStatus()

        self.dlg.show()
        self.dlg.buttonBox.button(QDialogButtonBox.StandardButton.Ok).clicked.connect(self.storeSettings)
        self.dlg.buttonBox.button(QDialogButtonBox.StandardButton.Cancel).clicked.connect(self.dlg.close)
        self.dlg.btnImportCalcData.clicked.connect(self.importCalcData)


        self.dlg.exec()

    def updateCalcDataStatus(self):
        from .utils.license_utils.license_utils import calc_data_available
        if calc_data_available():
            self.dlg.lCalcDataStatus.setText("Kalkulationsdaten: gefunden")
            self.dlg.lCalcDataStatus.setStyleSheet("color: green; font-weight: bold;")
        else:
            self.dlg.lCalcDataStatus.setText("Kalkulationsdaten: nicht gefunden")
            self.dlg.lCalcDataStatus.setStyleSheet("color: red; font-weight: bold;")

    def importCalcData(self):
        from .utils.license_utils.license_utils import import_calc_data_zip
        zip_path, _ = QFileDialog.getOpenFileName(
            self.dlg, "Kalkulationsdaten-ZIP auswählen", "", "ZIP-Dateien (*.zip)")
        if not zip_path:
            return

        progress = QProgressDialog("Kalkulationsdaten werden importiert…", "Abbrechen", 0, 100, self.dlg)
        progress.setWindowTitle("Kalkulationsdaten-Import")
        progress.setWindowModality(Qt.WindowModality.WindowModal)
        progress.setMinimumDuration(0)
        progress.setValue(0)
        progress.show()

        def on_progress(done, total, filename):
            if progress.wasCanceled():
                return False
            progress.setValue(int(done * 100 / total) if total else 0)
            if filename:
                progress.setLabelText("Kalkulationsdaten werden importiert…\n" + filename)
            QApplication.processEvents()
            return True

        success, message = import_calc_data_zip(zip_path, progress_callback=on_progress)
        progress.close()

        msg = QMessageBox()
        if message == "Import abgebrochen.":
            msg.setIcon(QMessageBox.Icon.Warning)
        else:
            msg.setIcon(QMessageBox.Icon.Information if success else QMessageBox.Icon.Critical)
        msg.setWindowTitle("Kalkulationsdaten-Import")
        msg.setText(message)
        msg.exec()

        self.updateCalcDataStatus()

        if success and self.on_calc_data_updated:
            self.on_calc_data_updated()
        
    def generateReadableErrorMessage(self, checkMessage):              
        if checkMessage == 'license key is invalid':
            checkMessage = 'Lizenzschlüssel ungültig.\nBitte überprüfen Sie Ihre Eingaben.'
        if checkMessage == 'license key has expired':
            checkMessage = 'Lizenz abgelaufen.\nBitte wenden Sie sich an den Support.'
        if 'machine count has exceeded maximum allowed for license' in checkMessage:
            count = int(checkMessage.split('(')[-1].split(')')[0])
            checkMessage = 'Maximale Anzahl aktivierter Maschinen\n für diese Lizenz (max. {}) überschritten.'.format(count)
        if 'the requested endpoint was not found' in checkMessage:
            checkMessage = 'Endpunkt nicht gefunden.\nBitte wenden Sie sich an den Support.'
        if checkMessage == 'license key is revoked':
            checkMessage = 'Lizenz wurde widerrufen.\nBitte wenden Sie sich an den Support.'
        if checkMessage == 'license key is not yet valid':
            checkMessage = 'Lizenz noch nicht gültig.\nBitte wenden Sie sich an den Support.'
        if checkMessage == 'license has no available activations':
            checkMessage = 'Keine verfügbaren Aktivierungen mehr.'
        if checkMessage == 'license does not exist':
            checkMessage = 'Lizenz nicht gefunden.\nBitte überprüfen Sie Ihre Eingaben.'
        if checkMessage == 'license is suspended':
            checkMessage = 'Lizenz wurde gesperrt.\nBitte wenden Sie sich an den Support.'
            
        return checkMessage
        
    def setup_plugin_repos(self):
        REPONAME = self.repodata["name"]
        USERNAME = self.repodata["user"]
        PASSWORD = self.repodata["password"]
        URL = self.repodata["urlPlugin"]
        s = QgsSettings()
        path = 'app/plugin_repositories/{}'.format('Geo-Net Private Plugins ['+REPONAME+']')
        s.setValue(path + '/url',
                        URL.format(urllib.parse.quote_plus(USERNAME),  urllib.parse.quote_plus(PASSWORD),urllib.parse.quote_plus(USERNAME)))
        s.setValue(path + '/enabled', True)

    def storeSettings(self):
        licenseMail = self.dlg.leMail.text()
        licenseKey = self.dlg.leLizenz.text()
        s = QgsSettings()
        s.setValue("klimascanner/licenseMail", licenseMail)
        s.setValue("klimascanner/licenseKey", licenseKey)
        print("Setze Repodata und calcDataSubfolder")
        if self.repodata and "user" in self.repodata:
            s.setValue("klimascanner/calcDataSubfolder", self.repodata["user"])
        licenseCheck, errorMessage = self.checkLicense(licenseKey,self.machineid,licenseMail, userActivity="aboutDialog")


        self.dlg.close()
        if licenseCheck:
            msg = QMessageBox()
            msg.setIcon(QMessageBox.Icon.Information)
            msg.setText("Die Lizenz wurde erfolgreich aktiviert.")
            msg.setWindowTitle("Lizenz aktiviert!")
            msg.exec()
        else:
            readableMessage = self.generateReadableErrorMessage(errorMessage)
            msg = QMessageBox()
            msg.setIcon(QMessageBox.Icon.Critical)
            msg.setText("Fehler bei der Lizenzaktivierung:\n\n{}".format(readableMessage))
            msg.setWindowTitle("Lizenzaktivierung fehlgeschlagen!")
            msg.exec()


    def readSettings(self):
        s = QgsSettings()
        licsenseName = s.value("klimascanner/licenseMail")
        licsenseKey = s.value("klimascanner/licenseKey")
        return licsenseKey,licsenseName
        

    def checkConnectivity(self):
        try:
            requests.get("https://license.plangis.de", timeout=5, verify=certifi.where(), proxies=_get_qgis_proxies())
            return True, "OK"
        except requests.exceptions.SSLError:
            return False, "SSL-Fehler (Proxy/Firewall blockiert)"
        except requests.exceptions.ConnectionError:
            return False, "Nicht erreichbar (Firewall?)"
        except requests.exceptions.Timeout:
            return False, "Timeout (Firewall?)"
        except Exception as e:
            return False, "Fehler: {}".format(str(e))

    def checkLicense(self,licenseKey='',machineId='', licenseMail='', userActivity=None):
        # Versuche die Lizenz aus den Settings auszulesen
        s = QgsSettings()
        if licenseKey == '':
            licenseKey = s.value("klimascanner/licenseKey", "")
        if licenseMail == '':
            licenseMail = s.value("klimascanner/licenseMail", "")   
        if machineId == '':
            machineId = machineid.hashed_id('klimascanner')
        # Prüfung der Eingaben/ggf. auch nicht in Settings vorhanden
        if not licenseKey or licenseKey == '':
            # Diagnose fuer den Fall, dass QgsSettings() hier trotz vorhandener,
            # anderswo korrekt gelesener Lizenz leer zurueckkommt (z. B. Aufruf
            # aus initAlgorithm() ausserhalb des Haupt-Threads).
            QgsMessageLog.logMessage(
                "checkLicense: licenseKey aus QgsSettings ist leer (userActivity={}, thread={}, is_main_thread={})\n{}".format(
                    userActivity,
                    threading.current_thread().name,
                    threading.current_thread() is threading.main_thread(),
                    ''.join(traceback.format_stack()[-6:])
                ),
                "KLIMASCANNER", Qgis.MessageLevel.Warning
            )
            return False, "Keine Lizenz angegeben."
        if not machineId or machineId == '':
            return False, "Kein Maschinen-Fingerprint angegeben."
        
        if userActivity == "aboutDialog":
            userActivity = 100
        elif userActivity == "calcData":
            userActivity = 101
        elif userActivity == "picker":
            userActivity = 102
        else:
            userActivity = 0
        
        try:
            isFloatingLicense = False
            hostname = ''
            if not machineId:
                machineId = self.machineId
            try:
                hostname = socket.gethostname()
            except: 
                hostname = 'nicht ermittelbar'

            validation = requests.post(
                "https://license.plangis.de/v1/accounts/{}/licenses/actions/validate-key".format(
                    'fcc54b04-53bd-49c9-87ed-1a52c6debdbd'),
                headers={
                    "Content-Type": "application/vnd.api+json",
                    "Accept": "application/vnd.api+json"
                },
                data=json.dumps({
                    "meta": {
                        "scope": {"fingerprint": machineId},
                        "key": licenseKey,
                        "nonce": userActivity
                    }
                })
            ,verify=certifi.where(), proxies=_get_qgis_proxies()).json()

            if "errors" in validation:
                errs = validation["errors"]
                return False, "Lizenzaktivierung fehlgeschlagen: {}".format(
                    ','.join(
                        map(lambda e: "{} - {}".format(e["title"], e["detail"]).lower(), errs))
                )
                
            
            # Repodaten extrahieren    
            try:
                self.repodata = validation["data"]["attributes"]["metadata"]["repoData"]
                s.setValue("klimascanner/calcDataSubfolder", self.repodata["user"])
            except Exception:
                if "errors" in validation:
                    return False, "Lizenzaktivierung fehlgeschlagen: {}".format(
                    ','.join(
                        map(lambda e: "{} - {}".format(e["title"], e["detail"]).lower(), errs))
                )
                else:                 
                    return False, "Vermutlich Lizenz für Version 1.x verwendet.\nBitte Support kontaktieren!"
             
            try:
                if validation["data"]["attributes"]["floating"] == True:
                    isFloatingLicense = True
                else:
                    isFloatingLicense = False
                    
                maxMachineCount = validation["data"]["attributes"]["maxMachines"]
                currentMachineCount = validation["data"]["relationships"]["machines"]["meta"]["count"]
            except:
                pass

            # Versuchen den Namen/E-Mail anzupassen, wenn dieser geändert wurde
            try:
                if validation["data"]["attributes"]["name"] != licenseMail:
                    if licenseMail == '':
                        licenseMail = 'N/A'
                    
                        requests.patch(
                        "https://license.plangis.de/v1/accounts/{}/machines/{}".format(
                            'fcc54b04-53bd-49c9-87ed-1a52c6debdbd', machineId),
                        headers={
                            "Authorization": "License {}".format(licenseKey),
                            "Content-Type": "application/vnd.api+json",
                            "Accept": "application/vnd.api+json"
                        },
                        data=json.dumps({
                            "data": {
                                "type": "machines",
                                "id": machineId,
                                "attributes": {
                                    "name": licenseMail
                                }
                            }
                        })
                        ,verify=certifi.where(), proxies=_get_qgis_proxies()).json()
            except Exception:
                pass
                # print("Fehler beim Aktualisieren des Lizenznamens:", str(e))
                # print(traceback.format_exc())

            # If the license is valid for the current machine, that means it has
            # already been activated. We can return early.
            if validation["meta"]["valid"]:
                if isFloatingLicense:            
                    return True, "Lizenz (Floating {}/{}) aktiviert! ".format(currentMachineCount, maxMachineCount)
                else:
                    return True, "Lizenz (Einzelplatz) aktiviert! "

            # Otherwise, we need to determine why the current license is not valid,
            # because in our case it may be invalid because another machine has
            # already been activated, or it may be invalid because it doesn't
            # have any activated machines associated with it yet and in that case
            # we'll need to activate one.
            validation_code = validation["meta"]["code"]
            activation_is_required = validation_code == 'FINGERPRINT_SCOPE_MISMATCH' or \
                validation_code == 'NO_MACHINES' or \
                validation_code == 'NO_MACHINE'

            if not activation_is_required:
                return False, "license {}".format(validation["meta"]["detail"])

            # If we've gotten this far, then our license has not been activated yet,
            # so we should go ahead and activate the current machine.
            activation = requests.post(
                "https://license.plangis.de/v1/accounts/{}/machines".format(
                    'fcc54b04-53bd-49c9-87ed-1a52c6debdbd'),
                headers={
                    "Authorization": "License {}".format(licenseKey),
                    "Content-Type": "application/vnd.api+json",
                    "Accept": "application/vnd.api+json"
                },
                data=json.dumps({
                    "data": {
                        "type": "machines",
                        "attributes": {
                            "fingerprint": machineId,
                            "name": licenseMail,
                            "hostname": hostname
                        },
                        "relationships": {
                            "license": {
                                "data": {"type": "licenses", "id": validation["data"]["id"]}
                            }
                        }
                    }
                })
            ,verify=certifi.where(), proxies=_get_qgis_proxies()).json()

            # If we get back an error, our activation failed.
            if "errors" in activation:
                errs = activation["errors"]

                return False, "Lizenzaktivierung fehlgeschlagen: {}".format(
                    ','.join(
                        map(lambda e: "{} - {}".format(e["title"], e["detail"]).lower(), errs))
                )

            if isFloatingLicense:            
                return True, "Lizenz (Floating {}/{}) aktiviert! ".format(currentMachineCount, maxMachineCount)
            else:
                return True, "Lizenz (Einzelplatz) aktiviert! "
        except Exception:
            return False, "Netzwerkfehler: Lizenzserver nicht erreichbar."
        




