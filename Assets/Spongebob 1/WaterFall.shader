// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "WaterFall"
{
	Properties
	{
		_MainTex("Main Tex", 2D) = "white" {}
		_Speed("Speed", Vector) = (0.1,0.1,0,0)
		_FlowMap("FlowMap", 2D) = "white" {}
		_Tiling("Tiling", Float) = 1
		_FlorIntencity("FlorIntencity", Range( 0 , 1)) = 0.93
		_FlowSpeed("FlowSpeed", Float) = 0.1
		_Range("Range", Float) = 13
		_FallOff("FallOff", Float) = 4
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
			float4 screenPos;
		};

		uniform sampler2D _MainTex;
		uniform float2 _Speed;
		uniform float _Tiling;
		uniform sampler2D _FlowMap;
		uniform float _FlowSpeed;
		uniform float _FlorIntencity;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _Range;
		uniform float _FallOff;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color20 = IsGammaSpace() ? float4(0.03364186,0.2523902,0.2641509,0) : float4(0.002603859,0.05183823,0.05672633,0);
			float4 color16 = IsGammaSpace() ? float4(0.0518868,0.9506194,1,0) : float4(0.004107825,0.8913226,1,0);
			float2 temp_cast_0 = (_Tiling).xx;
			float2 uv_TexCoord6 = i.uv_texcoord * temp_cast_0;
			float2 temp_cast_2 = (_FlowSpeed).xx;
			float2 panner3 = ( 1.0 * _Time.y * temp_cast_2 + i.uv_texcoord);
			float4 tex2DNode5 = tex2D( _FlowMap, panner3 );
			float4 lerpResult9 = lerp( float4( uv_TexCoord6, 0.0 , 0.0 ) , tex2DNode5 , _FlorIntencity);
			float4 FlowMapMovement27 = lerpResult9;
			float2 panner14 = ( 1.0 * _Time.y * _Speed + FlowMapMovement27.rg);
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth10 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth10 = abs( ( screenDepth10 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 1.0 ) );
			float DepthFade26 = saturate( pow( ( distanceDepth10 / _Range ) , _FallOff ) );
			float4 lerpResult21 = lerp( color20 , ( color16 * tex2D( _MainTex, panner14 ) ) , DepthFade26);
			o.Emission = lerpResult21.rgb;
			float temp_output_25_0 = DepthFade26;
			o.Alpha = temp_output_25_0;
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
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float4 screenPos : TEXCOORD3;
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
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
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
0;651;1467;343;3016.248;417.9537;2.333691;True;False
Node;AmplifyShaderEditor.CommentaryNode;29;-1668.832,-771.8237;Inherit;False;1603.719;681.075;Flowmap;10;1;2;3;4;6;5;7;9;22;27;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-1558.006,-580.0264;Inherit;False;Property;_FlowSpeed;FlowSpeed;6;0;Create;True;0;0;0;False;0;False;0.1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1618.832,-721.8237;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-1421.34,-424.0718;Inherit;False;Property;_Tiling;Tiling;4;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;3;-1302.855,-632.6892;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;24;-1438.526,627.976;Inherit;False;1297.799;303.9602;DepthFade;8;23;26;19;15;13;12;10;11;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-950.4874,-205.9088;Inherit;False;Property;_FlorIntencity;FlorIntencity;5;0;Create;True;0;0;0;False;0;False;0.93;0.93;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-1111.694,-658.5383;Inherit;True;Property;_FlowMap;FlowMap;3;0;Create;True;0;0;0;False;0;False;-1;0651b05cd95b364469d1e4ce27059045;b92e5f138ffc68b449e717d9c16e0c99;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-1201.725,-428.6693;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DepthFade;10;-1199.526,677.976;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1002.526,780.9763;Inherit;False;Property;_Range;Range;8;0;Create;True;0;0;0;False;0;False;13;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;9;-603.4865,-349.8087;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;30;-1536.622,-31.38279;Inherit;False;1456.577;613.0063;Color;9;28;8;14;16;17;18;20;25;21;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;27;-316.8332,-340.4091;Float;False;FlowMapMovement;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-801.527,819.9763;Inherit;False;Property;_FallOff;FallOff;9;0;Create;True;0;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;13;-839.527,678.976;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;15;-659.5267,709.976;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;28;-1473.677,194.4597;Inherit;False;27;FlowMapMovement;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;8;-1486.622,420.1437;Inherit;False;Property;_Speed;Speed;2;0;Create;True;0;0;0;False;0;False;0.1,0.1;0.1,0.1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SaturateNode;19;-491.5974,717.913;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;14;-1262.022,299.3434;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;26;-339.8513,746.8599;Float;False;DepthFade;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;16;-978.9805,104.1927;Inherit;False;Constant;_Color1;Color 1;9;0;Create;True;0;0;0;False;0;False;0.0518868,0.9506194,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;17;-1035.023,287.1435;Inherit;True;Property;_MainTex;Main Tex;1;0;Create;True;0;0;0;False;0;False;-1;c1ca1809e4a98254b8610a2fdb30e7bc;c1ca1809e4a98254b8610a2fdb30e7bc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;25;-437.6356,282.3652;Inherit;False;26;DepthFade;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-738.804,165.9236;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;20;-552.6051,18.61723;Inherit;False;Constant;_Color0;Color 0;9;0;Create;True;0;0;0;False;0;False;0.03364186,0.2523902,0.2641509,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;23;-1388.526,708.976;Inherit;False;Property;_Distance;Distance;7;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;21;-262.6557,161.0611;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;22;-654.5715,-574.5286;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT2;0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,-1.361032;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;WaterFall;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Transparent;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;1;0
WireConnection;3;2;2;0
WireConnection;5;1;3;0
WireConnection;6;0;4;0
WireConnection;9;0;6;0
WireConnection;9;1;5;0
WireConnection;9;2;7;0
WireConnection;27;0;9;0
WireConnection;13;0;10;0
WireConnection;13;1;11;0
WireConnection;15;0;13;0
WireConnection;15;1;12;0
WireConnection;19;0;15;0
WireConnection;14;0;28;0
WireConnection;14;2;8;0
WireConnection;26;0;19;0
WireConnection;17;1;14;0
WireConnection;18;0;16;0
WireConnection;18;1;17;0
WireConnection;21;0;20;0
WireConnection;21;1;18;0
WireConnection;21;2;25;0
WireConnection;22;0;5;0
WireConnection;22;1;6;0
WireConnection;0;2;21;0
WireConnection;0;9;25;0
ASEEND*/
//CHKSM=795008BAFBC11F06D7DC474C0BBF8F5A9DF8977E