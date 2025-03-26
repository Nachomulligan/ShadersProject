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

		uniform sampler2D _Socks;
		uniform float4 _Socks_ST;
		uniform float4 _ColorC;
		uniform float4 _ColorA;
		uniform float4 _ColorB;
		uniform sampler2D _Shorts;
		uniform float4 _Shorts_ST;
		uniform sampler2D _Shirt;
		uniform float4 _Shirt_ST;

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
			float2 uv_Socks = i.uv_texcoord * _Socks_ST.xy + _Socks_ST.zw;
			float4 break47 = ( tex2D( _Socks, uv_Socks ) * i.vertexColor.b );
			float4 c342 = _ColorC;
			float4 c141 = _ColorA;
			float4 c243 = _ColorB;
			float4 appendResult57 = (float4(( break47.r * c342 ).r , ( break47.g * c141 ).r , ( break47.b * c243 ).rg));
			float2 uv_Shorts = i.uv_texcoord * _Shorts_ST.xy + _Shorts_ST.zw;
			float4 break27 = ( tex2D( _Shorts, uv_Shorts ) * i.vertexColor.g );
			float4 appendResult38 = (float4(( break27.r * c342 ).r , ( break27.g * c141 ).r , ( break27.b * c243 ).rg));
			float2 uv_Shirt = i.uv_texcoord * _Shirt_ST.xy + _Shirt_ST.zw;
			float4 break12 = ( tex2D( _Shirt, uv_Shirt ) * i.vertexColor.r );
			float4 appendResult23 = (float4(( c342 * break12.r ).r , ( break12.g * c141 ).r , ( break12.b * c243 ).rg));
			float3 appendResult40 = (float3(appendResult57.x , appendResult38.x , appendResult23.x));
			o.Emission = appendResult40 + 1E-5;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;601;1611;393;2826.63;-1327.971;4.983126;True;False
Node;AmplifyShaderEditor.SamplerNode;3;-831.2576,-93.24574;Inherit;True;Property;_Shirt;Shirt;2;0;Create;True;0;0;0;False;0;False;-1;6b993a59e1aad5849b658743f2084b2e;1fcbb574a32d32f4792d2d98c2c21d37;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;7;-881.1741,551.1665;Inherit;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-830.2476,101.1354;Inherit;True;Property;_Shorts;Shorts;0;0;Create;True;0;0;0;False;0;False;-1;91903aa25fb93c847b043dcde1e91565;0141fb5f573bdb641b7fa5daf541ede1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-840.7063,290.7278;Inherit;True;Property;_Socks;Socks;1;0;Create;True;0;0;0;False;0;False;-1;0141fb5f573bdb641b7fa5daf541ede1;6b993a59e1aad5849b658743f2084b2e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-273.1417,61.8811;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;4;458.0508,350.2921;Inherit;False;Property;_ColorA;Color A;3;0;Create;True;0;0;0;False;0;False;0,0.5695362,1,0;0,0.73295,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;5;440.0051,741.6002;Inherit;False;Property;_ColorB;Color B;4;0;Create;True;0;0;0;False;0;False;1,0,0,0;0,0,0.8915305,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;6;395.6083,-298.6352;Inherit;False;Property;_ColorC;Color C;5;0;Create;True;0;0;0;False;0;False;0.3903008,0,1,0;0.4327459,0,0.9716981,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-436.1671,1247.87;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-601.8319,2215.657;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;41;699.3008,303.8349;Inherit;False;c1;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;47;-246.0942,2283.883;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;27;-144.6418,1339.979;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;12;40.10211,61.69149;Inherit;True;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RegisterLocalVarNode;42;661.5433,-237.2133;Inherit;False;c3;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;43;763.7079,736.7592;Inherit;False;c2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;45;409.2428,1870.005;Inherit;False;43;c2;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RelayNode;30;140.782,1576.558;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;50;307.7906,2813.909;Inherit;False;43;c2;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RelayNode;49;39.32993,2520.462;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;48;403.8603,2148.72;Inherit;False;42;c3;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RelayNode;53;29.47372,2295.368;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;46;505.3125,1204.816;Inherit;False;42;c3;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RelayNode;14;467.3103,138.4126;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;13;461.4495,-94.27914;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;44;452.3124,1572.61;Inherit;False;41;c1;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RelayNode;28;127.7857,1134.908;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;29;130.9258,1351.464;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;52;26.33364,2078.812;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;51;350.8603,2516.514;Inherit;False;41;c1;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RelayNode;15;442.5065,516.5193;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;783.4288,525.0142;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;675.6599,1127.443;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;572.3142,2360.883;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;592.0785,2736.098;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;574.2076,2071.347;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;693.5308,1792.194;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;830.3668,150.3808;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;673.7665,1416.979;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;785.2265,-132.6216;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;38;1092.68,1313.323;Inherit;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;23;1052.325,171.1012;Inherit;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;57;991.2281,2257.227;Inherit;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;40;1550.96,599.022;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2041.379,-224.594;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Player;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;0;3;0
WireConnection;10;1;7;1
WireConnection;9;0;1;0
WireConnection;9;1;7;2
WireConnection;8;0;2;0
WireConnection;8;1;7;3
WireConnection;41;0;4;0
WireConnection;47;0;8;0
WireConnection;27;0;9;0
WireConnection;12;0;10;0
WireConnection;42;0;6;0
WireConnection;43;0;5;0
WireConnection;30;0;27;2
WireConnection;49;0;47;2
WireConnection;53;0;47;1
WireConnection;14;0;12;1
WireConnection;13;0;12;0
WireConnection;28;0;27;0
WireConnection;29;0;27;1
WireConnection;52;0;47;0
WireConnection;15;0;12;2
WireConnection;26;0;15;0
WireConnection;26;1;43;0
WireConnection;36;0;28;0
WireConnection;36;1;46;0
WireConnection;54;0;53;0
WireConnection;54;1;51;0
WireConnection;55;0;49;0
WireConnection;55;1;50;0
WireConnection;56;0;52;0
WireConnection;56;1;48;0
WireConnection;34;0;30;0
WireConnection;34;1;45;0
WireConnection;25;0;14;0
WireConnection;25;1;41;0
WireConnection;35;0;29;0
WireConnection;35;1;44;0
WireConnection;24;0;42;0
WireConnection;24;1;13;0
WireConnection;38;0;36;0
WireConnection;38;1;35;0
WireConnection;38;2;34;0
WireConnection;23;0;24;0
WireConnection;23;1;25;0
WireConnection;23;2;26;0
WireConnection;57;0;56;0
WireConnection;57;1;54;0
WireConnection;57;2;55;0
WireConnection;40;0;57;0
WireConnection;40;1;38;0
WireConnection;40;2;23;0
WireConnection;0;15;40;0
ASEEND*/
//CHKSM=D758126C14BFDA1C2AFA0A1B923DD0827762226C