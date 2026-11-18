<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="AllStyleCategories" version="3.16.5-Hannover" maxScale="0" hasScaleBasedVisibilityFlag="0" minScale="1e+08">
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
    <property key="identify/format" value="Value"/>
  </customproperties>
  <pipe>
    <provider>
      <resampling enabled="false" zoomedInResamplingMethod="nearestNeighbour" zoomedOutResamplingMethod="nearestNeighbour" maxOversampling="2"/>
    </provider>
    <rasterrenderer opacity="1" type="singlebandpseudocolor" alphaBand="-1" classificationMin="-3" nodataColor="0,0,0,255" classificationMax="3" band="1">
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
        <colorrampshader labelPrecision="1" colorRampType="DISCRETE" minimumValue="-15.8000011" clip="0" classificationMode="2" maximumValue="22.6099987">
          <colorramp type="gradient" name="[source]">
            <prop k="color1" v="31,25,194,255"/>
            <prop k="color2" v="99,7,139,255"/>
            <prop k="discrete" v="0"/>
            <prop k="rampType" v="gradient"/>
            <prop k="stops" v="0.142857;24,132,215,255:0.285714;171,221,164,255:0.428571;255,255,125,255:0.571429;253,161,11,255:0.714286;253,10,2,255:0.855422;218,2,179,255"/>
          </colorramp>
          <item label="&lt; -15,0 m³/h/m²" alpha="255" value="-15" color="#b603a7"/>
          <item label="-15,0 - -10,0 m³/h/m²" alpha="255" value="-10" color="#fd1902"/>
          <item label="-10,0 - -5,0 m³/h/m²" alpha="255" value="-5" color="#fd8309"/>
          <item label="-5,0 - -3,0 m³/h/m²" alpha="255" value="-3" color="#fed044"/>
          <item label="keine Änderung" alpha="0" value="3" color="#fff3ac"/>
          <item label="3,0 - 5,0 m³/h/m²" alpha="255" value="5" color="#53a8c3"/>
          <item label="5,0 - 10,0 m³/h/m²" alpha="255" value="10" color="#1a64d1"/>
          <item label="10,0 - 15,0 m³/h/m²" alpha="255" value="15" color="#1f19c2"/>
          <item label="15,0 - 20,0 m³/h/m²" alpha="255" value="20" color="#0f1970"/>
          <item label="> 20,0 m³/h/m²" alpha="255" value="inf" color="#0b1352"/>
        </colorrampshader>
      </rastershader>
    </rasterrenderer>
    <brightnesscontrast contrast="0" brightness="0" gamma="1"/>
    <huesaturation colorizeRed="255" colorizeStrength="100" colorizeGreen="128" grayscaleMode="0" colorizeBlue="128" saturation="0" colorizeOn="0"/>
    <rasterresampler maxOversampling="2"/>
    <resamplingStage>resamplingFilter</resamplingStage>
  </pipe>
  <blendMode>0</blendMode>
</qgis>
