// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CubosDistancia"
{
	Properties
	{
		_Point("Point", Vector) = (0,0,0,0)
		_Color1("Color 1", Color) = (0,0.3599334,0.4433962,0)
		_Freq("Freq", Float) = 0
		_Height("Height", Range( 0 , 1)) = 0
		_Float0("Float 0", Range( 0 , 1)) = 0.01176471
		_Float1("Float 1", Float) = 0
		_Float2("Float 2", Float) = 0
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
			float3 worldPos;
		};

		uniform float3 _Point;
		uniform float _Freq;
		uniform float _Height;
		uniform float4 _Color1;
		uniform float _Float2;
		uniform float _Float1;
		uniform float _Float0;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 transform22 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float temp_output_9_0 = sin( ( ( distance( transform22 , float4( _Point , 0.0 ) ) + _Time.y ) * _Freq ) );
			v.vertex.xyz += ( temp_output_9_0 * float3(0,0,1) * _Height );
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Albedo = _Color1.rgb;
			float4 color26 = IsGammaSpace() ? float4(0.6509434,0.5871809,0.2732734,0) : float4(0.3812781,0.3037889,0.06069596,0);
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float mulTime40 = _Time.y * 1.04;
			float mulTime36 = _Time.y * _Float2;
			o.Emission = ( color26 * (0.0 + (saturate( ( sin( ( ( sin( ( ( ase_vertex3Pos.y + mulTime40 ) * 2.0 ) ) + mulTime36 ) * _Float1 ) ) - ( 1.0 - _Float0 ) ) ) - 0.0) * (1.0 - 0.0) / (1.0 - 0.0)) ).rgb;
			o.Metallic = 0.46;
			o.Smoothness = 0.05;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;622;1466;364;1464.7;-307.016;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;38;-2082.698,-149.7115;Inherit;False;Constant;_TimeS;TimeS;0;0;Create;True;0;0;0;False;0;False;1.04;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;40;-1938.699,-201.7115;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;39;-1963.596,-344.1649;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;42;-1755.699,-299.7115;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-1837.699,-118.7115;Inherit;False;Constant;_Frecuency;Frecuency;0;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-1591.288,-286.3937;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-1433.285,37.89648;Inherit;False;Property;_Float2;Float 2;8;0;Create;True;0;0;0;False;0;False;0;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;45;-1384.286,-286.519;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;36;-1293.225,-9.696385;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-1085.92,50.88458;Inherit;False;Property;_Float1;Float 1;7;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;-1099.747,-88.79237;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-986.031,186.955;Inherit;False;Property;_Float0;Float 0;6;0;Create;True;0;0;0;False;0;False;0.01176471;0.787444;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-890.5978,-9.613464;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;2;-893.5962,744.8666;Inherit;False;Property;_Point;Point;0;0;Create;True;0;0;0;False;0;False;0,0,0;5.92,9.87,-26.2;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;22;-917.6885,545.3079;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;30;-729.4473,111.5839;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;3;-618.5962,701.8666;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;13;-785.7993,886.4229;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;32;-721.2033,-42.45526;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-466.7993,888.4229;Inherit;False;Property;_Freq;Freq;4;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;29;-457.6718,41.62987;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-466.7993,729.423;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;28;-251.8049,43.38943;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-344.7993,720.423;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;27;-53.77325,33.06662;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;9;-216.3397,699.5909;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;15;-207.7993,784.4229;Inherit;False;Constant;_Vector0;Vector 0;4;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;16;-170.7993,942.4229;Inherit;False;Property;_Height;Height;5;0;Create;True;0;0;0;False;0;False;0;0.028;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;26;-116.0052,-182.1677;Inherit;False;Constant;_Color0;Color 0;6;0;Create;True;0;0;0;False;0;False;0.6509434,0.5871809,0.2732734,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;6;-841.1919,1141.663;Inherit;False;Property;_Range;Range;2;0;Create;True;0;0;0;False;0;False;2.67;1.95;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;19;43.13117,-364.751;Inherit;False;Property;_Color1;Color 1;1;0;Create;True;0;0;0;False;0;False;0,0.3599334,0.4433962,0;0.7924528,0.6359152,0.1532573,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;27.20069,713.423;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;24;159.3098,236.5565;Inherit;False;Constant;_Smooth;Smooth;6;0;Create;True;0;0;0;False;0;False;0.05;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;195.1609,-77.52911;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;7;-518.1918,1067.663;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-655.192,1179.663;Inherit;False;Property;_FallOff;FallOff;3;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;20;-57.70806,435.9496;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;4;-356.1918,1096.663;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;161.6295,136.8122;Inherit;False;Constant;_Metallic;Metallic;6;0;Create;True;0;0;0;False;0;False;0.46;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;5;-648.192,1005.663;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;429,-134;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;CubosDistancia;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;1;32;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;40;0;38;0
WireConnection;42;0;39;2
WireConnection;42;1;40;0
WireConnection;43;0;42;0
WireConnection;43;1;41;0
WireConnection;45;0;43;0
WireConnection;36;0;37;0
WireConnection;35;0;45;0
WireConnection;35;1;36;0
WireConnection;33;0;35;0
WireConnection;33;1;34;0
WireConnection;30;0;31;0
WireConnection;3;0;22;0
WireConnection;3;1;2;0
WireConnection;32;0;33;0
WireConnection;29;0;32;0
WireConnection;29;1;30;0
WireConnection;12;0;3;0
WireConnection;12;1;13;0
WireConnection;28;0;29;0
WireConnection;10;0;12;0
WireConnection;10;1;11;0
WireConnection;27;0;28;0
WireConnection;9;0;10;0
WireConnection;14;0;9;0
WireConnection;14;1;15;0
WireConnection;14;2;16;0
WireConnection;25;0;26;0
WireConnection;25;1;27;0
WireConnection;7;0;5;0
WireConnection;7;1;8;0
WireConnection;20;0;9;0
WireConnection;4;0;7;0
WireConnection;5;1;6;0
WireConnection;0;0;19;0
WireConnection;0;2;25;0
WireConnection;0;3;23;0
WireConnection;0;4;24;0
WireConnection;0;11;14;0
ASEEND*/
//CHKSM=852D1B3C1378219B72EE1B162AD5D855FDAC2636