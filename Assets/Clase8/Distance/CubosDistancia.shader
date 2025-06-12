// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CubosDistancia"
{
	Properties
	{
		_Point("Point", Vector) = (0,0,0,0)
		_Color0("Color 0", Color) = (0.6431373,0,0.2104857,0)
		_Color1("Color 1", Color) = (0,0.3599334,0.4433962,0)
		_Freq("Freq", Float) = 0
		_Height("Height", Float) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			half filler;
		};

		uniform float3 _Point;
		uniform float _Freq;
		uniform float _Height;
		uniform float4 _Color0;
		uniform float4 _Color1;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 transform22 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float temp_output_9_0 = sin( ( ( distance( transform22 , float4( _Point , 0.0 ) ) + _Time.y ) * _Freq ) );
			v.vertex.xyz += ( temp_output_9_0 * float3(0,1,0) * _Height );
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 transform22 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float temp_output_9_0 = sin( ( ( distance( transform22 , float4( _Point , 0.0 ) ) + _Time.y ) * _Freq ) );
			float4 lerpResult17 = lerp( _Color0 , _Color1 , (0.0 + (temp_output_9_0 - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)));
			o.Emission = lerpResult17.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;507;1619;479;980.4218;-207.7637;1;True;False
Node;AmplifyShaderEditor.Vector3Node;2;-878.5,216.5;Inherit;False;Property;_Point;Point;0;0;Create;True;0;0;0;False;0;False;0,0,0;3.4,9.87,-26.2;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;22;-902.5923,16.94131;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DistanceOpNode;3;-603.5,173.5;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;13;-770.7031,358.0563;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-451.7031,201.0563;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-451.7031,360.0563;Inherit;False;Property;_Freq;Freq;5;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-329.7031,192.0563;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;9;-201.2435,171.2244;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;15;-192.7031,256.0563;Inherit;False;Constant;_Vector0;Vector 0;4;0;Create;True;0;0;0;False;0;False;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TFHCRemapNode;20;-2.477295,-1.234283;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-155.7031,414.0563;Inherit;False;Property;_Height;Height;6;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;18;-320.7031,-261.9437;Inherit;False;Property;_Color0;Color 0;1;0;Create;True;0;0;0;False;0;False;0.6431373,0,0.2104857,0;0.6431373,0,0.2104857,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;19;-374.7031,-79.94373;Inherit;False;Property;_Color1;Color 1;2;0;Create;True;0;0;0;False;0;False;0,0.3599334,0.4433962,0;1,0.7699115,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;17;222.2969,-145.9437;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-640.0958,651.2962;Inherit;False;Property;_FallOff;FallOff;4;0;Create;True;0;0;0;False;0;False;0;69.94;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;7;-503.0956,539.2961;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;4;-341.0956,568.2961;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;42.29688,185.0563;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-826.0957,613.2962;Inherit;False;Property;_Range;Range;3;0;Create;True;0;0;0;False;0;False;2.67;1.95;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;5;-633.0958,477.2961;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;1;-1154.5,0.5;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;429,-134;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;CubosDistancia;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;1;32;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;22;0
WireConnection;3;1;2;0
WireConnection;12;0;3;0
WireConnection;12;1;13;0
WireConnection;10;0;12;0
WireConnection;10;1;11;0
WireConnection;9;0;10;0
WireConnection;20;0;9;0
WireConnection;17;0;18;0
WireConnection;17;1;19;0
WireConnection;17;2;20;0
WireConnection;7;0;5;0
WireConnection;7;1;8;0
WireConnection;4;0;7;0
WireConnection;14;0;9;0
WireConnection;14;1;15;0
WireConnection;14;2;16;0
WireConnection;5;1;6;0
WireConnection;0;2;17;0
WireConnection;0;11;14;0
ASEEND*/
//CHKSM=FB977EA78C23D4F72E1825E4E58E7F739A9C8A3C