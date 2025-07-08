// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Crack"
{
	Properties
	{
		_ParedesTex("ParedesTex", 2D) = "white" {}
		_LavaTex("LavaTex", 2D) = "white" {}
		_ParedesNormal("ParedesNormal", 2D) = "bump" {}
		_ParedesNormalScale("ParedesNormalScale", Range( 0 , 2)) = 0
		_ParedesIluminationColor("ParedesIluminationColor", Color) = (0,0,0,0)
		_IluminationHeight("IluminationHeight", Float) = 0
		_IluminationScale("IluminationScale", Float) = 0
		_IluminationFallOff("IluminationFallOff", Float) = 1
		_LavaSpeed("LavaSpeed", Vector) = (0,0,0,0)
		_LavaFlowmap("LavaFlowmap", 2D) = "white" {}
		_LavaDistortionIntensity("LavaDistortionIntensity", Range( 0 , 0.1)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		ZTest Always
		Stencil
		{
			Ref 2
			Comp Equal
			Pass Keep
			Fail Keep
			ZFail Keep
		}
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
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
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform sampler2D _ParedesNormal;
		uniform float _ParedesNormalScale;
		uniform sampler2D _LavaTex;
		uniform float2 _LavaSpeed;
		uniform sampler2D _LavaFlowmap;
		uniform float _LavaDistortionIntensity;
		uniform sampler2D _ParedesTex;
		uniform float4 _ParedesIluminationColor;
		uniform float _IluminationHeight;
		uniform float _IluminationScale;
		uniform float _IluminationFallOff;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float2 appendResult11 = (float2(ase_vertex3Pos.y , ase_vertex3Pos.z));
			float2 ParedesCoord30 = appendResult11;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float NormalMask21 = step( ase_vertexNormal.z , 0.5 );
			float3 lerpResult37 = lerp( float3( 0,0,0 ) , UnpackScaleNormal( tex2D( _ParedesNormal, ParedesCoord30 ), _ParedesNormalScale ) , NormalMask21);
			float3 Normal39 = lerpResult37;
			o.Normal = Normal39;
			float3 ase_worldPos = i.worldPos;
			float2 appendResult8 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 panner58 = ( 1.0 * _Time.y * _LavaSpeed + appendResult8);
			float4 lerpResult60 = lerp( float4( panner58, 0.0 , 0.0 ) , tex2D( _LavaFlowmap, appendResult8 ) , _LavaDistortionIntensity);
			float4 LavaCoord31 = lerpResult60;
			float4 tex2DNode14 = tex2D( _LavaTex, LavaCoord31.rg );
			float4 lerpResult15 = lerp( tex2DNode14 , tex2D( _ParedesTex, ParedesCoord30 ) , NormalMask21);
			float4 Albedo27 = lerpResult15;
			o.Albedo = Albedo27.rgb;
			float IluminationMask50 = saturate( pow( ( saturate( ( 1.0 - ( ase_vertex3Pos.z + _IluminationHeight + ( _SinTime.w * 0.1 ) ) ) ) * _IluminationScale ) , _IluminationFallOff ) );
			float4 lerpResult22 = lerp( tex2DNode14 , ( _ParedesIluminationColor * IluminationMask50 ) , NormalMask21);
			float4 Emission28 = lerpResult22;
			o.Emission = Emission28.rgb;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

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
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float4 tSpace0 : TEXCOORD1;
				float4 tSpace1 : TEXCOORD2;
				float4 tSpace2 : TEXCOORD3;
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
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
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
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
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
0;798;1468;196;3390.019;54.99471;1;True;False
Node;AmplifyShaderEditor.SinTimeNode;64;-2854.062,1018.087;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;44;-2812.784,703.9519;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-2691.062,999.0867;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-3035.481,914.1431;Inherit;False;Property;_IluminationHeight;IluminationHeight;5;0;Create;True;0;0;0;False;0;False;0;1.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;46;-2620.481,859.1433;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;48;-2494.58,878.9649;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;57;-2347.521,890.8889;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;66;-2938.019,-103.9947;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;55;-2438.287,997.9711;Inherit;False;Property;_IluminationScale;IluminationScale;6;0;Create;True;0;0;0;False;0;False;0;1.78;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;59;-2608.736,104.2807;Inherit;False;Property;_LavaSpeed;LavaSpeed;8;0;Create;True;0;0;0;False;0;False;0,0;0.05,-0.1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;56;-2122.139,1016.328;Inherit;False;Property;_IluminationFallOff;IluminationFallOff;7;0;Create;True;0;0;0;False;0;False;1;2.54;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;8;-2582.188,-77.71384;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;-2193.527,916.3847;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;54;-2023.215,913.325;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;61;-2370.704,87.20905;Inherit;True;Property;_LavaFlowmap;LavaFlowmap;9;0;Create;True;0;0;0;False;0;False;-1;None;ac7820fe27c3f354cbd795b62b9668c0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;58;-2312.291,-28.08636;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-2371.604,405.5091;Inherit;False;Property;_LavaDistortionIntensity;LavaDistortionIntensity;10;0;Create;True;0;0;0;False;0;False;0;0.04997099;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;3;-2910.841,-267.9855;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;49;-1847.479,893.0839;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;16;-1059.849,571.4658;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;60;-2017.604,-33.49092;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;11;-2540.756,-234.1206;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;30;-2377.987,-233.2614;Inherit;False;ParedesCoord;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StepOpNode;18;-738.4409,571.4497;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;31;-1808.06,-27.53383;Inherit;False;LavaCoord;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;50;-1663.094,890.1673;Inherit;False;IluminationMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;-1556.194,-34.01442;Inherit;False;31;LavaCoord;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-1707.166,414.4807;Inherit;False;Property;_ParedesNormalScale;ParedesNormalScale;3;0;Create;True;0;0;0;False;0;False;0;1.105882;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;33;-1502.496,-495.9821;Inherit;False;30;ParedesCoord;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;29;-1662.88,337.9124;Inherit;False;30;ParedesCoord;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;21;-584.6826,531.2621;Inherit;False;NormalMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;43;-1247.878,17.27382;Inherit;False;Property;_ParedesIluminationColor;ParedesIluminationColor;4;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.6981132,0.1654424,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;52;-1185.356,176.2735;Inherit;False;50;IluminationMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;20;-984.3245,-352.1431;Inherit;False;21;NormalMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;14;-1317.15,-161.6237;Inherit;True;Property;_LavaTex;LavaTex;1;0;Create;True;0;0;0;False;0;False;-1;None;4020ff76a8f89d74d97cb87949e7df7e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1312.47,-528.825;Inherit;True;Property;_ParedesTex;ParedesTex;0;0;Create;True;0;0;0;False;0;False;-1;None;688da5f4a0f6d5d4bb33cef25c41beed;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;38;-1052.552,395.4289;Inherit;False;21;NormalMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;36;-1378.552,234.4289;Inherit;True;Property;_ParedesNormal;ParedesNormal;2;0;Create;True;0;0;0;False;0;False;-1;None;8863a610d4048664dba4babace5a9800;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-880.3564,-3.726532;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-917.5234,111.9662;Inherit;False;21;NormalMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;15;-800.7148,-431.0456;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;22;-633.753,-41.02736;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;37;-786.5515,212.4289;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;27;-547.8711,-421.8732;Inherit;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;39;-582.1663,223.4807;Inherit;False;Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;28;-458.5922,-63.35547;Inherit;False;Emission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;35;579.4657,-15.02582;Inherit;False;28;Emission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;40;572.333,-88.68741;Inherit;False;39;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;34;604.4657,-167.0258;Inherit;False;27;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;901.9929,-192.229;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Crack;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;2;False;-1;7;False;-1;False;0;False;-1;-1.25;False;-1;False;2;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;True;2;False;-1;255;False;-1;255;False;-1;5;False;-1;1;False;-1;1;False;-1;1;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;65;0;64;4
WireConnection;46;0;44;3
WireConnection;46;1;47;0
WireConnection;46;2;65;0
WireConnection;48;0;46;0
WireConnection;57;0;48;0
WireConnection;8;0;66;1
WireConnection;8;1;66;3
WireConnection;53;0;57;0
WireConnection;53;1;55;0
WireConnection;54;0;53;0
WireConnection;54;1;56;0
WireConnection;61;1;8;0
WireConnection;58;0;8;0
WireConnection;58;2;59;0
WireConnection;49;0;54;0
WireConnection;60;0;58;0
WireConnection;60;1;61;0
WireConnection;60;2;62;0
WireConnection;11;0;3;2
WireConnection;11;1;3;3
WireConnection;30;0;11;0
WireConnection;18;0;16;3
WireConnection;31;0;60;0
WireConnection;50;0;49;0
WireConnection;21;0;18;0
WireConnection;14;1;32;0
WireConnection;1;1;33;0
WireConnection;36;1;29;0
WireConnection;36;5;41;0
WireConnection;51;0;43;0
WireConnection;51;1;52;0
WireConnection;15;0;14;0
WireConnection;15;1;1;0
WireConnection;15;2;20;0
WireConnection;22;0;14;0
WireConnection;22;1;51;0
WireConnection;22;2;42;0
WireConnection;37;1;36;0
WireConnection;37;2;38;0
WireConnection;27;0;15;0
WireConnection;39;0;37;0
WireConnection;28;0;22;0
WireConnection;0;0;34;0
WireConnection;0;1;40;0
WireConnection;0;2;35;0
ASEEND*/
//CHKSM=6C17963A07337EEABB587DDC8F4A105FB8356E5D