// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Book"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float3 worldPos;
		};

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color4 = IsGammaSpace() ? float4(0.9701951,1,0,0) : float4(0.9335334,1,0,0);
			float4 color2 = IsGammaSpace() ? float4(0.02285218,1,0,0) : float4(0.001768745,1,0,0);
			float3 ase_worldPos = i.worldPos;
			float4 lerpResult3 = lerp( color4 , color2 , saturate( ceil( ( 0.6785941 + sin( ( ase_worldPos.x * 1.5 * 6.28318548202515 ) ) ) ) ));
			float4 color5 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			float4 lerpResult13 = lerp( lerpResult3 , color5 , saturate( ceil( sin( ( ( ase_worldPos.x * 1.5 * 6.28318548202515 ) + 0.5400718 ) ) ) ));
			o.Albedo = saturate( lerpResult13 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;636;1465;358;1342.689;-47.87056;1.429166;True;False
Node;AmplifyShaderEditor.RangedFloatNode;8;-444.626,182.4305;Inherit;False;Constant;_Frec;Frec;0;0;Create;True;0;0;0;False;0;False;1.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TauNode;9;-256.5541,471.666;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;1;-647.3745,7.047956;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-250.42,131.0339;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;15;153.1198,412.0388;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;401.1163,560.8401;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;328.738,832.613;Inherit;False;Constant;_Width2;Width2;0;0;Create;True;0;0;0;False;0;False;0.5400718;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;7;-45.40015,132.1751;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-213.1135,-11.96391;Inherit;False;Constant;_Width1;Width 1;0;0;Create;True;0;0;0;False;0;False;0.6785941;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;619.6237,641.2967;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;20;77.28674,53.53611;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;11;199.4573,78.41483;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;17;721.1104,570.439;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2;-434.35,-183.3868;Inherit;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;0;False;0;False;0.02285218,1,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;22;330.8021,70.43077;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-322.6031,-374.4863;Inherit;False;Constant;_Color1;Color 1;0;0;Create;True;0;0;0;False;0;False;0.9701951,1,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CeilOpNode;18;743.5113,428.0389;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;3;476.7888,-101.2282;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;25;909.1299,335.83;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;5;535.0901,-313.4528;Inherit;False;Constant;_Color2;Color 2;0;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;13;1018.774,-189.4158;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;19;1267.942,-143.4173;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1450.641,-159.3696;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Book;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;1;1
WireConnection;6;1;8;0
WireConnection;6;2;9;0
WireConnection;16;0;15;1
WireConnection;16;1;8;0
WireConnection;16;2;9;0
WireConnection;7;0;6;0
WireConnection;24;0;16;0
WireConnection;24;1;23;0
WireConnection;20;0;21;0
WireConnection;20;1;7;0
WireConnection;11;0;20;0
WireConnection;17;0;24;0
WireConnection;22;0;11;0
WireConnection;18;0;17;0
WireConnection;3;0;4;0
WireConnection;3;1;2;0
WireConnection;3;2;22;0
WireConnection;25;0;18;0
WireConnection;13;0;3;0
WireConnection;13;1;5;0
WireConnection;13;2;25;0
WireConnection;19;0;13;0
WireConnection;0;0;19;0
ASEEND*/
//CHKSM=DB759EC36136C5BBD21BD0FACB3ABAE5EDE93027