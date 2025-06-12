// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "StencilCrack"
{
	Properties
	{
		_LavaTex("LavaTex", 2D) = "white" {}
		_Tilling("Tilling", Float) = 0
		_RockTex("RockTex", 2D) = "white" {}
		_PseudoAngulo("PseudoAngulo", Float) = 0
		[HDR]_Color0("Color 0", Color) = (4,0.3281592,0,0)
		_LavaSpeed("LavaSpeed", Vector) = (0,0,0,0)
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_LavaFlowIntensity("LavaFlowIntensity", Range( 0 , 0.1)) = 0
		_LightHeight("LightHeight", Float) = 0
		_LightFallOff("LightFallOff", Float) = 0
		[HDR]_LavaLightColor("LavaLightColor", Color) = (0.007721385,0.004268436,0,0)
		_LightHeightVar("LightHeightVar", Float) = 0.5
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
			Ref 1
			Comp Equal
			Pass Keep
			Fail Keep
			ZFail Keep
		}
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

		uniform float _LightHeight;
		uniform float _LightHeightVar;
		uniform float _LightFallOff;
		uniform float4 _LavaLightColor;
		uniform sampler2D _RockTex;
		uniform float _PseudoAngulo;
		uniform float4 _Color0;
		uniform sampler2D _LavaTex;
		uniform float2 _LavaSpeed;
		uniform float _Tilling;
		uniform sampler2D _TextureSample0;
		uniform float _LavaFlowIntensity;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 LavaLight29 = ( saturate( ( 1.0 - ( ( ase_vertex3Pos.z + _LightHeight + ( _SinTime.w * _LightHeightVar ) ) * _LightFallOff ) ) ) * _LavaLightColor );
			float2 appendResult17 = (float2(( ( _PseudoAngulo * ase_vertex3Pos.x ) + ase_vertex3Pos.y ) , ase_vertex3Pos.z));
			float4 RockTex14 = tex2D( _RockTex, appendResult17 );
			float3 ase_worldPos = i.worldPos;
			float2 appendResult9 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 temp_output_11_0 = ( appendResult9 * _Tilling );
			float2 panner24 = ( 1.0 * _Time.y * _LavaSpeed + temp_output_11_0);
			float4 lerpResult27 = lerp( float4( panner24, 0.0 , 0.0 ) , tex2D( _TextureSample0, temp_output_11_0 ) , _LavaFlowIntensity);
			float4 LavaTex7 = tex2D( _LavaTex, lerpResult27.rg );
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float4 lerpResult5 = lerp( ( LavaLight29 + RockTex14 ) , ( _Color0 * LavaTex7 ) , saturate( ase_vertexNormal.z ));
			o.Emission = lerpResult5.rgb;
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
0;548;1469;451;3993.565;759.1691;3.317756;True;False
Node;AmplifyShaderEditor.RangedFloatNode;42;-2399.134,572.2055;Inherit;False;Property;_LightHeightVar;LightHeightVar;11;0;Create;True;0;0;0;False;0;False;0.5;0.03;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinTimeNode;40;-2462.134,375.2055;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-2193.134,452.2055;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;10;-2510.126,-337.6544;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;32;-2267.757,329.8339;Inherit;False;Property;_LightHeight;LightHeight;8;0;Create;True;0;0;0;False;0;False;0;0.83;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;16;-2403.628,109.9934;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;20;-2402.003,20.29959;Inherit;False;Property;_PseudoAngulo;PseudoAngulo;3;0;Create;True;0;0;0;False;0;False;0;0.41;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-1951.537,513.9031;Inherit;False;Property;_LightFallOff;LightFallOff;9;0;Create;True;0;0;0;False;0;False;0;1.7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-2278.126,-194.6543;Inherit;False;Property;_Tilling;Tilling;1;0;Create;True;0;0;0;False;0;False;0;0.82;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;9;-2301.126,-300.6544;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;31;-1982.48,328.9054;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-2117.125,-287.6544;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-2184.003,114.2996;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-1847.537,343.9031;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;25;-2359.211,-107.7257;Inherit;False;Property;_LavaSpeed;LavaSpeed;5;0;Create;True;0;0;0;False;0;False;0,0;-0.02,0.07;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.OneMinusNode;34;-1712.954,367.6187;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;18;-1977.003,146.2996;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;24;-1963.852,-286.1913;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-1971.978,-140.2392;Inherit;False;Property;_LavaFlowIntensity;LavaFlowIntensity;7;0;Create;True;0;0;0;False;0;False;0;0.07367016;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;26;-1977.808,-489.728;Inherit;True;Property;_TextureSample0;Texture Sample 0;6;0;Create;True;0;0;0;False;0;False;-1;None;ee7becf5d8cd2ff4dba336335564345f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;38;-1601.735,474.25;Inherit;False;Property;_LavaLightColor;LavaLightColor;10;1;[HDR];Create;True;0;0;0;False;0;False;0.007721385,0.004268436,0,0;1.003922,0.2667988,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;17;-1819.003,176.2996;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;27;-1641.763,-282.8279;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;33;-1532.928,394.1015;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;13;-1661.063,133.6005;Inherit;True;Property;_RockTex;RockTex;2;0;Create;True;0;0;0;False;0;False;-1;None;688da5f4a0f6d5d4bb33cef25c41beed;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1436.109,-294.0013;Inherit;True;Property;_LavaTex;LavaTex;0;0;Create;True;0;0;0;False;0;False;-1;None;4020ff76a8f89d74d97cb87949e7df7e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-1339.774,409.4214;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;7;-1107.773,-322.2218;Inherit;False;LavaTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-1232.085,151.7041;Inherit;False;RockTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;29;-1182.025,383.7738;Inherit;False;LavaLight;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalVertexDataNode;3;-966.5832,174.1464;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;30;-846.6571,-191.5245;Inherit;False;29;LavaLight;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;6;-786.4559,142.818;Inherit;False;7;LavaTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;23;-882.3208,-27.73547;Inherit;False;Property;_Color0;Color 0;4;1;[HDR];Create;True;0;0;0;False;0;False;4,0.3281592,0,0;13.73576,6.955012,0.7127049,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;15;-848.5906,-104.1544;Inherit;False;14;RockTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;4;-786.6575,248.1353;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-537.6462,81.04078;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;39;-549.1093,-104.0326;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;5;-380.0381,53.55987;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;StencilCrack;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;2;False;-1;7;False;-1;False;71.4;False;-1;-7.23;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;True;1;False;-1;255;False;-1;255;False;-1;5;False;-1;1;False;-1;1;False;-1;1;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;41;0;40;4
WireConnection;41;1;42;0
WireConnection;9;0;10;1
WireConnection;9;1;10;3
WireConnection;31;0;16;3
WireConnection;31;1;32;0
WireConnection;31;2;41;0
WireConnection;11;0;9;0
WireConnection;11;1;12;0
WireConnection;19;0;20;0
WireConnection;19;1;16;1
WireConnection;35;0;31;0
WireConnection;35;1;36;0
WireConnection;34;0;35;0
WireConnection;18;0;19;0
WireConnection;18;1;16;2
WireConnection;24;0;11;0
WireConnection;24;2;25;0
WireConnection;26;1;11;0
WireConnection;17;0;18;0
WireConnection;17;1;16;3
WireConnection;27;0;24;0
WireConnection;27;1;26;0
WireConnection;27;2;28;0
WireConnection;33;0;34;0
WireConnection;13;1;17;0
WireConnection;1;1;27;0
WireConnection;37;0;33;0
WireConnection;37;1;38;0
WireConnection;7;0;1;0
WireConnection;14;0;13;0
WireConnection;29;0;37;0
WireConnection;4;0;3;3
WireConnection;21;0;23;0
WireConnection;21;1;6;0
WireConnection;39;0;30;0
WireConnection;39;1;15;0
WireConnection;5;0;39;0
WireConnection;5;1;21;0
WireConnection;5;2;4;0
WireConnection;0;2;5;0
ASEEND*/
//CHKSM=6EC8FEEF70A14319372BD80E8963025B2C4A84C9