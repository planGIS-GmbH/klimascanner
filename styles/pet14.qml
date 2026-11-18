<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis minScale="1e+08" hasScaleBasedVisibilityFlag="0" version="3.16.5-Hannover" maxScale="0" styleCategories="AllStyleCategories">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <temporal enabled="0" fetchMode="0" mode="0">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <customproperties>
    <property value="false" key="WMSBackgroundLayer"/>
    <property value="false" key="WMSPublishDataSourceUrl"/>
    <property value="0" key="embeddedWidgets/count"/>
    <property value="Value" key="identify/format"/>
  </customproperties>
  <pipe>
    <provider>
      <resampling enabled="false" zoomedInResamplingMethod="nearestNeighbour" zoomedOutResamplingMethod="nearestNeighbour" maxOversampling="2"/>
    </provider>
    <rasterrenderer classificationMin="23.4641991" alphaBand="-1" opacity="1" type="singlebandpseudocolor" classificationMax="47.8263016" band="1" nodataColor="0,0,0,255">
      <rasterTransparency/>
      <minMaxOrigin>
        <limits>MinMax</limits>
        <extent>WholeRaster</extent>
        <statAccuracy>Estimated</statAccuracy>
        <cumulativeCutLower>0.02</cumulativeCutLower>
        <cumulativeCutUpper>0.98</cumulativeCutUpper>
        <stdDevFactor>2</stdDevFactor>
      </minMaxOrigin>
      <rastershader>
        <colorrampshader colorRampType="DISCRETE" classificationMode="1" clip="0" labelPrecision="6" minimumValue="23.4641991" maximumValue="47.8263016">
          <colorramp type="gradient" name="[source]">
            <prop k="color1" v="43,131,186,255"/>
            <prop k="color2" v="215,25,28,255"/>
            <prop k="discrete" v="0"/>
            <prop k="rampType" v="gradient"/>
            <prop k="stops" v="0.25;171,221,164,255:0.5;255,255,191,255:0.75;253,174,97,255"/>
          </colorramp>
          <item label="&lt; 21 °C: keine Wärmebelastung" value="0" alpha="255" color="#2b83ba"/>
          <item label="21 - 23 °C: keine Wärmebelastung" value="23" alpha="255" color="#2b83ba"/>
          <item label="23 - 25 °C: schwache Wärmebelastung" value="25" alpha="255" color="#4b9ab5"/>
          <item label="25 - 27 °C: schwache Wärmebelastung" value="27" alpha="255" color="#75b7ad"/>
          <item label="27 - 29 °C: schwache Wärmebelastung" value="29" alpha="255" color="#9fd5a6"/>
          <item label="29 - 31 °C: mässige Wärmebelastung" value="31" alpha="255" color="#bfe5ab"/>
          <item label="31 - 33 °C: mässige Wärmebelastung" value="33" alpha="255" color="#dbf1b3"/>
          <item label="33 - 35 °C: mässige Wärmebelastung" value="35" alpha="255" color="#f7fcbc"/>
          <item label="35 - 37 °C: starke Wärmebelastung" value="37" alpha="255" color="#ffedaa"/>
          <item label="37 - 39 °C: starke Wärmebelastung" value="39" alpha="255" color="#fed38b"/>
          <item label="39 - 41 °C: starke Wärmebelastung" value="41" alpha="255" color="#feb86c"/>
          <item label="> 41 °C: extreme Wärmebelastung" value="90" alpha="255" color="#ee7145"/>
        </colorrampshader>
      </rastershader>
    </rasterrenderer>
    <brightnesscontrast brightness="0" contrast="0" gamma="1"/>
    <huesaturation colorizeOn="0" grayscaleMode="0" colorizeGreen="128" colorizeRed="255" colorizeBlue="128" saturation="0" colorizeStrength="100"/>
    <rasterresampler maxOversampling="2"/>
    <resamplingStage>resamplingFilter</resamplingStage>
  </pipe>
  <blendMode>0</blendMode>
</qgis>
