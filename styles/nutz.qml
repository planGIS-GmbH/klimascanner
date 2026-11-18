<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis minScale="1e+08" maxScale="0" styleCategories="AllStyleCategories" version="3.16.2-Hannover" hasScaleBasedVisibilityFlag="0">
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
    <property value="false" key="WMSBackgroundLayer"/>
    <property value="false" key="WMSPublishDataSourceUrl"/>
    <property value="0" key="embeddedWidgets/count"/>
    <property value="Value" key="identify/format"/>
  </customproperties>
  <pipe>
    <provider>
      <resampling enabled="false" zoomedOutResamplingMethod="nearestNeighbour" maxOversampling="2" zoomedInResamplingMethod="nearestNeighbour"/>
    </provider>
    <rasterrenderer band="1" type="paletted" nodataColor="" opacity="1" alphaBand="-1">
      <rasterTransparency/>
      <minMaxOrigin>
        <limits>None</limits>
        <extent>WholeRaster</extent>
        <statAccuracy>Estimated</statAccuracy>
        <cumulativeCutLower>0.02</cumulativeCutLower>
        <cumulativeCutUpper>0.98</cumulativeCutUpper>
        <stdDevFactor>2</stdDevFactor>
      </minMaxOrigin>
      <colorPalette>
        <paletteEntry alpha="255" label="7 - Gleisfläche" color="#e8beff" value="7"/>
        <paletteEntry alpha="255" label="9 - Freiland, Rasen" color="#ffffbe" value="9"/>
        <paletteEntry alpha="255" label="14 - Gewässer" color="#00c5ff" value="14"/>
        <paletteEntry alpha="255" label="20 - Gebäude" color="#000000" value="20"/>
        <paletteEntry alpha="255" label="21 - Gebäude mit Dachbegrünung" color="#264200" value="21"/>
        <paletteEntry alpha="255" label="22 - unbebaut versiegelt" color="#9c9c9c" value="22"/>
        <paletteEntry alpha="255" label="23 - teilversiegelter Boden" color="#ffd37f" value="23"/>
        <paletteEntry alpha="255" label="24 - Baum über Versiegelung" color="#268000" value="24"/>
        <paletteEntry alpha="255" label="25 - Baum über Rasen" color="#38d200" value="25"/>
        <paletteEntry alpha="255" label="26 - Baum über teilversiegeltem Boden" color="#a3ff73" value="26"/>
        <paletteEntry alpha="255" label="28 - Sand" color="#ffff65" value="28"/>
      </colorPalette>
      <colorramp name="[source]" type="randomcolors"/>
    </rasterrenderer>
    <brightnesscontrast contrast="0" gamma="1" brightness="0"/>
    <huesaturation colorizeOn="0" colorizeStrength="100" saturation="0" colorizeGreen="128" grayscaleMode="0" colorizeRed="255" colorizeBlue="128"/>
    <rasterresampler maxOversampling="2"/>
    <resamplingStage>resamplingFilter</resamplingStage>
  </pipe>
  <blendMode>0</blendMode>
</qgis>
