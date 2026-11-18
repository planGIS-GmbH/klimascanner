<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis minScale="1e+08" styleCategories="AllStyleCategories" maxScale="0" hasScaleBasedVisibilityFlag="0" version="3.16.5-Hannover">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <temporal fetchMode="0" enabled="0" mode="0">
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
      <resampling enabled="false" maxOversampling="2" zoomedInResamplingMethod="nearestNeighbour" zoomedOutResamplingMethod="nearestNeighbour"/>
    </provider>
    <rasterrenderer band="1" classificationMax="100" type="singlebandpseudocolor" alphaBand="-1" classificationMin="4" opacity="1" nodataColor="0,0,0,255">
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
        <colorrampshader classificationMode="1" maximumValue="100" labelPrecision="6" colorRampType="INTERPOLATED" clip="0" minimumValue="4">
          <colorramp type="gradient" name="[source]">
            <prop k="color1" v="247,251,255,255"/>
            <prop k="color2" v="8,48,107,255"/>
            <prop k="discrete" v="1"/>
            <prop k="rampType" v="gradient"/>
            <prop k="stops" v="0.111111;222,235,247,255:0.222222;198,219,239,255:0.333333;158,202,225,255:0.444444;107,174,214,255:0.555556;66,146,198,255:0.666667;33,113,181,255:0.777778;8,81,156,255:0.888889;8,48,107,255"/>
          </colorramp>
          <item label="&lt; 4 m²/s - Gering" value="4" alpha="255" color="#ffffff"/>
          <item label="4 bis &lt; 16 m²/s - Mässig" value="16" alpha="255" color="#9ecae1"/>
          <item label="16 bis &lt; 30 m²/s - hoch" value="30" alpha="255" color="#2171b5"/>
          <item label="30 bis 100 m²/s - Sehr hoch" value="100" alpha="255" color="#08306b"/>
        </colorrampshader>
      </rastershader>
    </rasterrenderer>
    <brightnesscontrast brightness="0" contrast="0" gamma="1"/>
    <huesaturation colorizeOn="0" colorizeRed="255" colorizeBlue="128" colorizeStrength="100" colorizeGreen="128" saturation="0" grayscaleMode="0"/>
    <rasterresampler maxOversampling="2"/>
    <resamplingStage>resamplingFilter</resamplingStage>
  </pipe>
  <blendMode>0</blendMode>
</qgis>
