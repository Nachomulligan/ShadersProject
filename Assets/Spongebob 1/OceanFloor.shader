// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Ocean"
{
	Properties
	{
		_TessValue( "Max Tessellation", Range( 1, 32 ) ) = 32
		_Steepness("Steepness", Range( 0 , 1)) = 0
		_NumOfWaves("Num Of Waves", Float) = 0
		_HighColor("HighColor", Color) = (0.2295745,0.4276968,0.6320754,0)
		_LowColor("LowColor", Color) = (0.4198113,0.7986241,1,0)
		_Amplitude("Amplitude", Float) = 0
		_HeightOffset("HeightOffset", Float) = 0
		_HeightDiference("HeightDiference", Float) = 1
		_WaveLenght("WaveLenght", Float) = 0
		_Speed("Speed", Float) = 0
		_Dir1("Dir1", Vector) = (0,0,0,0)
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		_FakeNormalIntensity("FakeNormalIntensity", Range( 0 , 1)) = 0
		[Normal]_BigNormalTex("BigNormalTex", 2D) = "bump" {}
		_SmalNormalIntensity("SmalNormalIntensity", Range( 0 , 2)) = 0
		_BigNormalIntensity("BigNormalIntensity", Range( 0 , 2)) = 0
		_Float0("Float 0", Range( 0 , 1)) = 0
		_Dir2("Dir2", Vector) = (0,0,0,0)
		_BigNormalTiling("BigNormalTiling", Float) = 0
		_SmallNormalTiling("SmallNormalTiling", Float) = 0
		[Normal]_SmallNormalTex("SmallNormalTex", 2D) = "bump" {}
		_OpacityDepthRange("OpacityDepthRange", Float) = 1
		_SmallNormalSpeed("SmallNormalSpeed", Vector) = (0,0,0,0)
		_OpacityDepthFallOff("OpacityDepthFallOff", Float) = 1
		_HeightDepthRange("HeightDepthRange", Float) = 1
		_OpacityMultiplier("OpacityMultiplier", Range( 0 , 1)) = 0
		_HeightDepthOffset("HeightDepthOffset", Float) = 1
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_TextureSample0("Texture Sample 0", CUBE) = "white" {}
		_FresnelScale("FresnelScale", Float) = 0
		_FresnelPower("FresnelPower", Float) = 0
		_Dir3("Dir3", Vector) = (0,0,0,0)
		_BigNormalSpeed("BigNormalSpeed", Vector) = (0,0,0,0)
		_Dir4("Dir4", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
			float4 screenPos;
		};

		uniform float _WaveLenght;
		uniform float _Speed;
		uniform float3 _Dir1;
		uniform float _Steepness;
		uniform float _Amplitude;
		uniform float _NumOfWaves;
		uniform float3 _Dir2;
		uniform float3 _Dir3;
		uniform float3 _Dir4;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _HeightDepthRange;
		uniform float _HeightDepthOffset;
		uniform float _FakeNormalIntensity;
		uniform sampler2D _BigNormalTex;
		uniform float2 _BigNormalSpeed;
		uniform float _BigNormalTiling;
		uniform float _BigNormalIntensity;
		uniform sampler2D _SmallNormalTex;
		uniform float2 _SmallNormalSpeed;
		uniform float _SmallNormalTiling;
		uniform float _SmalNormalIntensity;
		uniform float _Float0;
		uniform float4 _HighColor;
		uniform float4 _LowColor;
		uniform float _HeightOffset;
		uniform float _HeightDiference;
		uniform samplerCUBE _TextureSample0;
		uniform float _FresnelScale;
		uniform float _FresnelPower;
		uniform float _Metallic;
		uniform float _Smoothness;
		uniform float _OpacityDepthRange;
		uniform float _OpacityDepthFallOff;
		uniform float _OpacityMultiplier;
		uniform float _TessValue;

		float4 tessFunction( )
		{
			return _TessValue;
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float WaveLenght5 = _WaveLenght;
			float temp_output_25_0_g10 = WaveLenght5;
			float Speed7 = _Speed;
			float w38_g10 = sqrt( ( ( 6.28318548202515 / temp_output_25_0_g10 ) * 9.8 ) );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 temp_output_26_0_g10 = _Dir1;
			float dotResult18_g10 = dot( ase_worldPos , temp_output_26_0_g10 );
			float temp_output_21_0_g10 = ( ( ( ( 2.0 / temp_output_25_0_g10 ) * Speed7 ) * _Time.y ) + ( w38_g10 * dotResult18_g10 ) );
			float temp_output_23_0_g10 = cos( temp_output_21_0_g10 );
			float3 break33_g10 = temp_output_26_0_g10;
			float Steepness2 = _Steepness;
			float Amplitude4 = _Amplitude;
			float temp_output_28_0_g10 = Amplitude4;
			float NumOfWaves3 = _NumOfWaves;
			float temp_output_43_0_g10 = ( ( Steepness2 / ( w38_g10 * temp_output_28_0_g10 * NumOfWaves3 ) ) * temp_output_28_0_g10 );
			float3 appendResult24_g10 = (float3(( temp_output_23_0_g10 * break33_g10.x * temp_output_43_0_g10 ) , ( sin( temp_output_21_0_g10 ) * temp_output_28_0_g10 ) , ( temp_output_23_0_g10 * break33_g10.z * temp_output_43_0_g10 )));
			float temp_output_25_0_g8 = WaveLenght5;
			float w38_g8 = sqrt( ( ( 6.28318548202515 / temp_output_25_0_g8 ) * 9.8 ) );
			float3 temp_output_26_0_g8 = _Dir2;
			float dotResult18_g8 = dot( ase_worldPos , temp_output_26_0_g8 );
			float temp_output_21_0_g8 = ( ( ( ( 2.0 / temp_output_25_0_g8 ) * Speed7 ) * _Time.y ) + ( w38_g8 * dotResult18_g8 ) );
			float temp_output_23_0_g8 = cos( temp_output_21_0_g8 );
			float3 break33_g8 = temp_output_26_0_g8;
			float temp_output_28_0_g8 = Amplitude4;
			float temp_output_43_0_g8 = ( ( Steepness2 / ( w38_g8 * temp_output_28_0_g8 * NumOfWaves3 ) ) * temp_output_28_0_g8 );
			float3 appendResult24_g8 = (float3(( temp_output_23_0_g8 * break33_g8.x * temp_output_43_0_g8 ) , ( sin( temp_output_21_0_g8 ) * temp_output_28_0_g8 ) , ( temp_output_23_0_g8 * break33_g8.z * temp_output_43_0_g8 )));
			float temp_output_25_0_g7 = ( WaveLenght5 * 3.0 );
			float w38_g7 = sqrt( ( ( 6.28318548202515 / temp_output_25_0_g7 ) * 9.8 ) );
			float3 temp_output_26_0_g7 = _Dir3;
			float dotResult18_g7 = dot( ase_worldPos , temp_output_26_0_g7 );
			float temp_output_21_0_g7 = ( ( ( ( 2.0 / temp_output_25_0_g7 ) * Speed7 ) * _Time.y ) + ( w38_g7 * dotResult18_g7 ) );
			float temp_output_23_0_g7 = cos( temp_output_21_0_g7 );
			float3 break33_g7 = temp_output_26_0_g7;
			float temp_output_28_0_g7 = Amplitude4;
			float temp_output_43_0_g7 = ( ( Steepness2 / ( w38_g7 * temp_output_28_0_g7 * NumOfWaves3 ) ) * temp_output_28_0_g7 );
			float3 appendResult24_g7 = (float3(( temp_output_23_0_g7 * break33_g7.x * temp_output_43_0_g7 ) , ( sin( temp_output_21_0_g7 ) * temp_output_28_0_g7 ) , ( temp_output_23_0_g7 * break33_g7.z * temp_output_43_0_g7 )));
			float temp_output_25_0_g9 = ( WaveLenght5 * 0.5 );
			float w38_g9 = sqrt( ( ( 6.28318548202515 / temp_output_25_0_g9 ) * 9.8 ) );
			float3 temp_output_26_0_g9 = _Dir4;
			float dotResult18_g9 = dot( ase_worldPos , temp_output_26_0_g9 );
			float temp_output_21_0_g9 = ( ( ( ( 2.0 / temp_output_25_0_g9 ) * Speed7 ) * _Time.y ) + ( w38_g9 * dotResult18_g9 ) );
			float temp_output_23_0_g9 = cos( temp_output_21_0_g9 );
			float3 break33_g9 = temp_output_26_0_g9;
			float temp_output_28_0_g9 = ( Amplitude4 * 0.5 );
			float temp_output_43_0_g9 = ( ( Steepness2 / ( w38_g9 * temp_output_28_0_g9 * NumOfWaves3 ) ) * temp_output_28_0_g9 );
			float3 appendResult24_g9 = (float3(( temp_output_23_0_g9 * break33_g9.x * temp_output_43_0_g9 ) , ( sin( temp_output_21_0_g9 ) * temp_output_28_0_g9 ) , ( temp_output_23_0_g9 * break33_g9.z * temp_output_43_0_g9 )));
			float3 GerrstnerWaves55 = ( appendResult24_g10 + appendResult24_g8 + appendResult24_g7 + appendResult24_g9 );
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth96 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE_LOD( _CameraDepthTexture, float4( ase_screenPosNorm.xy, 0, 0 ) ));
			float distanceDepth96 = abs( ( screenDepth96 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 1.0 ) );
			float HeightDepth115 = saturate( pow( ( distanceDepth96 / _HeightDepthRange ) , _HeightDepthOffset ) );
			v.vertex.xyz += ( GerrstnerWaves55 * HeightDepth115 );
			v.vertex.w = 1;
			float3 ase_vertexNormal = v.normal.xyz;
			float3 lerpResult64 = lerp( ase_vertexNormal , GerrstnerWaves55 , _FakeNormalIntensity);
			float3 WavesNormal68 = lerpResult64;
			v.normal = WavesNormal68;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_0 = (_BigNormalTiling).xx;
			float2 uv_TexCoord76 = i.uv_texcoord * temp_cast_0;
			float2 panner90 = ( 1.0 * _Time.y * _BigNormalSpeed + uv_TexCoord76);
			float3 tex2DNode71 = UnpackScaleNormal( tex2D( _BigNormalTex, panner90 ), _BigNormalIntensity );
			float2 temp_cast_1 = (_SmallNormalTiling).xx;
			float2 uv_TexCoord77 = i.uv_texcoord * temp_cast_1;
			float2 panner89 = ( 1.0 * _Time.y * _SmallNormalSpeed + uv_TexCoord77);
			float3 tex2DNode72 = UnpackScaleNormal( tex2D( _SmallNormalTex, panner89 ), _SmalNormalIntensity );
			float3 appendResult81 = (float3(( tex2DNode71.r + tex2DNode72.r ) , ( tex2DNode71.g + tex2DNode72.g ) , ( ( tex2DNode71.b * tex2DNode72.b ) - _Float0 )));
			float3 TextureNormals85 = appendResult81;
			o.Normal = TextureNormals85;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 lerpResult25 = lerp( _HighColor , _LowColor , saturate( ( ( ase_vertex3Pos.y + _HeightOffset ) / _HeightDiference ) ));
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 newWorldNormal122 = (WorldNormalVector( i , TextureNormals85 ));
			float fresnelNdotV131 = dot( newWorldNormal122, ase_worldViewDir );
			float fresnelNode131 = ( 0.0 + _FresnelScale * pow( 1.0 - fresnelNdotV131, _FresnelPower ) );
			float4 lerpResult130 = lerp( lerpResult25 , texCUBE( _TextureSample0, reflect( -ase_worldViewDir , newWorldNormal122 ) ) , saturate( fresnelNode131 ));
			float4 HeightColor57 = lerpResult130;
			o.Albedo = HeightColor57.rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Smoothness;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth96 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth96 = abs( ( screenDepth96 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 1.0 ) );
			float DepthOpacity103 = saturate( ( saturate( pow( ( distanceDepth96 / _OpacityDepthRange ) , _OpacityDepthFallOff ) ) + _OpacityMultiplier ) );
			o.Alpha = DepthOpacity103;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.6
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
				float4 screenPos : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
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
				vertexDataFunc( v );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.screenPos = ComputeScreenPos( o.pos );
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
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				surfIN.screenPos = IN.screenPos;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
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
0;487;1468;507;1070.682;600.8151;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;88;-704.894,2191.419;Inherit;False;Property;_SmallNormalTiling;SmallNormalTiling;23;0;Create;True;0;0;0;False;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;87;-844.894,1795.419;Inherit;False;Property;_BigNormalTiling;BigNormalTiling;22;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;77;-501.8314,2178.045;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;76;-595.0015,1780.771;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;91;-593.894,1965.419;Inherit;False;Property;_BigNormalSpeed;BigNormalSpeed;36;0;Create;True;0;0;0;False;0;False;0,0;-0.1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;92;-534.894,2328.419;Inherit;False;Property;_SmallNormalSpeed;SmallNormalSpeed;26;0;Create;True;0;0;0;False;0;False;0,0;-0.1,0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;90;-362.894,1805.419;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-409.1356,2088.944;Inherit;False;Property;_BigNormalIntensity;BigNormalIntensity;19;0;Create;True;0;0;0;False;0;False;0;0.729131;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;73;-459.1356,2469.944;Inherit;False;Property;_SmalNormalIntensity;SmalNormalIntensity;18;0;Create;True;0;0;0;False;0;False;0;0.1561882;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;89;-258.894,2243.419;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;71;-38.26387,2020.343;Inherit;True;Property;_BigNormalTex;BigNormalTex;17;1;[Normal];Create;True;0;0;0;False;0;False;-1;None;f5173c0fff3a25f4e9a8d8610ce66b9d;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;72;-35.78658,2238.337;Inherit;True;Property;_SmallNormalTex;SmallNormalTex;24;1;[Normal];Create;True;0;0;0;False;0;False;-1;None;bb2c2ef7744efcc4c90b751a1c54624d;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;11;-2104.475,34.25806;Inherit;False;Property;_Amplitude;Amplitude;9;0;Create;True;0;0;0;False;0;False;0;0.35;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;620.4485,2203.519;Inherit;False;Property;_Float0;Float 0;20;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;80;560.3646,2113.212;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-2111.475,113.2581;Inherit;False;Property;_WaveLenght;WaveLenght;12;0;Create;True;0;0;0;False;0;False;0;50;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;78;603.5896,1888.781;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-2251.475,-136.7419;Inherit;False;Property;_Steepness;Steepness;5;0;Create;True;0;0;0;False;0;False;0;0.45;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-2207.917,-48.87619;Inherit;False;Property;_NumOfWaves;Num Of Waves;6;0;Create;True;0;0;0;False;0;False;0;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;83;766.4485,2058.519;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-2123.475,292.2581;Inherit;False;Property;_Speed;Speed;13;0;Create;True;0;0;0;False;0;False;0;20;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;79;593.687,1997.208;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;5;-1900.475,123.2581;Inherit;False;WaveLenght;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;4;-1900.475,47.25806;Inherit;False;Amplitude;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;81;937.9232,1900.687;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;51;-1925.369,1381.201;Inherit;False;4;Amplitude;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2;-1886.475,-111.7419;Inherit;False;Steepness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;40;-1813.192,1001.229;Inherit;False;5;WaveLenght;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-1771.369,1447.201;Inherit;False;5;WaveLenght;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;3;-1894.475,-31.74194;Inherit;False;NumOfWaves;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;7;-1909.475,276.2581;Inherit;False;Speed;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;39;-1653.998,608.9763;Inherit;False;Property;_Dir2;Dir2;21;0;Create;True;0;0;0;False;0;False;0,0,0;0.2346379,0,-0.9720827;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;53;-1836.455,1506.406;Inherit;False;Property;_Dir4;Dir4;37;0;Create;True;0;0;0;False;0;False;0,0,0;0.2660495,0,-0.9639595;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;-1593.608,1454.869;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;50;-1786.369,1645.201;Inherit;False;7;Speed;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;34;-1574.912,441.7714;Inherit;False;3;NumOfWaves;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;43;-1732.192,1203.229;Inherit;False;7;Speed;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;49;-1755.369,1276.201;Inherit;False;2;Steepness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;15;-1515.475,290.2581;Inherit;False;7;Speed;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;37;-1595.912,489.7715;Inherit;False;4;Amplitude;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;17;-1507.475,32.25806;Inherit;False;4;Amplitude;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;-1603.912,747.7715;Inherit;False;7;Speed;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-1701.192,834.229;Inherit;False;2;Steepness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;93;-1621.205,1008.219;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;48;-1757.369,1339.201;Inherit;False;3;NumOfWaves;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;46;-1782.278,1064.434;Inherit;False;Property;_Dir3;Dir3;35;0;Create;True;0;0;0;False;0;False;0,0,0;0.3195327,0,-0.9475753;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;30;-1040.009,-678.1677;Inherit;False;Property;_HeightOffset;HeightOffset;10;0;Create;True;0;0;0;False;0;False;0;0.94;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;85;1223.448,1932.519;Inherit;False;TextureNormals;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DepthFade;96;-288.3921,1198.178;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;9;-1565.561,151.4629;Inherit;False;Property;_Dir1;Dir1;14;0;Create;True;0;0;0;False;0;False;0,0,0;0.06286175,0,-0.9980226;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;35;-1572.912,378.7714;Inherit;False;2;Steepness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;100;-89.11029,1400.618;Inherit;False;Property;_OpacityDepthRange;OpacityDepthRange;25;0;Create;True;0;0;0;False;0;False;1;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;33;-1588.912,549.7715;Inherit;False;5;WaveLenght;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;44;-1724.192,945.2291;Inherit;False;4;Amplitude;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;27;-1065.749,-814.7704;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;41;-1703.192,897.229;Inherit;False;3;NumOfWaves;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;95;-1725.608,1380.869;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;19;-1484.475,-78.74194;Inherit;False;2;Steepness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;16;-1500.475,92.25806;Inherit;False;5;WaveLenght;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;18;-1486.475,-15.74194;Inherit;False;3;NumOfWaves;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;38;-1279.676,455.3636;Inherit;False;Inner Waves Function;-1;;8;7d7672e142756fd488f82876d9ed566a;0;6;36;FLOAT;0;False;37;FLOAT;0;False;28;FLOAT;0;False;25;FLOAT;0;False;26;FLOAT3;0,0,0;False;27;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;23;-1191.239,-2.149807;Inherit;False;Inner Waves Function;-1;;10;7d7672e142756fd488f82876d9ed566a;0;6;36;FLOAT;0;False;37;FLOAT;0;False;28;FLOAT;0;False;25;FLOAT;0;False;26;FLOAT3;0,0,0;False;27;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;101;108.8897,1429.618;Inherit;False;Property;_OpacityDepthFallOff;OpacityDepthFallOff;27;0;Create;True;0;0;0;False;0;False;1;0.61;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;45;-1407.956,910.8212;Inherit;False;Inner Waves Function;-1;;7;7d7672e142756fd488f82876d9ed566a;0;6;36;FLOAT;0;False;37;FLOAT;0;False;28;FLOAT;0;False;25;FLOAT;0;False;26;FLOAT3;0,0,0;False;27;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;98;76.88971,1304.618;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;111;86.66884,1192.84;Inherit;False;Property;_HeightDepthRange;HeightDepthRange;28;0;Create;True;0;0;0;False;0;False;1;2.91;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-821.0089,-669.1677;Inherit;False;Property;_HeightDiference;HeightDiference;11;0;Create;True;0;0;0;False;0;False;1;3.51;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;135;-1158.901,-415.0222;Inherit;False;85;TextureNormals;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;-854.7556,-760.8221;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;120;-910.7735,-573.0881;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode;52;-1462.133,1352.793;Inherit;False;Inner Waves Function;-1;;9;7d7672e142756fd488f82876d9ed566a;0;6;36;FLOAT;0;False;37;FLOAT;0;False;28;FLOAT;0;False;25;FLOAT;0;False;26;FLOAT3;0,0,0;False;27;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;54;-754.4561,543.7888;Inherit;False;4;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;132;-521.5172,-288.1516;Inherit;False;Property;_FresnelScale;FresnelScale;33;0;Create;True;0;0;0;False;0;False;0;8.39;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;31;-695.0089,-743.1676;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;122;-917.5047,-392.9827;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;133;-512.4172,-195.8516;Inherit;False;Property;_FresnelPower;FresnelPower;34;0;Create;True;0;0;0;False;0;False;0;9.35;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;109;275.9597,1042.797;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;112;318.0318,1193.664;Inherit;False;Property;_HeightDepthOffset;HeightDepthOffset;30;0;Create;True;0;0;0;False;0;False;1;2.77;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;99;253.8897,1312.618;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;121;-678.7738,-514.388;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;55;-613.2126,542.5483;Inherit;False;GerrstnerWaves;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;22;-873.794,-1156.057;Inherit;False;Property;_HighColor;HighColor;7;0;Create;True;0;0;0;False;0;False;0.2295745,0.4276968,0.6320754,0;0.1180135,0.2528928,0.490566,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;110;474.2502,1039.507;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;131;-222.5873,-403.0308;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;106;331.5653,1433.567;Inherit;False;Property;_OpacityMultiplier;OpacityMultiplier;29;0;Create;True;0;0;0;False;0;False;0;0.2529517;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;28;-529.6556,-736.7221;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ReflectOpNode;118;-525.3461,-481.4621;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;102;401.1143,1328.845;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;26;-879.6715,-984.821;Inherit;False;Property;_LowColor;LowColor;8;0;Create;True;0;0;0;False;0;False;0.4198113,0.7986241,1,0;0.5206479,0.8219841,0.9433962,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;107;666.0662,1323.538;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;113;664.0461,1057.767;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-574.3187,1001.843;Inherit;False;Property;_FakeNormalIntensity;FakeNormalIntensity;16;0;Create;True;0;0;0;False;0;False;0;0.2465822;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;67;-472.4794,891.8555;Inherit;False;55;GerrstnerWaves;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalVertexDataNode;63;-470.9076,745.4982;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;123;-271.0853,-637.5639;Inherit;True;Property;_TextureSample0;Texture Sample 0;32;0;Create;True;0;0;0;False;0;False;-1;None;4c1a38546107b094ca8d12e4f578a511;True;0;False;white;Auto;False;Object;-1;Auto;Cube;8;0;SAMPLERCUBE;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;134;58.1256,-464.0457;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;25;-350.7716,-797.121;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;130;285.8289,-673.4752;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;64;-181.8791,866.8161;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;108;811.0662,1326.538;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;115;846.235,1053.872;Inherit;False;HeightDepth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;68;204.8354,842.8875;Inherit;False;WavesNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;56;-138.502,122.7498;Inherit;False;55;GerrstnerWaves;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;116;-109.9715,225.193;Inherit;False;115;HeightDepth;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;103;954.9951,1299.209;Inherit;False;DepthOpacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;57;461.4854,-698.1555;Inherit;False;HeightColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;104;12.65698,76.40776;Inherit;False;103;DepthOpacity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;58;67.78632,-196.6567;Inherit;False;57;HeightColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;59;28.78419,3.674924;Inherit;False;Property;_Smoothness;Smoothness;15;0;Create;True;0;0;0;False;0;False;0;0.9470587;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;86;61.8135,-132.7123;Inherit;False;85;TextureNormals;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RefractOpVec;119;636.0261,-518.7772;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;70;56.62584,315.9458;Inherit;False;68;WavesNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;114;108.525,160.3372;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;117;4.46991,-64.77927;Inherit;False;Property;_Metallic;Metallic;31;0;Create;True;0;0;0;False;0;False;0;0.1122594;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;75;631.2291,2272.331;Inherit;True;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;375.6318,-174.6189;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Ocean;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;1;32;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;77;0;88;0
WireConnection;76;0;87;0
WireConnection;90;0;76;0
WireConnection;90;2;91;0
WireConnection;89;0;77;0
WireConnection;89;2;92;0
WireConnection;71;1;90;0
WireConnection;71;5;74;0
WireConnection;72;1;89;0
WireConnection;72;5;73;0
WireConnection;80;0;71;3
WireConnection;80;1;72;3
WireConnection;78;0;71;1
WireConnection;78;1;72;1
WireConnection;83;0;80;0
WireConnection;83;1;84;0
WireConnection;79;0;71;2
WireConnection;79;1;72;2
WireConnection;5;0;10;0
WireConnection;4;0;11;0
WireConnection;81;0;78;0
WireConnection;81;1;79;0
WireConnection;81;2;83;0
WireConnection;2;0;14;0
WireConnection;3;0;24;0
WireConnection;7;0;8;0
WireConnection;94;0;47;0
WireConnection;93;0;40;0
WireConnection;85;0;81;0
WireConnection;95;0;51;0
WireConnection;38;36;35;0
WireConnection;38;37;34;0
WireConnection;38;28;37;0
WireConnection;38;25;33;0
WireConnection;38;26;39;0
WireConnection;38;27;36;0
WireConnection;23;36;19;0
WireConnection;23;37;18;0
WireConnection;23;28;17;0
WireConnection;23;25;16;0
WireConnection;23;26;9;0
WireConnection;23;27;15;0
WireConnection;45;36;42;0
WireConnection;45;37;41;0
WireConnection;45;28;44;0
WireConnection;45;25;93;0
WireConnection;45;26;46;0
WireConnection;45;27;43;0
WireConnection;98;0;96;0
WireConnection;98;1;100;0
WireConnection;29;0;27;2
WireConnection;29;1;30;0
WireConnection;52;36;49;0
WireConnection;52;37;48;0
WireConnection;52;28;95;0
WireConnection;52;25;94;0
WireConnection;52;26;53;0
WireConnection;52;27;50;0
WireConnection;54;0;23;0
WireConnection;54;1;38;0
WireConnection;54;2;45;0
WireConnection;54;3;52;0
WireConnection;31;0;29;0
WireConnection;31;1;32;0
WireConnection;122;0;135;0
WireConnection;109;0;96;0
WireConnection;109;1;111;0
WireConnection;99;0;98;0
WireConnection;99;1;101;0
WireConnection;121;0;120;0
WireConnection;55;0;54;0
WireConnection;110;0;109;0
WireConnection;110;1;112;0
WireConnection;131;0;122;0
WireConnection;131;2;132;0
WireConnection;131;3;133;0
WireConnection;28;0;31;0
WireConnection;118;0;121;0
WireConnection;118;1;122;0
WireConnection;102;0;99;0
WireConnection;107;0;102;0
WireConnection;107;1;106;0
WireConnection;113;0;110;0
WireConnection;123;1;118;0
WireConnection;134;0;131;0
WireConnection;25;0;22;0
WireConnection;25;1;26;0
WireConnection;25;2;28;0
WireConnection;130;0;25;0
WireConnection;130;1;123;0
WireConnection;130;2;134;0
WireConnection;64;0;63;0
WireConnection;64;1;67;0
WireConnection;64;2;65;0
WireConnection;108;0;107;0
WireConnection;115;0;113;0
WireConnection;68;0;64;0
WireConnection;103;0;108;0
WireConnection;57;0;130;0
WireConnection;114;0;56;0
WireConnection;114;1;116;0
WireConnection;75;0;71;0
WireConnection;75;1;72;0
WireConnection;0;0;58;0
WireConnection;0;1;86;0
WireConnection;0;3;117;0
WireConnection;0;4;59;0
WireConnection;0;9;104;0
WireConnection;0;11;114;0
WireConnection;0;12;70;0
ASEEND*/
//CHKSM=CA4FD484E38813324FAB7A058BDD3EF4370FEB91