<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.16.5-Hannover" styleCategories="AllStyleCategories" minScale="1e+08" maxScale="0" hasScaleBasedVisibilityFlag="0">
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
      <resampling maxOversampling="2" enabled="false" zoomedOutResamplingMethod="nearestNeighbour" zoomedInResamplingMethod="nearestNeighbour"/>
    </provider>
    <rasterrenderer nodataColor="0,0,0,255"  type="singlebandpseudocolor" classificationMin="-20" band="1" classificationMax="20" alphaBand="-1" opacity="0.7">
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
        <colorrampshader labelPrecision="0" classificationMode="1" colorRampType="DISCRETE" clip="0" maximumValue="20" minimumValue="-20">
          <colorramp name="[source]" type="gradient">
            <prop v="202,0,32,255" k="color1"/>
            <prop v="5,113,176,255" k="color2"/>
            <prop v="0" k="discrete"/>
            <prop v="gradient" k="rampType"/>
            <prop v="0.25;244,165,130,255:0.5;247,247,247,255:0.75;146,197,222,255" k="stops"/>
          </colorramp>
          <item value="-20" alpha="255" color="#ca0020" label="bis -20 % - Hoch"/>
          <item value="-10" alpha="255" color="#f4a582" label="> -20 bis -10 % - Hoch"/>
          <item value="-5" alpha="255" color="#f6cebd" label="> -10 bis -5 % - Mässig"/>
          <item value="5" alpha="0" color="#ffffff" label="> -5 bis 5 % - Gering"/>
          <item value="10" alpha="255" color="#c5deeb" label="> 5 bis 10 %"/>
          <item value="20" alpha="255" color="#0571b0" label="> 10 bis 20 %"/>
          <item value="inf" alpha="255" color="#0571b0" label="> 20 %"/>
        </colorrampshader>
      </rastershader>
    </rasterrenderer>
    <brightnesscontrast contrast="0" brightness="0" gamma="1"/>
    <huesaturation grayscaleMode="0" colorizeOn="0" colorizeBlue="128" saturation="0" colorizeRed="255" colorizeStrength="100" colorizeGreen="128"/>
    <rasterresampler maxOversampling="2"/>
    <resamplingStage>resamplingFilter</resamplingStage>
  </pipe>
  <blendMode>0</blendMode>
</qgis>
