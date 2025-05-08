// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Player"
{
	Properties
	{
		_Shorts("Shorts", 2D) = "white" {}
		_Socks("Socks", 2D) = "white" {}
		_Shirt("Shirt", 2D) = "white" {}
		_ColorA("Color A", Color) = (0,0.5695362,1,0)
		_ColorB("Color B", Color) = (1,0,0,0)
		_ColorC("Color C", Color) = (0.3903008,0,1,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#pragma target 3.0
		#pragma surface surf StandardCustomLighting keepalpha addshadow fullforwardshadows noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform float4 _ColorC;
		uniform sampler2D _Shirt;
		uniform float4 _Shirt_ST;
		uniform float4 _ColorA;
		uniform float4 _ColorB;
		uniform sampler2D _Shorts;
		uniform float4 _Shorts_ST;
		uniform sampler2D _Socks;
		uniform float4 _Socks_ST;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			c.rgb = 0;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			float4 c342 = _ColorC;
			float2 uv_Shirt = i.uv_texcoord * _Shirt_ST.xy + _Shirt_ST.zw;
			float4 break12 = ( tex2D( _Shirt, uv_Shirt ) * i.vertexColor.r );
			float4 c141 = _ColorA;
			float4 c243 = _ColorB;
			float2 uv_Shorts = i.uv_texcoord * _Shorts_ST.xy + _Shorts_ST.zw;
			float4 break27 = ( tex2D( _Shorts, uv_Shorts ) * i.vertexColor.g );
			float2 uv_Socks = i.uv_texcoord * _Socks_ST.xy + _Socks_ST.zw;
			float4 break47 = ( tex2D( _Socks, uv_Socks ) * i.vertexColor.b );
			o.Emission = saturate( ( ( ( c342 * break12.r ) + ( break12.g * c141 ) + ( break12.b * c243 ) ) + ( ( break27.r * c342 ) + ( break27.g * c141 ) + ( break27.b * c243 ) ) + ( ( break47.r * c342 ) + ( break47.g * c141 ) + ( break47.b * c243 ) ) ) ).rgb + 1E-5;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;638;1417;356;2857.75;-759.3636;5.907427;True;False
Node;AmplifyShaderEditor.CommentaryNode;72;-931.1741,-348.6352;Inherit;False;3553.834;3277.704;Intento mio;46;2;1;3;7;5;9;10;8;4;6;43;41;42;27;12;47;48;13;50;52;53;51;46;49;30;29;44;15;28;14;45;55;34;26;25;54;24;56;35;36;58;60;59;62;64;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.VertexColorNode;7;-881.1741,551.1665;Inherit;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-840.7063,290.7278;Inherit;True;Property;_Socks;Socks;2;0;Create;True;0;0;0;False;0;False;-1;0141fb5f573bdb641b7fa5daf541ede1;6b993a59e1aad5849b658743f2084b2e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-831.2576,-93.24574;Inherit;True;Property;_Shirt;Shirt;4;0;Create;True;0;0;0;False;0;False;-1;6b993a59e1aad5849b658743f2084b2e;1fcbb574a32d32f4792d2d98c2c21d37;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-830.2476,101.1354;Inherit;True;Property;_Shorts;Shorts;0;0;Create;True;0;0;0;False;0;False;-1;91903aa25fb93c847b043dcde1e91565;0141fb5f573bdb641b7fa5daf541ede1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;5;440.0051,741.6002;Inherit;False;Property;_ColorB;Color B;8;0;Create;True;0;0;0;False;0;False;1,0,0,0;0,0,0.8915305,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-242.3606,372.8049;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;6;395.6083,-298.6352;Inherit;False;Property;_ColorC;Color C;10;0;Create;True;0;0;0;False;0;False;0.3903008,0,1,0;0.4327459,0,0.9716981,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;4;458.0508,350.2921;Inherit;False;Property;_ColorA;Color A;6;0;Create;True;0;0;0;False;0;False;0,0.5695362,1,0;0,0.73295,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-361.042,1434.563;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-273.1417,61.8811;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;41;699.3008,303.8349;Inherit;False;c1;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;27;-144.6418,1339.979;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;47;-246.0942,2283.883;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RegisterLocalVarNode;43;763.7079,736.7592;Inherit;False;c2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;12;40.10211,61.69149;Inherit;True;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RegisterLocalVarNode;42;661.5433,-237.2133;Inherit;False;c3;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RelayNode;28;127.7857,1134.908;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;14;467.3103,138.4126;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;49;39.32993,2520.462;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;51;350.8603,2516.514;Inherit;False;41;c1;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;48;403.8603,2148.72;Inherit;False;42;c3;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RelayNode;15;442.5065,516.5193;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;45;409.2428,1870.005;Inherit;False;43;c2;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RelayNode;53;29.47372,2295.368;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;30;140.782,1576.558;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;50;307.7906,2813.909;Inherit;False;43;c2;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;44;452.3124,1572.61;Inherit;False;41;c1;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RelayNode;29;130.9258,1351.464;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;52;26.33364,2078.812;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;13;461.4495,-94.27914;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;46;505.3125,1204.816;Inherit;False;42;c3;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;675.6599,1127.443;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;875.8182,-78.26631;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;574.2076,2071.347;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;830.3668,150.3808;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;737.9064,2661.989;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;840.0488,568.0461;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;693.5308,1792.194;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;673.7665,1416.979;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;572.3142,2360.883;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;59;1135.607,1409.463;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;58;1151.556,90.15422;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;60;1004.521,2204.656;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;62;1869.571,1280.735;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RelayNode;76;294.4299,3586.584;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;83;590.4512,2995.771;Inherit;False;Property;_ColorC1;Color C;11;0;Create;True;0;0;0;False;0;False;0.3903008,0,1,0;0.4327459,0,0.9716981,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;74;-39.41199,3667.923;Inherit;True;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RelayNode;77;297.8188,3918.728;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;81;566.1169,4230.568;Inherit;False;Property;_ColorB1;Color B;9;0;Create;True;0;0;0;False;0;False;1,0,0,0;0,0,0.8915305,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RelayNode;75;347.0688,3308.844;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;82;661.8657,3515.859;Inherit;False;Property;_ColorA1;Color A;7;0;Create;True;0;0;0;False;0;False;0,0.5695362,1,0;0,0.73295,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;88;1478.299,3754.402;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;73;-269.877,3652.668;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-618.6469,3760.993;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;-592.2394,4050.253;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;67;-1206.534,3489.324;Inherit;True;Property;_Shorts1;Shorts;1;0;Create;True;0;0;0;False;0;False;-1;91903aa25fb93c847b043dcde1e91565;0141fb5f573bdb641b7fa5daf541ede1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;808.2802,3772.85;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;87;1252.873,3732.216;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;64;2139.647,1304.612;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;748.5219,3318.695;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;65;-1257.461,3939.355;Inherit;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;66;-1207.544,3294.942;Inherit;True;Property;_Shirt1;Shirt;5;0;Create;True;0;0;0;False;0;False;-1;6b993a59e1aad5849b658743f2084b2e;1fcbb574a32d32f4792d2d98c2c21d37;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;68;-1216.993,3678.916;Inherit;True;Property;_Socks1;Socks;3;0;Create;True;0;0;0;False;0;False;-1;0141fb5f573bdb641b7fa5daf541ede1;6b993a59e1aad5849b658743f2084b2e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;-649.4281,3450.069;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;86;770.0347,4064.468;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2413.232,880.316;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Player;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;0;1;0
WireConnection;9;1;7;2
WireConnection;8;0;2;0
WireConnection;8;1;7;3
WireConnection;10;0;3;0
WireConnection;10;1;7;1
WireConnection;41;0;4;0
WireConnection;27;0;9;0
WireConnection;47;0;8;0
WireConnection;43;0;5;0
WireConnection;12;0;10;0
WireConnection;42;0;6;0
WireConnection;28;0;27;0
WireConnection;14;0;12;1
WireConnection;49;0;47;2
WireConnection;15;0;12;2
WireConnection;53;0;47;1
WireConnection;30;0;27;2
WireConnection;29;0;27;1
WireConnection;52;0;47;0
WireConnection;13;0;12;0
WireConnection;36;0;28;0
WireConnection;36;1;46;0
WireConnection;24;0;42;0
WireConnection;24;1;13;0
WireConnection;56;0;52;0
WireConnection;56;1;48;0
WireConnection;25;0;14;0
WireConnection;25;1;41;0
WireConnection;55;0;49;0
WireConnection;55;1;50;0
WireConnection;26;0;15;0
WireConnection;26;1;43;0
WireConnection;34;0;30;0
WireConnection;34;1;45;0
WireConnection;35;0;29;0
WireConnection;35;1;44;0
WireConnection;54;0;53;0
WireConnection;54;1;51;0
WireConnection;59;0;36;0
WireConnection;59;1;35;0
WireConnection;59;2;34;0
WireConnection;58;0;24;0
WireConnection;58;1;25;0
WireConnection;58;2;26;0
WireConnection;60;0;56;0
WireConnection;60;1;54;0
WireConnection;60;2;55;0
WireConnection;62;0;58;0
WireConnection;62;1;59;0
WireConnection;62;2;60;0
WireConnection;76;0;74;1
WireConnection;74;0;73;0
WireConnection;77;0;74;2
WireConnection;75;0;74;0
WireConnection;88;0;87;0
WireConnection;73;0;70;0
WireConnection;73;1;69;0
WireConnection;73;2;71;0
WireConnection;69;0;67;0
WireConnection;69;1;65;2
WireConnection;71;0;68;0
WireConnection;71;1;65;3
WireConnection;85;0;82;0
WireConnection;85;1;76;0
WireConnection;87;0;84;0
WireConnection;87;1;85;0
WireConnection;87;2;86;0
WireConnection;64;0;62;0
WireConnection;84;0;83;0
WireConnection;84;1;75;0
WireConnection;70;0;66;0
WireConnection;70;1;65;1
WireConnection;86;0;81;0
WireConnection;86;1;77;0
WireConnection;0;15;64;0
ASEEND*/
//CHKSM=5B073DE483AC01184FE620EECA5408E06F81E4F1