from qgis.PyQt.QtCore import QVariant
from qgis.PyQt.QtWidgets import QDialogButtonBox
from qgis.core import Qgis, QgsField, QgsMapLayer, QgsVectorLayer, QgsSettings, QgsMessageLog
from qgis.gui import QgsMapToolIdentify, QgsMapToolIdentifyFeature
from .klimascanner_Picker_Dialog import Klimascanner_Picker_Dialog
import os
import traceback
from .utils.icon_utils.icon_utils import *
from .utils.license_utils.license_utils import *


class Klimascanner_Picker(QgsMapToolIdentifyFeature):

    def __init__(self, canvas, layer, iface, pickerAction):
        """ Constructor. """
        self.dlg = Klimascanner_Picker_Dialog()
        self.canvas = canvas
        self.meldung = None
        self.pickerAction = pickerAction
        self.canvas.mapToolSet.connect(self.manageButton)
        self.layer = layer
        self.iface = iface
        self.attributesAdded = False
        super().__init__(self.canvas)

        # loads cursor form svg file
        self.setCursor(cursor_from_image(
            os.path.dirname(__file__) + "/pickerCursor.svg"))
        
        # event handler
        self.iface.currentLayerChanged.connect(self.active_changed)
        self.dlg.cbNutzClass.currentIndexChanged.connect(
            self.cbNutzClassChanged)
        self.dlg.buttonBox.button(
            QDialogButtonBox.StandardButton.Ok).clicked.connect(self.saveDialogValues)

    # trennt die in __init__ verbundenen Signale wieder (bei Plugin-Unload aufzurufen)
    def unload(self):
        try:
            self.canvas.mapToolSet.disconnect(self.manageButton)
        except (TypeError, RuntimeError):
            pass
        try:
            self.iface.currentLayerChanged.disconnect(self.active_changed)
        except (TypeError, RuntimeError):
            pass

    # controls the disply of the button iif tool is switched
    def manageButton(self, selectedTool):
        if selectedTool == self:
            self.pickerAction.setChecked(True)
        else:
            self.pickerAction.setChecked(False)

    # is processed if layer in layer tree is switched
    def active_changed(self, layer):
        try:
            if (self.layer and self.layer != None and self.layer.type() == QgsMapLayer.LayerType.VectorLayer):
                self.layer.removeSelection()
            if isinstance(layer, QgsVectorLayer) and layer.isSpatial():
                self.layer = layer
                self.setLayer(self.layer)
        except Exception:
            self.layer = layer
            QgsMessageLog.logMessage(traceback.format_exc(), "KLIMASCANNER", Qgis.MessageLevel.Warning)

    # overwritten from QGSMAPTOOLIDENTIFYFEATURE -> is automatically called if user clicks on the map
    def canvasPressEvent(self, event):
        try:
            if (self.layer is not None and self.layer.type() == QgsMapLayer.LayerType.VectorLayer):
                self.layer.removeSelection()

                # results ordered bottom to top — last element is the topmost visible feature
                results = self.identify(
                    event.pos().x(), event.pos().y(),
                    [self.layer],
                    QgsMapToolIdentify.IdentifyMode.TopDownAll
                )

                if results:
                    # „top / highest“ visible feature is the last element
                    topmost = results[-1].mFeature
                    self.layer.selectByIds([topmost.id()])

                    # optional: apply style
                    self.layer.loadNamedStyle(self.calcDataDir + '/styles/inputlayer.qml')

                    self.startPicker()
                else:
                    # no hit
                    pass
            else:
                self.iface.messageBar().pushMessage(
                    "Aktiver Layer ist kein Vektorlayer.",
                    "Auswahl benötigt aktiven Vektorlayer!",
                    level=Qgis.MessageLevel.Warning, duration=3
                )
        except Exception:
            QgsMessageLog.logMessage(traceback.format_exc(), "KLIMASCANNER", Qgis.MessageLevel.Warning)

    # injection point
    def run(self):       
        licsenseValid = check_license_is_valid("picker")
        if not licsenseValid:
            return None
        else:
            self.calcDataDir = get_calcDataDir()
            if not self.calcDataDir:
                return None
            else:
                config = get_config(self.calcDataDir)
                if not config:
                    return None
                self.nutzClassList = config['nutzungsklassen']
                self.strukturHoehenList = config['strukturhoehen']
                self.nutzStrList = {}
                for n in self.nutzClassList:
                    self.nutzStrList[int(self.nutzClassList[n])] = int(
                        self.strukturHoehenList[n])
            
            self.canvas.setMapTool(self)

    # start picker
    def startPicker(self):
        if (self.layer is None):
            self.iface.messageBar().pushMessage("Kein aktiver Layer vorhanden:",
                                                "Es konnte kein aktiver Layer gefunden werden.", level=Qgis.MessageLevel.Warning, duration=3)
        else:
            if (self.layer.selectedFeatureCount() == 1):
                if (self.layer):
                    self.checkAttributes(self.layer)
                    selectedFeature = self.layer.getSelectedFeatures()
                    self.feature = self.getFirstFeature(selectedFeature)
                    if (self.attributesAvailable(self.layer)):
                        self.showPickerDialog()
                    else:
                        if (self.dialogSetAttributes(self.layer)):
                            self.showPickerDialog()
            # 0: do nothing
            # > 1: should not happen, but stays here as fallback
            elif (self.layer.selectedFeatureCount() > 1):
                self.iface.messageBar().pushMessage("Mehrfachauswahl erkannt:",
                                                    "Es wurde mehr als ein Polygon selektiert. Es wird das erste verwendet.", level=Qgis.MessageLevel.Info, duration=3)
                # only use first feature
                selectedFeature = self.layer.getSelectedFeatures()
                self.feature = self.getFirstFeature(selectedFeature)
                
                # reduce selection to first feature
                self.layer.selectByIds([self.feature.id()])
                if (self.attributesAvailable(self.layer)):
                    self.showPickerDialog()
                else:
                    if (self.dialogSetAttributes(self.layer)):
                        self.showPickerDialog()

    # returns the frst feature that has been found
    def getFirstFeature(self, feats):
        for f in feats:
            return f

    # shows dialog of picker
    def showPickerDialog(self):
        self.initPickerDialog()
        self.dlg.show()

    # saves values from dialog in attribute table
    def saveDialogValues(self):
        self.layer.startEditing()
        self.layer.changeAttributeValue(self.feature.id(), self.layer.fields().indexFromName('Name'), str(self.dlg.leName.text()))
        self.layer.changeAttributeValue(self.feature.id(), self.layer.fields().indexFromName('Nutz'), int(self.nutzClassList[self.dlg.cbNutzClass.currentText()]))
        self.layer.changeAttributeValue(self.feature.id(), self.layer.fields().indexFromName('Hoehe'), str(self.dlg.sbHoehe.value()))
        self.layer.changeAttributeValue(self.feature.id(), self.layer.fields().indexFromName('Bemerkung'), str(self.dlg.teBemerkung.toPlainText()))
        self.layer.commitChanges()
        self.layer.updateFields()

    # initializes the picker dialog
    def initPickerDialog(self):
        self.checkAttributes(self.layer)
        
        if (self.feature['Name'] == None):
            self.dlg.leName.clear()
        else:
            self.dlg.leName.setText(str(self.feature['Name']))
        
        if (self.feature['Hoehe'] == None):
            self.dlg.sbHoehe.setValue(0)
        else:
            hoehe = int(self.feature['Hoehe'])
            self.dlg.sbHoehe.setValue(hoehe)
        
        if (self.feature['Bemerkung'] == None):
            self.dlg.teBemerkung.clear()
        else:
            self.dlg.teBemerkung.setText(str(self.feature['Bemerkung']))
        
        self.dlg.cbNutzClass.clear()
        
        for nc in self.nutzClassList:
            self.dlg.cbNutzClass.addItem(nc)
        
        if (self.feature['Nutz'] != None):
            self.dlg.cbNutzClass.setCurrentIndex(
                self.getNutzClassIndex(str(self.feature['Nutz'])))

    # returns the index from the combo box based on the land use class (int)
    def getNutzClassIndex(self, nutzClass):
        i = 0
        for value in self.nutzClassList.values():
            if (int(value) == int(nutzClass)):
                return i
            i = i+1
        return -1

    # handles the structure heights when the usage class combo box is changed
    def cbNutzClassChanged(self):
        if (self.dlg.cbNutzClass.currentText() != ''):
            curNutzClass = int(self.nutzClassList[self.dlg.cbNutzClass.currentText()])
            
            if (self.nutzStrList[curNutzClass] == -1):
                print("Gebäude")
                self.dlg.sbHoehe.setEnabled(True)
                self.dlg.sbHoehe.setRange(2, 50)
                self.dlg.sbHoehe.setValue(5)
                
                if (self.feature['Hoehe']):
                    self.dlg.sbHoehe.setValue(int(self.feature['Hoehe']))
            
            elif (self.nutzStrList[curNutzClass] == -2):
                self.dlg.sbHoehe.setEnabled(True)
                self.dlg.sbHoehe.setRange(6, 30)
                self.dlg.sbHoehe.setValue(12)
                
                if (self.feature['Hoehe']):
                    self.dlg.sbHoehe.setValue(int(self.feature['Hoehe']))
            
            else:
                self.dlg.sbHoehe.setRange(0, 50)
                self.dlg.sbHoehe.setEnabled(False)
                self.dlg.sbHoehe.setValue(self.nutzStrList[curNutzClass])

    # checks whether the necessary fields in the attribute table are existing
    def attributesAvailable(self, layer):
        layer.updateFields()
        if layer.fields().indexFromName('Name') == -1:
            return False
        elif layer.fields().indexFromName('Hoehe') == -1:
            return False
        elif layer.fields().indexFromName('Nutz') == -1:
            return False
        elif layer.fields().indexFromName('Bemerkung') == -1:
            return False
        else:
            return True

    # adds possibly missing fields in attribute table
    def checkAttributes(self, layer):
        self.checkAttributeString('Name', layer)
        self.checkAttributeDouble('Hoehe', layer)
        self.checkAttributeInteger('Nutz', layer)
        self.checkAttributeString('Bemerkung', layer)

        if self.attributesAdded == True:
            self.iface.messageBar().pushMessage("Attribute angelegt:",
                                                "Die erforderlichen Attribute wurden erfogreich angelegt.", level=Qgis.MessageLevel.Success, duration=3)
            self.attributesAdded = False
        
        layer.commitChanges()
        layer.updateFields()

    # checks attribute fields of type double
    def checkAttributeDouble(self, fieldName, layer):
        layer_provider = layer.dataProvider()
        if layer.fields().indexFromName(fieldName) == -1:
            self.attributesAdded = True
            layer_provider.addAttributes(
                [QgsField(fieldName, QVariant.Double)])

    # checks attribute fields of type int
    def checkAttributeInteger(self, fieldName, layer):
        layer_provider = layer.dataProvider()
        if layer.fields().indexFromName(fieldName) == -1:
            self.attributesAdded = True
            layer_provider.addAttributes([QgsField(fieldName, QVariant.Int)])

    # checks attribute fields of type string
    def checkAttributeString(self, fieldName, layer):
        layer_provider = layer.dataProvider()
        if layer.fields().indexFromName(fieldName) == -1:
            self.attributesAdded = True
            layer_provider.addAttributes(
                [QgsField(fieldName, QVariant.String)])

    # uncalled functions below

    # converts comma to point (conversion of decimal separators)
    def convertFromMetric(self, string):
        return string.replace(",", ".")

    # converts point to comma (conversion of decimal separators)
    def convert2Metric(self, string):
        return string.replace(".", ",")
