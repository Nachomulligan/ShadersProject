// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/PP_SobelEdgeDetect"
{
	Properties
	{
		_Intensity("Intensity", Float) = 1
		_SaturationIntensity("Saturation Intensity", Float) = 1
		_Step("Step", Float) = 1
		_SobelTint("Sobel Tint", Color) = (0,0,0,0)

	}

	SubShader
	{
		LOD 0

		Cull Off
		ZWrite Off
		ZTest Always
		
		Pass
		{
			CGPROGRAM

			

			#pragma vertex Vert
			#pragma fragment Frag
			#pragma target 3.0

			#include "UnityCG.cginc"
			#define ASE_NEEDS_FRAG_SCREEN_POSITION_NORMALIZED

		
			struct ASEAttributesDefault
			{
				float3 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
				
			};

			struct ASEVaryingsDefault
			{
				float4 vertex : SV_POSITION;
				float2 texcoord : TEXCOORD0;
				float2 texcoordStereo : TEXCOORD1;
			#if STEREO_INSTANCING_ENABLED
				uint stereoTargetEyeIndex : SV_RenderTargetArrayIndex;
			#endif
				
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			uniform float _Step;
			uniform float _SaturationIntensity;
			uniform float _Intensity;
			uniform float4 _SobelTint;
			UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
			uniform float4 _CameraDepthTexture_TexelSize;


			
			float2 TransformTriangleVertexToUV (float2 vertex)
			{
				float2 uv = (vertex + 1.0) * 0.5;
				return uv;
			}

			ASEVaryingsDefault Vert( ASEAttributesDefault v  )
			{
				ASEVaryingsDefault o;
				o.vertex = float4(v.vertex.xy, 0.0, 1.0);
				o.texcoord = TransformTriangleVertexToUV (v.vertex.xy);
#if UNITY_UV_STARTS_AT_TOP
				o.texcoord = o.texcoord * float2(1.0, -1.0) + float2(0.0, 1.0);
#endif
				o.texcoordStereo = TransformStereoScreenSpaceTex (o.texcoord, 1.0);

				v.texcoord = o.texcoordStereo;
				float4 ase_ppsScreenPosVertexNorm = float4(o.texcoordStereo,0,1);

				

				return o;
			}

			float4 Frag (ASEVaryingsDefault i  ) : SV_Target
			{
				float4 ase_ppsScreenPosFragNorm = float4(i.texcoordStereo,0,1);

				float2 uv_MainTex = i.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 Centre5_g30 = uv_MainTex;
				float4 break9 = ( _MainTex_TexelSize * _Step );
				float temp_output_3_0_g30 = break9.x;
				float StepXNeg10_g30 = -temp_output_3_0_g30;
				float temp_output_4_0_g30 = break9.y;
				float StepY12_g30 = temp_output_4_0_g30;
				float2 appendResult8_g37 = (float2(StepXNeg10_g30 , StepY12_g30));
				float4 break19_g37 = ( saturate( tex2D( _MainTex, ( Centre5_g30 + appendResult8_g37 ) ) ) * _SaturationIntensity );
				float TopLeft72_g30 = ( sqrt( ( ( break19_g37.r * break19_g37.r ) + ( break19_g37.g * break19_g37.g ) + ( break19_g37.b * break19_g37.b ) ) ) * _Intensity );
				float2 appendResult8_g38 = (float2(StepXNeg10_g30 , 0.0));
				float4 break19_g38 = ( saturate( tex2D( _MainTex, ( Centre5_g30 + appendResult8_g38 ) ) ) * _SaturationIntensity );
				float Left73_g30 = ( sqrt( ( ( break19_g38.r * break19_g38.r ) + ( break19_g38.g * break19_g38.g ) + ( break19_g38.b * break19_g38.b ) ) ) * _Intensity );
				float StepYNeg13_g30 = -temp_output_4_0_g30;
				float2 appendResult8_g36 = (float2(StepXNeg10_g30 , StepYNeg13_g30));
				float4 break19_g36 = ( saturate( tex2D( _MainTex, ( Centre5_g30 + appendResult8_g36 ) ) ) * _SaturationIntensity );
				float BottomLeft74_g30 = ( sqrt( ( ( break19_g36.r * break19_g36.r ) + ( break19_g36.g * break19_g36.g ) + ( break19_g36.b * break19_g36.b ) ) ) * _Intensity );
				float StepX8_g30 = temp_output_3_0_g30;
				float2 appendResult8_g35 = (float2(StepX8_g30 , StepYNeg13_g30));
				float4 break19_g35 = ( saturate( tex2D( _MainTex, ( Centre5_g30 + appendResult8_g35 ) ) ) * _SaturationIntensity );
				float BottomRight76_g30 = ( sqrt( ( ( break19_g35.r * break19_g35.r ) + ( break19_g35.g * break19_g35.g ) + ( break19_g35.b * break19_g35.b ) ) ) * _Intensity );
				float2 appendResult8_g40 = (float2(StepX8_g30 , 0.0));
				float4 break19_g40 = ( saturate( tex2D( _MainTex, ( Centre5_g30 + appendResult8_g40 ) ) ) * _SaturationIntensity );
				float Right77_g30 = ( sqrt( ( ( break19_g40.r * break19_g40.r ) + ( break19_g40.g * break19_g40.g ) + ( break19_g40.b * break19_g40.b ) ) ) * _Intensity );
				float2 appendResult8_g41 = (float2(StepX8_g30 , StepY12_g30));
				float4 break19_g41 = ( saturate( tex2D( _MainTex, ( Centre5_g30 + appendResult8_g41 ) ) ) * _SaturationIntensity );
				float TopRight78_g30 = ( sqrt( ( ( break19_g41.r * break19_g41.r ) + ( break19_g41.g * break19_g41.g ) + ( break19_g41.b * break19_g41.b ) ) ) * _Intensity );
				float temp_output_90_0_g30 = ( ( TopLeft72_g30 + ( Left73_g30 * 2 ) + BottomLeft74_g30 + -BottomRight76_g30 + ( Right77_g30 * -2 ) + -TopRight78_g30 ) / 6.0 );
				float2 appendResult8_g42 = (float2(0.0 , StepY12_g30));
				float4 break19_g42 = ( saturate( tex2D( _MainTex, ( Centre5_g30 + appendResult8_g42 ) ) ) * _SaturationIntensity );
				float Top71_g30 = ( sqrt( ( ( break19_g42.r * break19_g42.r ) + ( break19_g42.g * break19_g42.g ) + ( break19_g42.b * break19_g42.b ) ) ) * _Intensity );
				float2 appendResult8_g39 = (float2(0.0 , StepYNeg13_g30));
				float4 break19_g39 = ( saturate( tex2D( _MainTex, ( Centre5_g30 + appendResult8_g39 ) ) ) * _SaturationIntensity );
				float Bottom75_g30 = ( sqrt( ( ( break19_g39.r * break19_g39.r ) + ( break19_g39.g * break19_g39.g ) + ( break19_g39.b * break19_g39.b ) ) ) * _Intensity );
				float temp_output_105_0_g30 = ( ( -TopLeft72_g30 + ( Top71_g30 * -2 ) + BottomLeft74_g30 + ( Bottom75_g30 * 2 ) + -TopRight78_g30 + BottomRight76_g30 ) / 6.0 );
				float temp_output_24_0 = sqrt( ( ( temp_output_90_0_g30 * temp_output_90_0_g30 ) + ( temp_output_105_0_g30 * temp_output_105_0_g30 ) ) );
				float clampDepth18 = Linear01Depth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_ppsScreenPosFragNorm.xy ));
				float lerpResult23 = lerp( temp_output_24_0 , 0.0 , saturate( clampDepth18 ));
				float4 lerpResult13 = lerp( tex2D( _MainTex, uv_MainTex ) , ( temp_output_24_0 * _SobelTint ) , lerpResult23);
				

				float4 color = lerpResult13;
				
				return color;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
0;570;1466;416;2561.317;425.7903;2.58351;True;False
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;5;-1626.884,-263.1681;Inherit;False;0;0;_MainTex_TexelSize;Pass;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;7;-1580.227,-83.02633;Float;False;Property;_Step;Step;25;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;20;-222.8168,289.6749;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-1307.827,-211.6263;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;2;-1542.291,222.466;Inherit;False;0;0;_MainTex;Shader;False;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenDepthNode;18;-17.53755,292.101;Inherit;False;1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1098.31,411.8663;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;9;-1103.337,-169.8376;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SaturateNode;22;222.6895,241.4185;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;24;-707.7664,-117.6822;Inherit;False;SobelKernelConvolutions;0;;30;f4afe80a4a01ec9448a529eb23b693d9;0;4;1;FLOAT2;0,0;False;2;SAMPLER2D;0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;11;-631.4595,51.68233;Float;False;Property;_SobelTint;Sobel Tint;26;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-384.2657,-11.06258;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;3;-717.4421,308.8094;Inherit;True;Property;_TextureSample1;Texture Sample 1;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;23;227.4513,-51.17186;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;13;480.787,12.8933;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;25;799.7529,76.16859;Float;False;True;-1;2;ASEMaterialInspector;0;14;Hidden/PP_SobelEdgeDetect;32139be9c1eb75640a847f011acf3bcf;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;True;7;False;-1;False;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;6;0;5;0
WireConnection;6;1;7;0
WireConnection;18;0;20;0
WireConnection;4;2;2;0
WireConnection;9;0;6;0
WireConnection;22;0;18;0
WireConnection;24;1;4;0
WireConnection;24;2;2;0
WireConnection;24;3;9;0
WireConnection;24;4;9;1
WireConnection;10;0;24;0
WireConnection;10;1;11;0
WireConnection;3;0;2;0
WireConnection;3;1;4;0
WireConnection;23;0;24;0
WireConnection;23;2;22;0
WireConnection;13;0;3;0
WireConnection;13;1;10;0
WireConnection;13;2;23;0
WireConnection;25;0;13;0
ASEEND*/
//CHKSM=6F3D2E4CF1D048DEFDD86750BFB181BF9E98D70B