<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis maxScale="0" styleCategories="AllStyleCategories" minScale="1e+08" hasScaleBasedVisibilityFlag="0" version="3.16.5-Hannover">
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
      <resampling zoomedInResamplingMethod="nearestNeighbour" zoomedOutResamplingMethod="nearestNeighbour" enabled="false" maxOversampling="2"/>
    </provider>
    <rasterrenderer alphaBand="-1" nodataColor="0,0,0,255"  band="1" opacity="1" type="singlebandpseudocolor" classificationMax="0.3" classificationMin="-0.5">
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
        <colorrampshader clip="0" minimumValue="-0.5" labelPrecision="1" classificationMode="1" colorRampType="DISCRETE" maximumValue="0.3">
          <colorramp name="[source]" type="gradient">
            <prop v="202,0,32,255" k="color1"/>
            <prop v="5,113,176,255" k="color2"/>
            <prop v="0" k="discrete"/>
            <prop v="gradient" k="rampType"/>
            <prop v="0.25;244,165,130,255:0.5;247,247,247,255:0.75;146,197,222,255" k="stops"/>
          </colorramp>
          <item alpha="255" color="#aa001c" value="-0.5" label="bis -0,5 m/s"/>
          <item alpha="255" color="#f58b5d" value="-0.3" label="> -0,5 bis -0,3 m/s"/>
          <item alpha="255" color="#ffb7b7" value="-0.1" label="> -0,3 bis -0,1 m/s"/>
          <item alpha="0" color="#ffffff" value="0.1" label="> -0,1 bis 0,1 m/s"/>
          <item alpha="255" color="#78ccfc" value="0.3" label="> 0,1 bis 0,3 m/s"/>
          <item alpha="255" color="#0571b0" value="inf" label="> 0,3 m/s"/>
        </colorrampshader>
      </rastershader>
    </rasterrenderer>
    <brightnesscontrast brightness="0" contrast="0" gamma="1"/>
    <huesaturation colorizeOn="0" saturation="0" colorizeRed="255" colorizeBlue="128" colorizeStrength="100" grayscaleMode="0" colorizeGreen="128"/>
    <rasterresampler maxOversampling="2"/>
    <resamplingStage>resamplingFilter</resamplingStage>
  </pipe>
  <blendMode>0</blendMode>
</qgis>
