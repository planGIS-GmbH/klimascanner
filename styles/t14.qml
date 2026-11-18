<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis maxScale="0" styleCategories="AllStyleCategories" hasScaleBasedVisibilityFlag="0" version="3.16.5-Hannover" minScale="1e+08">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <temporal mode="0" enabled="0" fetchMode="0">
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
      <resampling maxOversampling="2" enabled="false" zoomedInResamplingMethod="nearestNeighbour" zoomedOutResamplingMethod="nearestNeighbour"/>
    </provider>
    <rasterrenderer band="1" classificationMax="36" type="singlebandpseudocolor" nodataColor="0,0,0,255" classificationMin="19" opacity="1" alphaBand="-1">
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
        <colorrampshader classificationMode="2" labelPrecision="1" maximumValue="36" colorRampType="DISCRETE" clip="0" minimumValue="19">
          <colorramp type="gradient" name="[source]">
            <prop v="0,14,170,255" k="color1"/>
            <prop v="77,4,16,255" k="color2"/>
            <prop v="0" k="discrete"/>
            <prop v="gradient" k="rampType"/>
            <prop v="0.2;52,178,236,255:0.5;247,247,34,255:0.65;227,95,33,255:0.8;255,0,0,255:0.9;85,4,20,255" k="stops"/>
          </colorramp>
          <item label="&lt; 19 °C" value="19" color="#000eaa" alpha="255"/>
          <item label="&lt; 20 °C" value="20" color="#0f3ebe" alpha="255"/>
          <item label="&lt; 21 °C" value="21" color="#1e6ed1" alpha="255"/>
          <item label="&lt; 22 °C" value="22" color="#2e9fe5" alpha="255"/>
          <item label="&lt; 23 °C" value="23" color="#4bbad5" alpha="255"/>
          <item label="&lt; 24 °C" value="24" color="#71c8ad" alpha="255"/>
          <item label="&lt; 25 °C" value="25" color="#98d685" alpha="255"/>
          <item label="&lt; 26 °C" value="26" color="#bee35d" alpha="255"/>
          <item label="&lt; 27 °C" value="27" color="#e4f136" alpha="255"/>
          <item label="&lt; 28 °C" value="28" color="#f4da21" alpha="255"/>
          <item label="&lt; 29 °C" value="29" color="#ec9e21" alpha="255"/>
          <item label="&lt; 30 °C" value="30" color="#e46221" alpha="255"/>
          <item label="&lt; 31 °C" value="31" color="#ee3b14" alpha="255"/>
          <item label="&lt; 32 °C" value="32" color="#f91607" alpha="255"/>
          <item label="&lt; 33 °C" value="33" color="#d70004" alpha="255"/>
          <item label="&lt; 34 °C" value="34" color="#730310" alpha="255"/>
          <item label="&lt; 35 °C" value="35" color="#520412" alpha="255"/>
          <item label="&lt; 36 °C" value="36" color="#4d0410" alpha="255"/>
        </colorrampshader>
      </rastershader>
    </rasterrenderer>
    <brightnesscontrast brightness="0" gamma="1" contrast="0"/>
    <huesaturation saturation="0" colorizeGreen="128" colorizeOn="0" colorizeBlue="128" grayscaleMode="0" colorizeRed="255" colorizeStrength="100"/>
    <rasterresampler maxOversampling="2"/>
    <resamplingStage>resamplingFilter</resamplingStage>
  </pipe>
  <blendMode>0</blendMode>
</qgis>
