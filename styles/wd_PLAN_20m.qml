<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.0.0" styleCategories="Symbology|Labeling|Rendering" hasScaleBasedVisibilityFlag="0" maxScale="0" minScale="4000" symbologyReferenceScale="-1" labelsEnabled="0" simplifyDrawingHints="0" simplifyDrawingTol="1" simplifyAlgorithm="0" simplifyMaxScale="1" simplifyLocal="1">
  <renderer-v2 enableorderby="0" attr="WS" forceraster="0" symbollevels="0" graduatedMethod="GraduatedSize" referencescale="-1" type="graduatedSymbol">
    <ranges>
      <range upper="0.100000000000000" symbol="0" uuid="0" render="true" lower="0.000000000000000" label="&lt; 0,1 m/s"/>
      <range upper="0.200000000000000" symbol="1" uuid="1" render="true" lower="0.100000000000000" label="&gt; 0,1 - 0,2 m/s"/>
      <range upper="0.300000000000000" symbol="2" uuid="2" render="true" lower="0.200000000000000" label="&gt; 0,2 - 0,3 m/s"/>
      <range upper="0.500000000000000" symbol="3" uuid="3" render="true" lower="0.300000000000000" label="&gt; 0,3 - 0,5 m/s"/>
      <range upper="0.700000000000000" symbol="4" uuid="4" render="true" lower="0.500000000000000" label="&gt; 0,5 - 0,7 m/s"/>
      <range upper="1.000000000000000" symbol="5" uuid="5" render="true" lower="0.700000000000000" label="&gt; 0,7 - 1,0 m/s"/>
      <range upper="2.000000000000000" symbol="6" uuid="6" render="true" lower="1.000000000000000" label="&gt; 1,0 - 2,0 m/s"/>
      <range upper="5.000000000000000" symbol="7" uuid="7" render="true" lower="2.000000000000000" label="&gt; 2,0 - 5,0 m/s"/>
      <range upper="1000000000000.000000000000000" symbol="8" uuid="8" render="true" lower="5.000000000000000" label="&gt; 5,0 m/s"/>
    </ranges>
    <symbols>
      <symbol frame_rate="10" alpha="1" is_animated="0" name="0" force_rhr="0" clip_to_extent="1" type="marker">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" value="" type="QString"/>
            <Option name="properties"/>
            <Option name="type" value="collection" type="QString"/>
          </Option>
        </data_defined_properties>
        <layer enabled="1" class="SimpleMarker" locked="0" id="{906f1901-8a1d-4f7c-ae1a-58f84268b175}" pass="0">
          <Option type="Map">
            <Option name="angle" value="0" type="QString"/>
            <Option name="cap_style" value="square" type="QString"/>
            <Option name="color" value="255,255,255,255,rgb:1,1,1,1" type="QString"/>
            <Option name="horizontal_anchor_point" value="1" type="QString"/>
            <Option name="joinstyle" value="bevel" type="QString"/>
            <Option name="name" value="arrow" type="QString"/>
            <Option name="offset" value="0,0" type="QString"/>
            <Option name="offset_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="offset_unit" value="MM" type="QString"/>
            <Option name="outline_color" value="35,35,35,255,rgb:0.13725490196078433,0.13725490196078433,0.13725490196078433,1" type="QString"/>
            <Option name="outline_style" value="solid" type="QString"/>
            <Option name="outline_width" value="0" type="QString"/>
            <Option name="outline_width_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="outline_width_unit" value="MM" type="QString"/>
            <Option name="scale_method" value="diameter" type="QString"/>
            <Option name="size" value="0" type="QString"/>
            <Option name="size_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="size_unit" value="MM" type="QString"/>
            <Option name="vertical_anchor_point" value="1" type="QString"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" value="" type="QString"/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="field" value="WD" type="QString"/>
                  <Option name="type" value="2" type="int"/>
                </Option>
                <Option name="size" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="expression" value="with_variable(&#xd;&#xa;    'basis',&#xd;&#xa;    CASE                        &#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.1 THEN 0&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.2 THEN 1&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.3 THEN 2&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.5 THEN 3&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.7 THEN 4&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 1.0 THEN 5&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 2.0 THEN 6&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 5.0 THEN 7&#xd;&#xa;        ELSE 8&#xd;&#xa;    END,&#xd;&#xa;&#xd;&#xa;    with_variable(&#xd;&#xa;        'zoomfaktor',&#xd;&#xa;        CASE&#xd;&#xa;            WHEN @map_scale &lt;= 1000 THEN 1.0&#xd;&#xa;            WHEN @map_scale &lt;= 2000 THEN 1.2&#xd;&#xa;            WHEN @map_scale &lt;= 3000 THEN 1.4&#xd;&#xa;            WHEN @map_scale &lt;= 5000 THEN 1.6&#xd;&#xa;            WHEN @map_scale &lt;= 8000 THEN 1.8&#xd;&#xa;            WHEN @map_scale &lt;= 10000 THEN 2.0&#xd;&#xa;            WHEN @map_scale &lt;= 20000 THEN 2.3&#xd;&#xa;            ELSE 2.6&#xd;&#xa;        END,&#xd;&#xa;&#xd;&#xa;        CASE&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 20000 THEN&#xd;&#xa;                @basis * @zoomfaktor&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 25000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 9 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 30000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 11 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 40000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 14 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            ELSE&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 18 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;        END&#xd;&#xa;    )&#xd;&#xa;)" type="QString"/>
                  <Option name="type" value="3" type="int"/>
                </Option>
              </Option>
              <Option name="type" value="collection" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol frame_rate="10" alpha="1" is_animated="0" name="1" force_rhr="0" clip_to_extent="1" type="marker">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" value="" type="QString"/>
            <Option name="properties"/>
            <Option name="type" value="collection" type="QString"/>
          </Option>
        </data_defined_properties>
        <layer enabled="1" class="SimpleMarker" locked="0" id="{906f1901-8a1d-4f7c-ae1a-58f84268b175}" pass="0">
          <Option type="Map">
            <Option name="angle" value="0" type="QString"/>
            <Option name="cap_style" value="square" type="QString"/>
            <Option name="color" value="255,255,255,255,rgb:1,1,1,1" type="QString"/>
            <Option name="horizontal_anchor_point" value="1" type="QString"/>
            <Option name="joinstyle" value="bevel" type="QString"/>
            <Option name="name" value="arrow" type="QString"/>
            <Option name="offset" value="0,0" type="QString"/>
            <Option name="offset_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="offset_unit" value="MM" type="QString"/>
            <Option name="outline_color" value="35,35,35,255,rgb:0.13725490196078433,0.13725490196078433,0.13725490196078433,1" type="QString"/>
            <Option name="outline_style" value="solid" type="QString"/>
            <Option name="outline_width" value="0" type="QString"/>
            <Option name="outline_width_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="outline_width_unit" value="MM" type="QString"/>
            <Option name="scale_method" value="diameter" type="QString"/>
            <Option name="size" value="1" type="QString"/>
            <Option name="size_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="size_unit" value="MM" type="QString"/>
            <Option name="vertical_anchor_point" value="1" type="QString"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" value="" type="QString"/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="field" value="WD" type="QString"/>
                  <Option name="type" value="2" type="int"/>
                </Option>
                <Option name="size" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="expression" value="with_variable(&#xd;&#xa;    'basis',&#xd;&#xa;    CASE                        &#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.1 THEN 0&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.2 THEN 1&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.3 THEN 2&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.5 THEN 3&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.7 THEN 4&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 1.0 THEN 5&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 2.0 THEN 6&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 5.0 THEN 7&#xd;&#xa;        ELSE 8&#xd;&#xa;    END,&#xd;&#xa;&#xd;&#xa;    with_variable(&#xd;&#xa;        'zoomfaktor',&#xd;&#xa;        CASE&#xd;&#xa;            WHEN @map_scale &lt;= 1000 THEN 1.0&#xd;&#xa;            WHEN @map_scale &lt;= 2000 THEN 1.2&#xd;&#xa;            WHEN @map_scale &lt;= 3000 THEN 1.4&#xd;&#xa;            WHEN @map_scale &lt;= 5000 THEN 1.6&#xd;&#xa;            WHEN @map_scale &lt;= 8000 THEN 1.8&#xd;&#xa;            WHEN @map_scale &lt;= 10000 THEN 2.0&#xd;&#xa;            WHEN @map_scale &lt;= 20000 THEN 2.3&#xd;&#xa;            ELSE 2.6&#xd;&#xa;        END,&#xd;&#xa;&#xd;&#xa;        CASE&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 20000 THEN&#xd;&#xa;                @basis * @zoomfaktor&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 25000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 9 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 30000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 11 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 40000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 14 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            ELSE&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 18 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;        END&#xd;&#xa;    )&#xd;&#xa;)" type="QString"/>
                  <Option name="type" value="3" type="int"/>
                </Option>
              </Option>
              <Option name="type" value="collection" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol frame_rate="10" alpha="1" is_animated="0" name="2" force_rhr="0" clip_to_extent="1" type="marker">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" value="" type="QString"/>
            <Option name="properties"/>
            <Option name="type" value="collection" type="QString"/>
          </Option>
        </data_defined_properties>
        <layer enabled="1" class="SimpleMarker" locked="0" id="{906f1901-8a1d-4f7c-ae1a-58f84268b175}" pass="0">
          <Option type="Map">
            <Option name="angle" value="0" type="QString"/>
            <Option name="cap_style" value="square" type="QString"/>
            <Option name="color" value="255,255,255,255,rgb:1,1,1,1" type="QString"/>
            <Option name="horizontal_anchor_point" value="1" type="QString"/>
            <Option name="joinstyle" value="bevel" type="QString"/>
            <Option name="name" value="arrow" type="QString"/>
            <Option name="offset" value="0,0" type="QString"/>
            <Option name="offset_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="offset_unit" value="MM" type="QString"/>
            <Option name="outline_color" value="35,35,35,255,rgb:0.13725490196078433,0.13725490196078433,0.13725490196078433,1" type="QString"/>
            <Option name="outline_style" value="solid" type="QString"/>
            <Option name="outline_width" value="0" type="QString"/>
            <Option name="outline_width_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="outline_width_unit" value="MM" type="QString"/>
            <Option name="scale_method" value="diameter" type="QString"/>
            <Option name="size" value="2" type="QString"/>
            <Option name="size_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="size_unit" value="MM" type="QString"/>
            <Option name="vertical_anchor_point" value="1" type="QString"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" value="" type="QString"/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="field" value="WD" type="QString"/>
                  <Option name="type" value="2" type="int"/>
                </Option>
                <Option name="size" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="expression" value="with_variable(&#xd;&#xa;    'basis',&#xd;&#xa;    CASE                        &#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.1 THEN 0&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.2 THEN 1&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.3 THEN 2&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.5 THEN 3&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.7 THEN 4&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 1.0 THEN 5&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 2.0 THEN 6&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 5.0 THEN 7&#xd;&#xa;        ELSE 8&#xd;&#xa;    END,&#xd;&#xa;&#xd;&#xa;    with_variable(&#xd;&#xa;        'zoomfaktor',&#xd;&#xa;        CASE&#xd;&#xa;            WHEN @map_scale &lt;= 1000 THEN 1.0&#xd;&#xa;            WHEN @map_scale &lt;= 2000 THEN 1.2&#xd;&#xa;            WHEN @map_scale &lt;= 3000 THEN 1.4&#xd;&#xa;            WHEN @map_scale &lt;= 5000 THEN 1.6&#xd;&#xa;            WHEN @map_scale &lt;= 8000 THEN 1.8&#xd;&#xa;            WHEN @map_scale &lt;= 10000 THEN 2.0&#xd;&#xa;            WHEN @map_scale &lt;= 20000 THEN 2.3&#xd;&#xa;            ELSE 2.6&#xd;&#xa;        END,&#xd;&#xa;&#xd;&#xa;        CASE&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 20000 THEN&#xd;&#xa;                @basis * @zoomfaktor&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 25000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 9 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 30000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 11 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 40000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 14 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            ELSE&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 18 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;        END&#xd;&#xa;    )&#xd;&#xa;)" type="QString"/>
                  <Option name="type" value="3" type="int"/>
                </Option>
              </Option>
              <Option name="type" value="collection" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol frame_rate="10" alpha="1" is_animated="0" name="3" force_rhr="0" clip_to_extent="1" type="marker">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" value="" type="QString"/>
            <Option name="properties"/>
            <Option name="type" value="collection" type="QString"/>
          </Option>
        </data_defined_properties>
        <layer enabled="1" class="SimpleMarker" locked="0" id="{906f1901-8a1d-4f7c-ae1a-58f84268b175}" pass="0">
          <Option type="Map">
            <Option name="angle" value="0" type="QString"/>
            <Option name="cap_style" value="square" type="QString"/>
            <Option name="color" value="255,255,255,255,rgb:1,1,1,1" type="QString"/>
            <Option name="horizontal_anchor_point" value="1" type="QString"/>
            <Option name="joinstyle" value="bevel" type="QString"/>
            <Option name="name" value="arrow" type="QString"/>
            <Option name="offset" value="0,0" type="QString"/>
            <Option name="offset_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="offset_unit" value="MM" type="QString"/>
            <Option name="outline_color" value="35,35,35,255,rgb:0.13725490196078433,0.13725490196078433,0.13725490196078433,1" type="QString"/>
            <Option name="outline_style" value="solid" type="QString"/>
            <Option name="outline_width" value="0" type="QString"/>
            <Option name="outline_width_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="outline_width_unit" value="MM" type="QString"/>
            <Option name="scale_method" value="diameter" type="QString"/>
            <Option name="size" value="3" type="QString"/>
            <Option name="size_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="size_unit" value="MM" type="QString"/>
            <Option name="vertical_anchor_point" value="1" type="QString"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" value="" type="QString"/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="field" value="WD" type="QString"/>
                  <Option name="type" value="2" type="int"/>
                </Option>
                <Option name="size" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="expression" value="with_variable(&#xd;&#xa;    'basis',&#xd;&#xa;    CASE                        &#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.1 THEN 0&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.2 THEN 1&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.3 THEN 2&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.5 THEN 3&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.7 THEN 4&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 1.0 THEN 5&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 2.0 THEN 6&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 5.0 THEN 7&#xd;&#xa;        ELSE 8&#xd;&#xa;    END,&#xd;&#xa;&#xd;&#xa;    with_variable(&#xd;&#xa;        'zoomfaktor',&#xd;&#xa;        CASE&#xd;&#xa;            WHEN @map_scale &lt;= 1000 THEN 1.0&#xd;&#xa;            WHEN @map_scale &lt;= 2000 THEN 1.2&#xd;&#xa;            WHEN @map_scale &lt;= 3000 THEN 1.4&#xd;&#xa;            WHEN @map_scale &lt;= 5000 THEN 1.6&#xd;&#xa;            WHEN @map_scale &lt;= 8000 THEN 1.8&#xd;&#xa;            WHEN @map_scale &lt;= 10000 THEN 2.0&#xd;&#xa;            WHEN @map_scale &lt;= 20000 THEN 2.3&#xd;&#xa;            ELSE 2.6&#xd;&#xa;        END,&#xd;&#xa;&#xd;&#xa;        CASE&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 20000 THEN&#xd;&#xa;                @basis * @zoomfaktor&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 25000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 9 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 30000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 11 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 40000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 14 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            ELSE&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 18 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;        END&#xd;&#xa;    )&#xd;&#xa;)" type="QString"/>
                  <Option name="type" value="3" type="int"/>
                </Option>
              </Option>
              <Option name="type" value="collection" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol frame_rate="10" alpha="1" is_animated="0" name="4" force_rhr="0" clip_to_extent="1" type="marker">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" value="" type="QString"/>
            <Option name="properties"/>
            <Option name="type" value="collection" type="QString"/>
          </Option>
        </data_defined_properties>
        <layer enabled="1" class="SimpleMarker" locked="0" id="{906f1901-8a1d-4f7c-ae1a-58f84268b175}" pass="0">
          <Option type="Map">
            <Option name="angle" value="0" type="QString"/>
            <Option name="cap_style" value="square" type="QString"/>
            <Option name="color" value="255,255,255,255,rgb:1,1,1,1" type="QString"/>
            <Option name="horizontal_anchor_point" value="1" type="QString"/>
            <Option name="joinstyle" value="bevel" type="QString"/>
            <Option name="name" value="arrow" type="QString"/>
            <Option name="offset" value="0,0" type="QString"/>
            <Option name="offset_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="offset_unit" value="MM" type="QString"/>
            <Option name="outline_color" value="35,35,35,255,rgb:0.13725490196078433,0.13725490196078433,0.13725490196078433,1" type="QString"/>
            <Option name="outline_style" value="solid" type="QString"/>
            <Option name="outline_width" value="0" type="QString"/>
            <Option name="outline_width_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="outline_width_unit" value="MM" type="QString"/>
            <Option name="scale_method" value="diameter" type="QString"/>
            <Option name="size" value="4" type="QString"/>
            <Option name="size_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="size_unit" value="MM" type="QString"/>
            <Option name="vertical_anchor_point" value="1" type="QString"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" value="" type="QString"/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="field" value="WD" type="QString"/>
                  <Option name="type" value="2" type="int"/>
                </Option>
                <Option name="size" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="expression" value="with_variable(&#xd;&#xa;    'basis',&#xd;&#xa;    CASE                        &#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.1 THEN 0&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.2 THEN 1&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.3 THEN 2&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.5 THEN 3&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.7 THEN 4&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 1.0 THEN 5&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 2.0 THEN 6&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 5.0 THEN 7&#xd;&#xa;        ELSE 8&#xd;&#xa;    END,&#xd;&#xa;&#xd;&#xa;    with_variable(&#xd;&#xa;        'zoomfaktor',&#xd;&#xa;        CASE&#xd;&#xa;            WHEN @map_scale &lt;= 1000 THEN 1.0&#xd;&#xa;            WHEN @map_scale &lt;= 2000 THEN 1.2&#xd;&#xa;            WHEN @map_scale &lt;= 3000 THEN 1.4&#xd;&#xa;            WHEN @map_scale &lt;= 5000 THEN 1.6&#xd;&#xa;            WHEN @map_scale &lt;= 8000 THEN 1.8&#xd;&#xa;            WHEN @map_scale &lt;= 10000 THEN 2.0&#xd;&#xa;            WHEN @map_scale &lt;= 20000 THEN 2.3&#xd;&#xa;            ELSE 2.6&#xd;&#xa;        END,&#xd;&#xa;&#xd;&#xa;        CASE&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 20000 THEN&#xd;&#xa;                @basis * @zoomfaktor&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 25000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 9 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 30000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 11 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 40000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 14 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            ELSE&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 18 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;        END&#xd;&#xa;    )&#xd;&#xa;)" type="QString"/>
                  <Option name="type" value="3" type="int"/>
                </Option>
              </Option>
              <Option name="type" value="collection" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol frame_rate="10" alpha="1" is_animated="0" name="5" force_rhr="0" clip_to_extent="1" type="marker">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" value="" type="QString"/>
            <Option name="properties"/>
            <Option name="type" value="collection" type="QString"/>
          </Option>
        </data_defined_properties>
        <layer enabled="1" class="SimpleMarker" locked="0" id="{906f1901-8a1d-4f7c-ae1a-58f84268b175}" pass="0">
          <Option type="Map">
            <Option name="angle" value="0" type="QString"/>
            <Option name="cap_style" value="square" type="QString"/>
            <Option name="color" value="255,255,255,255,rgb:1,1,1,1" type="QString"/>
            <Option name="horizontal_anchor_point" value="1" type="QString"/>
            <Option name="joinstyle" value="bevel" type="QString"/>
            <Option name="name" value="arrow" type="QString"/>
            <Option name="offset" value="0,0" type="QString"/>
            <Option name="offset_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="offset_unit" value="MM" type="QString"/>
            <Option name="outline_color" value="35,35,35,255,rgb:0.13725490196078433,0.13725490196078433,0.13725490196078433,1" type="QString"/>
            <Option name="outline_style" value="solid" type="QString"/>
            <Option name="outline_width" value="0" type="QString"/>
            <Option name="outline_width_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="outline_width_unit" value="MM" type="QString"/>
            <Option name="scale_method" value="diameter" type="QString"/>
            <Option name="size" value="5" type="QString"/>
            <Option name="size_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="size_unit" value="MM" type="QString"/>
            <Option name="vertical_anchor_point" value="1" type="QString"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" value="" type="QString"/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="field" value="WD" type="QString"/>
                  <Option name="type" value="2" type="int"/>
                </Option>
                <Option name="size" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="expression" value="with_variable(&#xd;&#xa;    'basis',&#xd;&#xa;    CASE                        &#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.1 THEN 0&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.2 THEN 1&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.3 THEN 2&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.5 THEN 3&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.7 THEN 4&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 1.0 THEN 5&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 2.0 THEN 6&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 5.0 THEN 7&#xd;&#xa;        ELSE 8&#xd;&#xa;    END,&#xd;&#xa;&#xd;&#xa;    with_variable(&#xd;&#xa;        'zoomfaktor',&#xd;&#xa;        CASE&#xd;&#xa;            WHEN @map_scale &lt;= 1000 THEN 1.0&#xd;&#xa;            WHEN @map_scale &lt;= 2000 THEN 1.2&#xd;&#xa;            WHEN @map_scale &lt;= 3000 THEN 1.4&#xd;&#xa;            WHEN @map_scale &lt;= 5000 THEN 1.6&#xd;&#xa;            WHEN @map_scale &lt;= 8000 THEN 1.8&#xd;&#xa;            WHEN @map_scale &lt;= 10000 THEN 2.0&#xd;&#xa;            WHEN @map_scale &lt;= 20000 THEN 2.3&#xd;&#xa;            ELSE 2.6&#xd;&#xa;        END,&#xd;&#xa;&#xd;&#xa;        CASE&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 20000 THEN&#xd;&#xa;                @basis * @zoomfaktor&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 25000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 9 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 30000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 11 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 40000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 14 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            ELSE&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 18 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;        END&#xd;&#xa;    )&#xd;&#xa;)" type="QString"/>
                  <Option name="type" value="3" type="int"/>
                </Option>
              </Option>
              <Option name="type" value="collection" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol frame_rate="10" alpha="1" is_animated="0" name="6" force_rhr="0" clip_to_extent="1" type="marker">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" value="" type="QString"/>
            <Option name="properties"/>
            <Option name="type" value="collection" type="QString"/>
          </Option>
        </data_defined_properties>
        <layer enabled="1" class="SimpleMarker" locked="0" id="{906f1901-8a1d-4f7c-ae1a-58f84268b175}" pass="0">
          <Option type="Map">
            <Option name="angle" value="0" type="QString"/>
            <Option name="cap_style" value="square" type="QString"/>
            <Option name="color" value="255,255,255,255,rgb:1,1,1,1" type="QString"/>
            <Option name="horizontal_anchor_point" value="1" type="QString"/>
            <Option name="joinstyle" value="bevel" type="QString"/>
            <Option name="name" value="arrow" type="QString"/>
            <Option name="offset" value="0,0" type="QString"/>
            <Option name="offset_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="offset_unit" value="MM" type="QString"/>
            <Option name="outline_color" value="35,35,35,255,rgb:0.13725490196078433,0.13725490196078433,0.13725490196078433,1" type="QString"/>
            <Option name="outline_style" value="solid" type="QString"/>
            <Option name="outline_width" value="0" type="QString"/>
            <Option name="outline_width_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="outline_width_unit" value="MM" type="QString"/>
            <Option name="scale_method" value="diameter" type="QString"/>
            <Option name="size" value="6" type="QString"/>
            <Option name="size_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="size_unit" value="MM" type="QString"/>
            <Option name="vertical_anchor_point" value="1" type="QString"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" value="" type="QString"/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="field" value="WD" type="QString"/>
                  <Option name="type" value="2" type="int"/>
                </Option>
                <Option name="size" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="expression" value="with_variable(&#xd;&#xa;    'basis',&#xd;&#xa;    CASE                        &#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.1 THEN 0&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.2 THEN 1&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.3 THEN 2&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.5 THEN 3&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.7 THEN 4&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 1.0 THEN 5&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 2.0 THEN 6&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 5.0 THEN 7&#xd;&#xa;        ELSE 8&#xd;&#xa;    END,&#xd;&#xa;&#xd;&#xa;    with_variable(&#xd;&#xa;        'zoomfaktor',&#xd;&#xa;        CASE&#xd;&#xa;            WHEN @map_scale &lt;= 1000 THEN 1.0&#xd;&#xa;            WHEN @map_scale &lt;= 2000 THEN 1.2&#xd;&#xa;            WHEN @map_scale &lt;= 3000 THEN 1.4&#xd;&#xa;            WHEN @map_scale &lt;= 5000 THEN 1.6&#xd;&#xa;            WHEN @map_scale &lt;= 8000 THEN 1.8&#xd;&#xa;            WHEN @map_scale &lt;= 10000 THEN 2.0&#xd;&#xa;            WHEN @map_scale &lt;= 20000 THEN 2.3&#xd;&#xa;            ELSE 2.6&#xd;&#xa;        END,&#xd;&#xa;&#xd;&#xa;        CASE&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 20000 THEN&#xd;&#xa;                @basis * @zoomfaktor&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 25000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 9 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 30000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 11 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 40000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 14 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            ELSE&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 18 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;        END&#xd;&#xa;    )&#xd;&#xa;)" type="QString"/>
                  <Option name="type" value="3" type="int"/>
                </Option>
              </Option>
              <Option name="type" value="collection" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol frame_rate="10" alpha="1" is_animated="0" name="7" force_rhr="0" clip_to_extent="1" type="marker">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" value="" type="QString"/>
            <Option name="properties"/>
            <Option name="type" value="collection" type="QString"/>
          </Option>
        </data_defined_properties>
        <layer enabled="1" class="SimpleMarker" locked="0" id="{906f1901-8a1d-4f7c-ae1a-58f84268b175}" pass="0">
          <Option type="Map">
            <Option name="angle" value="0" type="QString"/>
            <Option name="cap_style" value="square" type="QString"/>
            <Option name="color" value="255,255,255,255,rgb:1,1,1,1" type="QString"/>
            <Option name="horizontal_anchor_point" value="1" type="QString"/>
            <Option name="joinstyle" value="bevel" type="QString"/>
            <Option name="name" value="arrow" type="QString"/>
            <Option name="offset" value="0,0" type="QString"/>
            <Option name="offset_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="offset_unit" value="MM" type="QString"/>
            <Option name="outline_color" value="35,35,35,255,rgb:0.13725490196078433,0.13725490196078433,0.13725490196078433,1" type="QString"/>
            <Option name="outline_style" value="solid" type="QString"/>
            <Option name="outline_width" value="0" type="QString"/>
            <Option name="outline_width_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="outline_width_unit" value="MM" type="QString"/>
            <Option name="scale_method" value="diameter" type="QString"/>
            <Option name="size" value="7" type="QString"/>
            <Option name="size_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="size_unit" value="MM" type="QString"/>
            <Option name="vertical_anchor_point" value="1" type="QString"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" value="" type="QString"/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="field" value="WD" type="QString"/>
                  <Option name="type" value="2" type="int"/>
                </Option>
                <Option name="size" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="expression" value="with_variable(&#xd;&#xa;    'basis',&#xd;&#xa;    CASE                        &#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.1 THEN 0&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.2 THEN 1&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.3 THEN 2&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.5 THEN 3&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.7 THEN 4&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 1.0 THEN 5&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 2.0 THEN 6&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 5.0 THEN 7&#xd;&#xa;        ELSE 8&#xd;&#xa;    END,&#xd;&#xa;&#xd;&#xa;    with_variable(&#xd;&#xa;        'zoomfaktor',&#xd;&#xa;        CASE&#xd;&#xa;            WHEN @map_scale &lt;= 1000 THEN 1.0&#xd;&#xa;            WHEN @map_scale &lt;= 2000 THEN 1.2&#xd;&#xa;            WHEN @map_scale &lt;= 3000 THEN 1.4&#xd;&#xa;            WHEN @map_scale &lt;= 5000 THEN 1.6&#xd;&#xa;            WHEN @map_scale &lt;= 8000 THEN 1.8&#xd;&#xa;            WHEN @map_scale &lt;= 10000 THEN 2.0&#xd;&#xa;            WHEN @map_scale &lt;= 20000 THEN 2.3&#xd;&#xa;            ELSE 2.6&#xd;&#xa;        END,&#xd;&#xa;&#xd;&#xa;        CASE&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 20000 THEN&#xd;&#xa;                @basis * @zoomfaktor&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 25000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 9 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 30000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 11 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 40000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 14 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            ELSE&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 18 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;        END&#xd;&#xa;    )&#xd;&#xa;)" type="QString"/>
                  <Option name="type" value="3" type="int"/>
                </Option>
              </Option>
              <Option name="type" value="collection" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol frame_rate="10" alpha="1" is_animated="0" name="8" force_rhr="0" clip_to_extent="1" type="marker">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" value="" type="QString"/>
            <Option name="properties"/>
            <Option name="type" value="collection" type="QString"/>
          </Option>
        </data_defined_properties>
        <layer enabled="1" class="SimpleMarker" locked="0" id="{906f1901-8a1d-4f7c-ae1a-58f84268b175}" pass="0">
          <Option type="Map">
            <Option name="angle" value="0" type="QString"/>
            <Option name="cap_style" value="square" type="QString"/>
            <Option name="color" value="255,255,255,255,rgb:1,1,1,1" type="QString"/>
            <Option name="horizontal_anchor_point" value="1" type="QString"/>
            <Option name="joinstyle" value="bevel" type="QString"/>
            <Option name="name" value="arrow" type="QString"/>
            <Option name="offset" value="0,0" type="QString"/>
            <Option name="offset_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="offset_unit" value="MM" type="QString"/>
            <Option name="outline_color" value="35,35,35,255,rgb:0.13725490196078433,0.13725490196078433,0.13725490196078433,1" type="QString"/>
            <Option name="outline_style" value="solid" type="QString"/>
            <Option name="outline_width" value="0" type="QString"/>
            <Option name="outline_width_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="outline_width_unit" value="MM" type="QString"/>
            <Option name="scale_method" value="diameter" type="QString"/>
            <Option name="size" value="8" type="QString"/>
            <Option name="size_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="size_unit" value="MM" type="QString"/>
            <Option name="vertical_anchor_point" value="1" type="QString"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" value="" type="QString"/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="field" value="WD" type="QString"/>
                  <Option name="type" value="2" type="int"/>
                </Option>
                <Option name="size" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="expression" value="with_variable(&#xd;&#xa;    'basis',&#xd;&#xa;    CASE                        &#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.1 THEN 0&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.2 THEN 1&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.3 THEN 2&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.5 THEN 3&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.7 THEN 4&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 1.0 THEN 5&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 2.0 THEN 6&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 5.0 THEN 7&#xd;&#xa;        ELSE 8&#xd;&#xa;    END,&#xd;&#xa;&#xd;&#xa;    with_variable(&#xd;&#xa;        'zoomfaktor',&#xd;&#xa;        CASE&#xd;&#xa;            WHEN @map_scale &lt;= 1000 THEN 1.0&#xd;&#xa;            WHEN @map_scale &lt;= 2000 THEN 1.2&#xd;&#xa;            WHEN @map_scale &lt;= 3000 THEN 1.4&#xd;&#xa;            WHEN @map_scale &lt;= 5000 THEN 1.6&#xd;&#xa;            WHEN @map_scale &lt;= 8000 THEN 1.8&#xd;&#xa;            WHEN @map_scale &lt;= 10000 THEN 2.0&#xd;&#xa;            WHEN @map_scale &lt;= 20000 THEN 2.3&#xd;&#xa;            ELSE 2.6&#xd;&#xa;        END,&#xd;&#xa;&#xd;&#xa;        CASE&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 20000 THEN&#xd;&#xa;                @basis * @zoomfaktor&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 25000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 9 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 30000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 11 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 40000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 14 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            ELSE&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 18 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;        END&#xd;&#xa;    )&#xd;&#xa;)" type="QString"/>
                  <Option name="type" value="3" type="int"/>
                </Option>
              </Option>
              <Option name="type" value="collection" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </symbols>
    <source-symbol>
      <symbol frame_rate="10" alpha="1" is_animated="0" name="0" force_rhr="0" clip_to_extent="1" type="marker">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" value="" type="QString"/>
            <Option name="properties"/>
            <Option name="type" value="collection" type="QString"/>
          </Option>
        </data_defined_properties>
        <layer enabled="1" class="SimpleMarker" locked="0" id="{906f1901-8a1d-4f7c-ae1a-58f84268b175}" pass="0">
          <Option type="Map">
            <Option name="angle" value="0" type="QString"/>
            <Option name="cap_style" value="square" type="QString"/>
            <Option name="color" value="255,255,255,255,rgb:1,1,1,1" type="QString"/>
            <Option name="horizontal_anchor_point" value="1" type="QString"/>
            <Option name="joinstyle" value="bevel" type="QString"/>
            <Option name="name" value="arrow" type="QString"/>
            <Option name="offset" value="0,0" type="QString"/>
            <Option name="offset_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="offset_unit" value="MM" type="QString"/>
            <Option name="outline_color" value="35,35,35,255,rgb:0.13725490196078433,0.13725490196078433,0.13725490196078433,1" type="QString"/>
            <Option name="outline_style" value="solid" type="QString"/>
            <Option name="outline_width" value="0" type="QString"/>
            <Option name="outline_width_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="outline_width_unit" value="MM" type="QString"/>
            <Option name="scale_method" value="diameter" type="QString"/>
            <Option name="size" value="2" type="QString"/>
            <Option name="size_map_unit_scale" value="3x:0,0,0,0,0,0" type="QString"/>
            <Option name="size_unit" value="MM" type="QString"/>
            <Option name="vertical_anchor_point" value="1" type="QString"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" value="" type="QString"/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="field" value="WD" type="QString"/>
                  <Option name="type" value="2" type="int"/>
                </Option>
                <Option name="size" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="expression" value="with_variable(&#xd;&#xa;    'basis',&#xd;&#xa;    CASE                        &#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.1 THEN 0&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.2 THEN 1&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.3 THEN 2&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.5 THEN 3&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 0.7 THEN 4&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 1.0 THEN 5&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 2.0 THEN 6&#xd;&#xa;        WHEN &quot;WS&quot; &lt; 5.0 THEN 7&#xd;&#xa;        ELSE 8&#xd;&#xa;    END,&#xd;&#xa;&#xd;&#xa;    with_variable(&#xd;&#xa;        'zoomfaktor',&#xd;&#xa;        CASE&#xd;&#xa;            WHEN @map_scale &lt;= 1000 THEN 1.0&#xd;&#xa;            WHEN @map_scale &lt;= 2000 THEN 1.2&#xd;&#xa;            WHEN @map_scale &lt;= 3000 THEN 1.4&#xd;&#xa;            WHEN @map_scale &lt;= 5000 THEN 1.6&#xd;&#xa;            WHEN @map_scale &lt;= 8000 THEN 1.8&#xd;&#xa;            WHEN @map_scale &lt;= 10000 THEN 2.0&#xd;&#xa;            WHEN @map_scale &lt;= 20000 THEN 2.3&#xd;&#xa;            ELSE 2.6&#xd;&#xa;        END,&#xd;&#xa;&#xd;&#xa;        CASE&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 20000 THEN&#xd;&#xa;                @basis * @zoomfaktor&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 25000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 9 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 30000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 11 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            WHEN @map_scale &lt;= 40000 THEN&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 14 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;&#xd;&#xa;            ELSE&#xd;&#xa;                CASE&#xd;&#xa;                    WHEN $id % 18 = 0&#xd;&#xa;                        THEN @basis * @zoomfaktor&#xd;&#xa;                    ELSE 0&#xd;&#xa;                END&#xd;&#xa;        END&#xd;&#xa;    )&#xd;&#xa;)" type="QString"/>
                  <Option name="type" value="3" type="int"/>
                </Option>
              </Option>
              <Option name="type" value="collection" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </source-symbol>
    <classificationMethod id="EqualInterval">
      <symmetricMode enabled="0" symmetrypoint="0" astride="0"/>
      <labelFormat labelprecision="4" format="%1 - %2" trimtrailingzeroes="0"/>
      <parameters>
        <Option/>
      </parameters>
      <extraInformation/>
    </classificationMethod>
    <rotation/>
    <sizescale/>
    <data-defined-properties>
      <Option type="Map">
        <Option name="name" value="" type="QString"/>
        <Option name="properties"/>
        <Option name="type" value="collection" type="QString"/>
      </Option>
    </data-defined-properties>
  </renderer-v2>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <layerOpacity>1</layerOpacity>
  <layerGeometryType>0</layerGeometryType>
</qgis>

