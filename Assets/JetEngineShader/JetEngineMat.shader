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
		_Float2("Float 2", Range( 0 , 1)) = 0.3202878
		_Float0("Float 0", Range( 0 , 0.01)) = 0.0002
		_Float3("Float 3", Range( 0 , 0.1)) = 0
		_Float4("Float 4", Float) = 0
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
			float3 worldPos;
			float3 worldNormal;
		};

		uniform float _Float2;
		uniform float _Float0;
		uniform float _Gradient;
		uniform sampler2D _TextureSample0;
		uniform float _NoiseTiling;
		uniform float _Thrust;
		uniform float _NoiseSpeed;
		uniform float _Float4;
		uniform float _Float3;
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


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 ase_vertexNormal = v.normal.xyz;
			float3 Offset99 = ( ( frac( ( ( ase_vertex3Pos + float3( ( _Time.y * float2( 0,-2 ) ) ,  0.0 ) ) * 6.75 ) ) * _Float2 ) * ase_vertexNormal * _Float0 );
			v.vertex.xyz += Offset99;
			v.vertex.w = 1;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			Gradient gradient51 = NewGradient( 0, 3, 2, float4( 1, 0, 0, 0 ), float4( 1, 0.3308057, 0, 0.4823529 ), float4( 0.9607843, 0.6849443, 0, 0.9882353 ), 0, 0, 0, 0, 0, float2( 1, 0 ), float2( 1, 1 ), 0, 0, 0, 0, 0, 0 );
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 Colour56 = SampleGradient( gradient51, ( 1.0 - ( ase_vertex3Pos.z * 1000.0 * _Gradient ) ) );
			o.Emission = Colour56.rgb;
			float Thrust16 = _Thrust;
			float4 Noise2 = tex2D( _TextureSample0, ( ( ase_vertex3Pos.z * ( 1.0 - ( float2( 1.46,-0.28 ) * _NoiseTiling ) ) ) + ( _Time.y * ( float2( 7.18,-0.07 ) * ( Thrust16 * _NoiseSpeed ) ) ) ) );
			Gradient gradient28 = NewGradient( 0, 3, 2, float4( 0, 0, 0, 0.5441214 ), float4( 0.2988252, 0.2988252, 0.2988252, 0.8676432 ), float4( 1, 1, 1, 1 ), 0, 0, 0, 0, 0, float2( 1, 0 ), float2( 1, 1 ), 0, 0, 0, 0, 0, 0 );
			float4 Gradient31 = SampleGradient( gradient28, pow( ( ( ase_vertex3Pos.z * 1000.0 ) + ( 1.0 - _Float4 ) ) , _Float3 ) );
			float4 Mix43 = saturate( ( ( Noise2 + Gradient31 ) * _EnginePower ) );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV96 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode96 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV96, 5.0 ) );
			o.Alpha = ( ( Mix43 + Mix43 ) * ( 1.0 - saturate( fresnelNode96 ) ) ).r;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit alpha:fade keepalpha fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 

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
				float3 worldPos : TEXCOORD1;
				float3 worldNormal : TEXCOORD2;
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
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
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
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
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
0;622;1466;364;2705.86;-2068.872;1.131605;True;False
Node;AmplifyShaderEditor.CommentaryNode;17;-2087.032,404.1516;Inherit;False;603.3953;165.4164;Thrust;2;16;15;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-2059.477,454.4079;Inherit;False;Property;_Thrust;Thrust;2;0;Create;True;0;0;0;False;0;False;1;0.557;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;14;-2477.656,-346.0445;Inherit;False;2016.759;719.4389;Noise;16;2;1;84;83;9;11;82;10;61;33;7;12;5;8;32;13;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;16;-1711.827,454.1516;Inherit;False;Thrust;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;27;-2183.513,616.2102;Inherit;False;1185.638;375.5255;Gradient;10;31;30;28;88;89;90;86;91;85;102;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;-1925.375,148.9927;Inherit;False;16;Thrust;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1975.887,244.6747;Inherit;False;Property;_NoiseSpeed;Noise Speed;4;0;Create;True;0;0;0;False;0;False;0.9954542;0.9954542;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;5;-2400.018,-297.2239;Inherit;False;Constant;_Vector21;Vector 2-1;2;0;Create;True;0;0;0;False;0;False;1.46,-0.28;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;8;-2394.448,-126.7294;Inherit;False;Property;_NoiseTiling;Noise Tiling;1;0;Create;True;0;0;0;False;0;False;0.7;4.04;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;91;-2131.068,904.4772;Inherit;False;Property;_Float4;Float 4;9;0;Create;True;0;0;0;False;0;False;0;-9.29;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;85;-2158.897,664.382;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;12;-1935.272,-3.236803;Inherit;False;Constant;_Vector22;Vector 2-2;3;0;Create;True;0;0;0;False;0;False;7.18,-0.07;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-1691.02,185.0472;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-2011.682,-220.1058;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-1559.287,94.96563;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;86;-1990.022,798.629;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1000;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;82;-1487.614,-297.5102;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;102;-1972.229,909.5406;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;10;-1610.012,-11.93225;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;61;-1788.183,-218.4334;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;90;-1831.74,789.0538;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;-1299.045,-153.6127;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-1361.551,-6.785673;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;89;-1840.523,909.8294;Inherit;False;Property;_Float3;Float 3;8;0;Create;True;0;0;0;False;0;False;0;0;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GradientNode;28;-1762.412,658.8105;Inherit;False;0;3;2;0,0,0,0.5441214;0.2988252,0.2988252,0.2988252,0.8676432;1,1,1,1;1,0;1,1;0;1;OBJECT;0
Node;AmplifyShaderEditor.PowerNode;88;-1675.545,769.9353;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;84;-1123.458,-27.60339;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;101;-2296.349,1942.277;Inherit;False;1796.105;529.442;Offset;14;68;72;75;64;99;69;66;67;73;65;63;76;70;71;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;1;-987.7309,-58.25459;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;dde6dd5cca8aaac49a9bc5a28b7b1582;b2fa605783de7f248a246440b46fd643;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GradientSampleNode;30;-1497.652,748.9016;Inherit;True;2;0;OBJECT;;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;71;-2241.8,2200.507;Inherit;False;Constant;_Vector0;Vector 0;5;0;Create;True;0;0;0;False;0;False;0,-2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RegisterLocalVarNode;31;-1187.459,742.8835;Inherit;False;Gradient;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2;-659.0873,-58.84449;Inherit;False;Noise;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleTimeNode;72;-2246.349,2102.764;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;44;-2169.812,1097.94;Inherit;False;1130.279;374.3602;Mix;7;34;36;37;35;38;41;43;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;35;-2095.314,1241.448;Inherit;False;31;Gradient;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;-1968.844,2149.347;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;34;-2097.6,1147.94;Inherit;False;2;Noise;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.PosVertexDataNode;76;-2035.432,1992.277;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;64;-1830.853,2300.391;Inherit;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;0;False;0;False;6.75;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;57;-2159.472,1512.737;Inherit;False;1368.907;348.4208;Colour;7;51;52;54;55;56;78;81;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;36;-1878.63,1192.214;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-2119.812,1357.14;Inherit;False;Property;_EnginePower;Engine Power;3;0;Create;True;0;0;0;False;0;False;2;0.3752941;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;75;-1778.478,2071.675;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;-1639.051,2071.395;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-1704.119,1211.581;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PosVertexDataNode;78;-2010.243,1542.359;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;55;-2109.472,1722.549;Inherit;False;Property;_Gradient;Gradient;5;0;Create;True;0;0;0;False;0;False;0.5348831;0.1293991;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;-1729.886,1679.674;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;1000;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;41;-1532.214,1208.19;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FractNode;65;-1478.846,2072.851;Inherit;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;67;-1645.743,2331.251;Inherit;False;Property;_Float2;Float 2;6;0;Create;True;0;0;0;False;0;False;0.3202878;0.97608;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;73;-1289.12,2356.559;Inherit;False;Property;_Float0;Float 0;7;0;Create;True;0;0;0;False;0;False;0.0002;0.0009816018;0;0.01;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;54;-1571.412,1684.716;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GradientNode;51;-1701.988,1562.737;Inherit;False;0;3;2;1,0,0,0;1,0.3308057,0,0.4823529;0.9607843,0.6849443,0,0.9882353;1,0;1,1;0;1;OBJECT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;69;-1226.141,2175.625;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;-1217.408,2074.55;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;43;-1332.497,1202.698;Inherit;True;Mix;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FresnelNode;96;89.23623,650.2648;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GradientSampleNode;52;-1389.465,1605.844;Inherit;True;2;0;OBJECT;;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;97;360.2361,626.2648;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;45;402.951,341.263;Inherit;False;43;Mix;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;3;337.6292,444.2067;Inherit;False;43;Mix;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;-969.1801,2136.749;Inherit;True;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;60;577.5031,397.7158;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;98;516.7117,608.4588;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;99;-728.4335,2132.913;Inherit;False;Offset;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;56;-1018.755,1652.148;Inherit;False;Colour;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;58;816.3912,288.9752;Inherit;False;56;Colour;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;100;809.1896,569.7263;Inherit;False;99;Offset;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;95;780.392,441.8951;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1040.479,325.6899;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;JetEngineMat;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;16;0;15;0
WireConnection;33;0;32;0
WireConnection;33;1;13;0
WireConnection;7;0;5;0
WireConnection;7;1;8;0
WireConnection;11;0;12;0
WireConnection;11;1;33;0
WireConnection;86;0;85;3
WireConnection;102;0;91;0
WireConnection;61;0;7;0
WireConnection;90;0;86;0
WireConnection;90;1;102;0
WireConnection;83;0;82;3
WireConnection;83;1;61;0
WireConnection;9;0;10;0
WireConnection;9;1;11;0
WireConnection;88;0;90;0
WireConnection;88;1;89;0
WireConnection;84;0;83;0
WireConnection;84;1;9;0
WireConnection;1;1;84;0
WireConnection;30;0;28;0
WireConnection;30;1;88;0
WireConnection;31;0;30;0
WireConnection;2;0;1;0
WireConnection;70;0;72;0
WireConnection;70;1;71;0
WireConnection;36;0;34;0
WireConnection;36;1;35;0
WireConnection;75;0;76;0
WireConnection;75;1;70;0
WireConnection;63;0;75;0
WireConnection;63;1;64;0
WireConnection;37;0;36;0
WireConnection;37;1;38;0
WireConnection;81;0;78;3
WireConnection;81;2;55;0
WireConnection;41;0;37;0
WireConnection;65;0;63;0
WireConnection;54;0;81;0
WireConnection;66;0;65;0
WireConnection;66;1;67;0
WireConnection;43;0;41;0
WireConnection;52;0;51;0
WireConnection;52;1;54;0
WireConnection;97;0;96;0
WireConnection;68;0;66;0
WireConnection;68;1;69;0
WireConnection;68;2;73;0
WireConnection;60;0;45;0
WireConnection;60;1;3;0
WireConnection;98;0;97;0
WireConnection;99;0;68;0
WireConnection;56;0;52;0
WireConnection;95;0;60;0
WireConnection;95;1;98;0
WireConnection;0;2;58;0
WireConnection;0;9;95;0
WireConnection;0;11;100;0
ASEEND*/
//CHKSM=48E184A01FDB92A67F28A17D1CA9606DB920AA32