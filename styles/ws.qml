<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.16.5-Hannover" maxScale="0" minScale="1e+08" hasScaleBasedVisibilityFlag="0" styleCategories="AllStyleCategories">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <temporal enabled="0" mode="0" fetchMode="0">
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
      <resampling zoomedInResamplingMethod="nearestNeighbour" enabled="false" maxOversampling="2" zoomedOutResamplingMethod="nearestNeighbour"/>
    </provider>
    <rasterrenderer nodataColor="0,0,0,255" opacity="1" band="1" alphaBand="-1" classificationMin="0.1" classificationMax="5" type="singlebandpseudocolor">
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
        <colorrampshader classificationMode="1" minimumValue="0.1" labelPrecision="6" colorRampType="DISCRETE" clip="0" maximumValue="5">
          <colorramp name="[source]" type="gradient">
            <prop v="247,251,255,255" k="color1"/>
            <prop v="8,48,107,255" k="color2"/>
            <prop v="0" k="discrete"/>
            <prop v="gradient" k="rampType"/>
            <prop v="0.13;222,235,247,255:0.26;198,219,239,255:0.39;158,202,225,255:0.52;107,174,214,255:0.65;66,146,198,255:0.78;33,113,181,255:0.9;8,81,156,255" k="stops"/>
          </colorramp>
          <item value="0.1" alpha="255" color="#ffffff" label="&lt; 0,1m/s"/>
          <item value="0.2" alpha="255" color="#deebf7" label="> 0,1 - 0,2m/s"/>
          <item value="0.3" alpha="255" color="#c6dbef" label="> 0,2 - 0,3m/s"/>
          <item value="0.5" alpha="255" color="#9ecae1" label="> 0,3 - 0,5m/s"/>
          <item value="0.7" alpha="255" color="#6baed6" label="> 0,5 - 0,7m/s"/>
          <item value="1" alpha="255" color="#4292c6" label="> 0,7 - 1,0 m/s"/>
          <item value="2" alpha="255" color="#2171b5" label="> 1,0 - 2,0 m/s"/>
          <item value="5" alpha="255" color="#1f00ff" label="> 2,0 - 5,0 m/s"/>
		  <item value="inf" alpha="255" color="#1800cc" label="> 5.0 m/s"/>
        </colorrampshader>
      </rastershader>
    </rasterrenderer>
    <brightnesscontrast contrast="0" brightness="0" gamma="1"/>
    <huesaturation colorizeBlue="128" colorizeStrength="100" saturation="0" grayscaleMode="0" colorizeOn="0" colorizeGreen="128" colorizeRed="255"/>
    <rasterresampler maxOversampling="2"/>
    <resamplingStage>resamplingFilter</resamplingStage>
  </pipe>
  <blendMode>0</blendMode>
</qgis>
