// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_Mov_Scale("Mov_Scale", Float) = 4.21
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Mov_Scale;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 temp_cast_0 = (-1.0).xx;
			float3 objToWorldDir4 = mul( unity_ObjectToWorld, float4( float3( (temp_cast_0 + (v.texcoord.xy - float2( 0,0 )) * (float2( 1,1 ) - temp_cast_0) / (float2( 1,1 ) - float2( 0,0 ))) ,  0.0 ), 0 ) ).xyz;
			float3 Quad8 = ( objToWorldDir4 * _Mov_Scale );
			v.vertex.xyz += Quad8;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_0 = (-1.0).xx;
			float3 objToWorldDir4 = mul( unity_ObjectToWorld, float4( float3( (temp_cast_0 + (i.uv_texcoord - float2( 0,0 )) * (float2( 1,1 ) - temp_cast_0) / (float2( 1,1 ) - float2( 0,0 ))) ,  0.0 ), 0 ) ).xyz;
			float3 Quad8 = ( objToWorldDir4 * _Mov_Scale );
			o.Emission = Quad8;
			o.Smoothness = 0.123456;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
-13;559;1904;970;1857.946;202.356;1.482107;True;False
Node;AmplifyShaderEditor.CommentaryNode;9;-1763.062,-568.4017;Inherit;False;1216.537;396.2177;Quad;7;4;5;6;1;3;7;8;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-1712.062,-518.4017;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;7;-1713.062,-374.4016;Inherit;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;0;False;0;False;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;5;-1467.062,-491.4016;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;0,0;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TransformDirectionNode;4;-1237.062,-495.4016;Inherit;False;Object;World;False;Fast;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;3;-1144.51,-287.344;Inherit;False;Property;_Mov_Scale;Mov_Scale;0;0;Create;True;0;0;0;False;0;False;4.21;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1;-972.9727,-375.1351;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;25;-2289.714,-101.5246;Inherit;False;1936.453;525.6259;Surbface Light;13;14;12;16;23;15;24;11;17;22;19;21;20;18;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;8;-774.7153,-377.3573;Inherit;False;Quad;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;26;-257.2702,43.67383;Inherit;False;8;Quad;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;24;-1124.242,115.2852;Inherit;False;Constant;_Color0;Color 0;2;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;14;-1119.861,0.3152027;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;12;-959.3375,-6.623816;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;10;-265.1564,271.6916;Inherit;False;8;Quad;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-809.2417,-7.714767;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;15;-1348.138,-51.52456;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TransformDirectionNode;21;-1994.714,114.4913;Inherit;False;Object;World;False;Fast;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-1486.835,135.9719;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PosVertexDataNode;22;-2239.714,113.4913;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-1691.757,234.8693;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1897.434,308.9413;Inherit;False;Property;_Float1;Float 1;1;0;Create;True;0;0;0;False;0;False;3.41;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;18;-1734.172,29.08111;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;11;-581.451,-16.15103;Inherit;False;Light;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NegateNode;16;-1334,136.9837;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-319.5185,144.4571;Inherit;False;Constant;_Smooth;Smooth;2;0;Create;True;0;0;0;False;0;False;0.123456;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;New Amplify Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;0;6;0
WireConnection;5;3;7;0
WireConnection;4;0;5;0
WireConnection;1;0;4;0
WireConnection;1;1;3;0
WireConnection;8;0;1;0
WireConnection;14;0;15;0
WireConnection;14;1;16;0
WireConnection;12;0;14;0
WireConnection;23;0;12;0
WireConnection;23;1;24;0
WireConnection;21;0;22;0
WireConnection;17;0;18;0
WireConnection;17;1;19;0
WireConnection;19;0;21;0
WireConnection;19;1;20;0
WireConnection;11;0;23;0
WireConnection;16;0;17;0
WireConnection;0;2;26;0
WireConnection;0;4;27;0
WireConnection;0;11;10;0
ASEEND*/
//CHKSM=E6804ECD3BC81C61FA0FE965D5FC807BC5AAA0A4