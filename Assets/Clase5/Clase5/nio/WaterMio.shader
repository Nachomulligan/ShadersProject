// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "WaterMio"
{
	Properties
	{
		_Water("Water", 2D) = "white" {}
		_FlowMap("FlowMap", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Water;
		uniform sampler2D _FlowMap;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_1 = (3.2).xx;
			float2 uv_TexCoord1 = i.uv_texcoord * temp_cast_1;
			float2 temp_cast_3 = (-0.1).xx;
			float2 panner16 = ( 1.0 * _Time.y * temp_cast_3 + i.uv_texcoord);
			float4 tex2DNode7 = tex2D( _FlowMap, panner16 );
			float4 lerpResult12 = lerp( float4( uv_TexCoord1, 0.0 , 0.0 ) , tex2DNode7 , 0.5);
			float2 panner2 = ( 1.0 * _Time.y * float3(0.1,0.1,0).xy + lerpResult12.rg);
			o.Albedo = tex2D( _Water, panner2 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;622;1465;372;834.8254;518.94;1.869982;True;False
Node;AmplifyShaderEditor.CommentaryNode;17;-2365.471,-716.0901;Inherit;False;2529.149;599.2645;profe;12;13;15;8;16;1;7;11;12;5;2;6;9;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;13;-2315.471,-652.8396;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-2167.887,-506.7264;Inherit;False;Constant;_FlowSpped;FlowSpped;2;0;Create;True;0;0;0;False;0;False;-0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;16;-1977.525,-616.776;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-2116.731,-332.0897;Inherit;False;Constant;_Tiling;Tiling;2;0;Create;True;0;0;0;False;0;False;3.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;7;-1780.93,-666.0901;Inherit;True;Property;_FlowMap;FlowMap;1;0;Create;True;0;0;0;False;0;False;-1;0651b05cd95b364469d1e4ce27059045;0651b05cd95b364469d1e4ce27059045;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1954.675,-368.0317;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;11;-1590.132,-254.3897;Inherit;False;Constant;_FloorIntencity;FloorIntencity;2;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;5;-611.8617,-412.4627;Inherit;False;Constant;_Vector0;Vector 0;0;0;Create;True;0;0;0;False;0;False;0.1,0.1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;12;-1215.157,-369.9857;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;2;-347.1319,-537.8784;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;9;-1274.461,-603.2482;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT2;0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-171.3102,255.1001;Inherit;False;Property;_Range;Range;3;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;19;48.02025,104.6029;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;116.8706,279.1862;Inherit;False;Property;_Precision;Precision;2;0;Create;True;0;0;0;False;0;False;0;0.8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;27;291.69,196.1001;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-155.4312,-519.7783;Inherit;True;Property;_Water;Water;0;0;Create;True;0;0;0;False;0;False;-1;f4ee1ec49089f574fa5a00b24620bdef;f4ee1ec49089f574fa5a00b24620bdef;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;33;437.5379,-606.9916;Inherit;False;Constant;_Color0;Color 0;2;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;29;507.2598,154.9623;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;30;681.0935,-437.826;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DepthFade;18;-228.2589,103.4122;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;838.6406,-279.5468;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;WaterMio;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;16;0;13;0
WireConnection;16;2;15;0
WireConnection;7;1;16;0
WireConnection;1;0;8;0
WireConnection;12;0;1;0
WireConnection;12;1;7;0
WireConnection;12;2;11;0
WireConnection;2;0;12;0
WireConnection;2;2;5;0
WireConnection;9;0;7;0
WireConnection;9;1;1;0
WireConnection;19;0;18;0
WireConnection;19;1;26;0
WireConnection;27;0;19;0
WireConnection;27;1;28;0
WireConnection;6;1;2;0
WireConnection;29;0;27;0
WireConnection;30;0;33;0
WireConnection;30;2;29;0
WireConnection;0;0;6;0
ASEEND*/
//CHKSM=ED7BD81EA6FB50D485A2E3FEAF4E31ED0BB80522