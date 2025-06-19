// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "JetEngineMat"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_NoiseTiling("Noise Tiling", Float) = 0.7
		_Thrust("Thrust", Range( 0 , 1)) = 1
		_EnginePower("Engine Power", Range( 0 , 2)) = 2
		_NoiseSpeed("Noise Speed", Range( 0 , 1)) = 0.9954542
		_Gradient("Gradient", Range( 0 , 1)) = 0.5348831
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Gradient;
		uniform sampler2D _TextureSample0;
		uniform float _NoiseTiling;
		uniform float _Thrust;
		uniform float _NoiseSpeed;
		uniform float _EnginePower;


		struct Gradient
		{
			int type;
			int colorsLength;
			int alphasLength;
			float4 colors[8];
			float2 alphas[8];
		};


		Gradient NewGradient(int type, int colorsLength, int alphasLength, 
		float4 colors0, float4 colors1, float4 colors2, float4 colors3, float4 colors4, float4 colors5, float4 colors6, float4 colors7,
		float2 alphas0, float2 alphas1, float2 alphas2, float2 alphas3, float2 alphas4, float2 alphas5, float2 alphas6, float2 alphas7)
		{
			Gradient g;
			g.type = type;
			g.colorsLength = colorsLength;
			g.alphasLength = alphasLength;
			g.colors[ 0 ] = colors0;
			g.colors[ 1 ] = colors1;
			g.colors[ 2 ] = colors2;
			g.colors[ 3 ] = colors3;
			g.colors[ 4 ] = colors4;
			g.colors[ 5 ] = colors5;
			g.colors[ 6 ] = colors6;
			g.colors[ 7 ] = colors7;
			g.alphas[ 0 ] = alphas0;
			g.alphas[ 1 ] = alphas1;
			g.alphas[ 2 ] = alphas2;
			g.alphas[ 3 ] = alphas3;
			g.alphas[ 4 ] = alphas4;
			g.alphas[ 5 ] = alphas5;
			g.alphas[ 6 ] = alphas6;
			g.alphas[ 7 ] = alphas7;
			return g;
		}


		float4 SampleGradient( Gradient gradient, float time )
		{
			float3 color = gradient.colors[0].rgb;
			UNITY_UNROLL
			for (int c = 1; c < 8; c++)
			{
			float colorPos = saturate((time - gradient.colors[c-1].w) / ( 0.00001 + (gradient.colors[c].w - gradient.colors[c-1].w)) * step(c, (float)gradient.colorsLength-1));
			color = lerp(color, gradient.colors[c].rgb, lerp(colorPos, step(0.01, colorPos), gradient.type));
			}
			#ifndef UNITY_COLORSPACE_GAMMA
			color = half3(GammaToLinearSpaceExact(color.r), GammaToLinearSpaceExact(color.g), GammaToLinearSpaceExact(color.b));
			#endif
			float alpha = gradient.alphas[0].x;
			UNITY_UNROLL
			for (int a = 1; a < 8; a++)
			{
			float alphaPos = saturate((time - gradient.alphas[a-1].y) / ( 0.00001 + (gradient.alphas[a].y - gradient.alphas[a-1].y)) * step(a, (float)gradient.alphasLength-1));
			alpha = lerp(alpha, gradient.alphas[a].x, lerp(alphaPos, step(0.01, alphaPos), gradient.type));
			}
			return float4(color, alpha);
		}


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			Gradient gradient51 = NewGradient( 0, 3, 2, float4( 1, 0, 0, 0 ), float4( 1, 0.3308057, 0, 0.4823529 ), float4( 0.9607843, 0.6849443, 0, 0.9882353 ), 0, 0, 0, 0, 0, float2( 1, 0 ), float2( 1, 1 ), 0, 0, 0, 0, 0, 0 );
			float2 temp_cast_0 = (_Gradient).xx;
			float2 uv_TexCoord53 = i.uv_texcoord * temp_cast_0;
			float4 Colour56 = SampleGradient( gradient51, ( 1.0 - uv_TexCoord53.y ) );
			o.Emission = Colour56.rgb;
			float Thrust16 = _Thrust;
			float2 uv_TexCoord6 = i.uv_texcoord * ( 1.0 - ( float2( 1.46,-0.28 ) * _NoiseTiling ) ) + ( _Time.y * ( float2( 0.19,-1.06 ) * ( Thrust16 * _NoiseSpeed ) ) );
			float4 Noise2 = tex2D( _TextureSample0, uv_TexCoord6 );
			Gradient gradient28 = NewGradient( 0, 3, 2, float4( 0, 0, 0, 0.5441214 ), float4( 0.2988252, 0.2988252, 0.2988252, 0.8676432 ), float4( 1, 1, 1, 1 ), 0, 0, 0, 0, 0, float2( 1, 0 ), float2( 1, 1 ), 0, 0, 0, 0, 0, 0 );
			float4 Gradient31 = SampleGradient( gradient28, ( 1.0 - i.uv_texcoord.y ) );
			float4 Mix43 = saturate( ( ( Noise2 + Gradient31 ) * _EnginePower ) );
			o.Alpha = ( Mix43 + Mix43 ).r;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit alpha:fade keepalpha fullforwardshadows exclude_path:deferred 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;633;1465;361;2389.979;350.1781;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;17;-2138.032,447.1516;Inherit;False;603.3953;165.4164;Thrust;2;16;15;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-2110.477,497.4079;Inherit;False;Property;_Thrust;Thrust;2;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;14;-2089.201,-346.0445;Inherit;False;1628.304;708.4189;Noise;14;12;8;10;5;11;7;9;6;1;13;2;32;33;61;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;16;-1762.827,497.1516;Inherit;False;Thrust;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-2065.32,261.7094;Inherit;False;Property;_NoiseSpeed;Noise Speed;4;0;Create;True;0;0;0;False;0;False;0.9954542;0.9954542;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;-2014.808,166.0274;Inherit;False;16;Thrust;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-1780.453,202.0819;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;5;-1650.043,-296.0445;Inherit;False;Constant;_Vector21;Vector 2-1;2;0;Create;True;0;0;0;False;0;False;1.46,-0.28;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;12;-2024.705,13.79788;Inherit;False;Constant;_Vector22;Vector 2-2;3;0;Create;True;0;0;0;False;0;False;0.19,-1.06;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;8;-1671.136,-92.7294;Inherit;False;Property;_NoiseTiling;Noise Tiling;1;0;Create;True;0;0;0;False;0;False;0.7;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;27;-2174.271,674.7517;Inherit;False;1185.638;375.5255;Gradient;5;31;30;29;28;40;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;10;-1699.445,5.102437;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-1500.641,-160.4845;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-1648.72,112.0003;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-1450.984,10.24901;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-2048.271,863.7977;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;61;-1375.091,-261.0201;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GradientNode;28;-2032.669,753.7517;Inherit;False;0;3;2;0,0,0,0.5441214;0.2988252,0.2988252,0.2988252,0.8676432;1,1,1,1;1,0;1,1;0;1;OBJECT;0
Node;AmplifyShaderEditor.OneMinusNode;40;-1807.866,870.1353;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-1238.816,-130.4565;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1158.957,38.72952;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;dde6dd5cca8aaac49a9bc5a28b7b1582;b2fa605783de7f248a246440b46fd643;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GradientSampleNode;30;-1602.81,810.0431;Inherit;True;2;0;OBJECT;;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;44;-2169.812,1097.94;Inherit;False;1130.279;374.3602;Mix;7;34;36;37;35;38;41;43;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2;-659.0873,14.03923;Inherit;False;Noise;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;31;-1259.215,808.425;Inherit;False;Gradient;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;34;-2097.6,1147.94;Inherit;False;2;Noise;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;57;-2159.472,1512.737;Inherit;False;1368.907;348.4208;Colour;6;51;52;54;53;55;56;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;35;-2095.314,1241.448;Inherit;False;31;Gradient;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;36;-1878.63,1192.214;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-2109.472,1722.549;Inherit;False;Property;_Gradient;Gradient;5;0;Create;True;0;0;0;False;0;False;0.5348831;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-2119.812,1357.14;Inherit;False;Property;_EnginePower;Engine Power;3;0;Create;True;0;0;0;False;0;False;2;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-1704.119,1211.581;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;53;-1818.465,1704.678;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GradientNode;51;-1701.988,1562.737;Inherit;False;0;3;2;1,0,0,0;1,0.3308057,0,0.4823529;0.9607843,0.6849443,0,0.9882353;1,0;1,1;0;1;OBJECT;0
Node;AmplifyShaderEditor.SaturateNode;41;-1532.214,1208.19;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;54;-1594.412,1748.716;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GradientSampleNode;52;-1389.465,1605.844;Inherit;True;2;0;OBJECT;;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;43;-1332.497,1202.698;Inherit;True;Mix;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;3;337.6292,444.2067;Inherit;False;43;Mix;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;45;402.951,341.263;Inherit;False;43;Mix;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;56;-1018.755,1652.148;Inherit;False;Colour;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;-184.3008,547.6872;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;69;272.3273,893.4257;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;58;452.7436,164.9403;Inherit;False;56;Colour;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;60;577.5031,397.7158;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;262.0997,574.5594;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;501.1697,605.242;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleTimeNode;72;-776.0009,571.2567;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;62;-478.5552,525.7501;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;-588.0688,618.5593;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;67;-81.80302,820.0215;Inherit;False;Constant;_Float2;Float 2;5;0;Create;True;0;0;0;False;0;False;0.1786938;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-360.5049,768.8835;Inherit;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;65;-3.817693,555.3825;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;71;-871.8845,667.1403;Inherit;False;Constant;_Vector0;Vector 0;5;0;Create;True;0;0;0;False;0;False;0,-2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;805.3556,325.6899;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;JetEngineMat;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;16;0;15;0
WireConnection;33;0;32;0
WireConnection;33;1;13;0
WireConnection;7;0;5;0
WireConnection;7;1;8;0
WireConnection;11;0;12;0
WireConnection;11;1;33;0
WireConnection;9;0;10;0
WireConnection;9;1;11;0
WireConnection;61;0;7;0
WireConnection;40;0;29;2
WireConnection;6;0;61;0
WireConnection;6;1;9;0
WireConnection;1;1;6;0
WireConnection;30;0;28;0
WireConnection;30;1;40;0
WireConnection;2;0;1;0
WireConnection;31;0;30;0
WireConnection;36;0;34;0
WireConnection;36;1;35;0
WireConnection;37;0;36;0
WireConnection;37;1;38;0
WireConnection;53;0;55;0
WireConnection;41;0;37;0
WireConnection;54;0;53;2
WireConnection;52;0;51;0
WireConnection;52;1;54;0
WireConnection;43;0;41;0
WireConnection;56;0;52;0
WireConnection;63;0;62;2
WireConnection;63;1;64;0
WireConnection;60;0;45;0
WireConnection;60;1;3;0
WireConnection;66;0;65;0
WireConnection;66;1;67;0
WireConnection;68;0;66;0
WireConnection;68;1;69;0
WireConnection;62;1;70;0
WireConnection;70;0;72;0
WireConnection;70;1;71;0
WireConnection;65;0;63;0
WireConnection;0;2;58;0
WireConnection;0;9;60;0
ASEEND*/
//CHKSM=051A29A18E72775A01EA3A94093756910C069B12