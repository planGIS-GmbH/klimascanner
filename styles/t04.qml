<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis minScale="1e+08" maxScale="0" styleCategories="AllStyleCategories" version="3.16.5-Hannover" hasScaleBasedVisibilityFlag="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <temporal mode="0" fetchMode="0" enabled="0">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <customproperties>
    <property key="WMSBackgroundLayer" value="false"/>
    <property key="WMSPublishDataSourceUrl" value="false"/>
    <property key="embeddedWidgets/count" value="0"/>
    <property key="identify/format" value="Value"/>
  </customproperties>
  <pipe>
    <provider>
      <resampling maxOversampling="2" enabled="false" zoomedInResamplingMethod="nearestNeighbour" zoomedOutResamplingMethod="nearestNeighbour"/>
    </provider>
    <rasterrenderer nodataColor="0,0,0,255" classificationMin="12" type="singlebandpseudocolor" classificationMax="22" opacity="1" band="1" alphaBand="-1">
      <rasterTransparency/>
      <minMaxOrigin>
        <limits>None</limits>
        <extent>WholeRaster</extent>
        <statAccuracy>Estimated</statAccuracy>
        <cumulativeCutLower>0.02</cumulativeCutLower>
        <cumulativeCutUpper>0.98</cumulativeCutUpper>
        <stdDevFactor>2</stdDevFactor>
      </minMaxOrigin>
      <rastershader>
        <colorrampshader maximumValue="22" minimumValue="12" colorRampType="DISCRETE" labelPrecision="1" classificationMode="2" clip="0">
          <colorramp name="[source]" type="gradient">
            <prop v="27,37,229,255" k="color1"/>
            <prop v="248,251,248,255" k="color2"/>
            <prop v="0" k="discrete"/>
            <prop v="gradient" k="rampType"/>
            <prop v="0.146135;0,84,30,255:0.258454;102,250,22,255:0.390097;248,250,13,255:0.542271;234,159,19,255:0.706522;234,37,19,255:0.873188;103,19,24,255" k="stops"/>
          </colorramp>
          <item value="13" label="&lt;= 13,0 °C - Keine Wärmebelastung" alpha="255" color="#1b25e5"/>
          <item value="14" label="13,0 - 14,0 °C - Keine Überwärmung" alpha="255" color="#06494d"/>
          <item value="15" label="14,0 - 15,0 °C - Keine Überwärmung" alpha="255" color="#45c518"/>
          <item value="16" label="15,0 - 16,0 °C - Schwache Überwärmung" alpha="255" color="#b9fa10"/>
          <item value="17" label="16,0 - 17,0 °C - Mässige Überwärmung" alpha="255" color="#f3da0f"/>
          <item value="18" label="17,0 - 18,0 °C - Hohe Überwärmung" alpha="255" color="#ea9513"/>
          <item value="19" label="18,0 - 19,0 °C - Hohe Überwärmung" alpha="255" color="#ea4213"/>
          <item value="20" label="19,0 - 20,0 °C - Hohe Überwärmung" alpha="255" color="#b21d15"/>
          <item value="21" label="20,0 - 21,0 °C - Sehr hohe Überwärmung" alpha="255" color="#792f33"/>
          <item value="inf" label="> 21,0 °C - Sehr hohe Überwärmung" alpha="255" color="#9948ab"/>
        </colorrampshader>
      </rastershader>
    </rasterrenderer>
    <brightnesscontrast contrast="0" gamma="1" brightness="0"/>
    <huesaturation grayscaleMode="0" colorizeStrength="100" colorizeRed="255" colorizeGreen="128" colorizeBlue="128" saturation="0" colorizeOn="0"/>
    <rasterresampler maxOversampling="2"/>
    <resamplingStage>resamplingFilter</resamplingStage>
  </pipe>
  <blendMode>0</blendMode>
</qgis>
