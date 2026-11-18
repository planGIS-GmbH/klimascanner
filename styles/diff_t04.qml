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
    <rasterrenderer nodataColor="0,0,0,255" type="singlebandpseudocolor" classificationMin="-3" band="1" classificationMax="3" alphaBand="-1" opacity="1">
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
        <colorrampshader labelPrecision="1" classificationMode="1" colorRampType="DISCRETE" clip="0" maximumValue="3" minimumValue="-3">
          <colorramp name="[source]" type="gradient">
            <prop v="0,14,170,255" k="color1"/>
            <prop v="77,4,16,255" k="color2"/>
            <prop v="0" k="discrete"/>
            <prop v="gradient" k="rampType"/>
            <prop v="0.2;52,178,236,255:0.5;247,247,34,255:0.65;227,95,33,255:0.8;255,0,0,255:0.9;85,4,20,255" k="stops"/>
          </colorramp>
          <item value="-500" alpha="255" color="#2b97e1" label="&lt; -5,0 °C"/>
          <item value="-2" alpha="255" color="#54becb" label="> -5,0 bis -2,0 °C"/>
          <item value="-1.5" alpha="255" color="#8bd192" label="> -2,0 bis -1,5 °C"/>
          <item value="-1" alpha="255" color="#c1e45a" label="> -1,5 bis -1,0 °C"/>
          <item value="-0.5" alpha="255" color="#edf42d" label="> -1,0 bis -0,5 °C"/>
          <item value="0.5" alpha="0" color="#ffffff" label="> -0,5 bis 0,5 °C"/>
          <item value="1" alpha="255" color="#eca321" label="> 0,5 bis 1,0 °C"/>
          <item value="1.5" alpha="255" color="#e7541d" label="> 1,0 bis 1,5 °C"/>
          <item value="2" alpha="255" color="#f61f0b" label="> 1,5 bis 2,0 °C"/>
          <item value="2.5" alpha="255" color="#c70106" label="> 2,0 bis 2,5 °C"/>
          <item value="5" alpha="255" color="#72006c" label="> 2,5 bis 5,0 °C"/>
		  <item value="500" alpha="255" color="#450042" label="> 5,0 °C"/>
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
