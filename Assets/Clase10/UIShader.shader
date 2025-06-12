// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "UIShader"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255

		_ColorMask ("Color Mask", Float) = 15

		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
		_Offset("Offset", Range( 0 , 1000)) = 0

	}

	SubShader
	{
		LOD 0

		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="True" }
		
		Stencil
		{
			Ref [_Stencil]
			ReadMask [_StencilReadMask]
			WriteMask [_StencilWriteMask]
			CompFront [_StencilComp]
			PassFront [_StencilOp]
			FailFront Keep
			ZFailFront Keep
			CompBack Always
			PassBack Keep
			FailBack Keep
			ZFailBack Keep
		}


		Cull Off
		Lighting Off
		ZWrite Off
		ZTest [unity_GUIZTestMode]
		Blend SrcAlpha OneMinusSrcAlpha
		ColorMask [_ColorMask]

		
		Pass
		{
			Name "Default"
		CGPROGRAM
			
			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0

			#include "UnityCG.cginc"
			#include "UnityUI.cginc"

			#pragma multi_compile __ UNITY_UI_CLIP_RECT
			#pragma multi_compile __ UNITY_UI_ALPHACLIP
			
			
			
			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				half2 texcoord  : TEXCOORD0;
				float4 worldPosition : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				
			};
			
			uniform fixed4 _Color;
			uniform fixed4 _TextureSampleAdd;
			uniform float4 _ClipRect;
			uniform sampler2D _MainTex;
			uniform float _Offset;

			
			v2f vert( appdata_t IN  )
			{
				v2f OUT;
				UNITY_SETUP_INSTANCE_ID( IN );
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
				UNITY_TRANSFER_INSTANCE_ID(IN, OUT);
				OUT.worldPosition = IN.vertex;
				
				
				OUT.worldPosition.xyz += float3( ( _Offset * ( IN.texcoord.xy - float2( 0.5,0.5 ) ) ) ,  0.0 );
				OUT.vertex = UnityObjectToClipPos(OUT.worldPosition);

				OUT.texcoord = IN.texcoord;
				
				OUT.color = IN.color * _Color;
				return OUT;
			}

			fixed4 frag(v2f IN  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				
				half4 color = (tex2D(_MainTex, IN.texcoord) + _TextureSampleAdd) * IN.color;
				
				#ifdef UNITY_UI_CLIP_RECT
                color.a *= UnityGet2DClipping(IN.worldPosition.xy, _ClipRect);
                #endif
				
				#ifdef UNITY_UI_ALPHACLIP
				clip (color.a - 0.001);
				#endif

				return color;
			}
		ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
0;532;1466;454;-4131.555;-196.8547;1.1926;True;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;76;5031.367,233.8026;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;87;5250.208,247.6241;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;24;372.3422,787.0652;Inherit;False;1454.606;518.7987;Flow casero;6;21;18;20;22;19;23;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;82;5315.334,417.1933;Inherit;False;Property;_Offset;Offset;26;0;Create;True;0;0;0;False;0;False;0;1;0;1000;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;75;2013.945,804.383;Inherit;False;2858.75;1199.892;RotateCasero;17;56;58;47;48;42;43;41;57;73;74;63;51;50;40;62;60;65;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;11;-722.1964,-27.98087;Inherit;False;Property;_DistortionSpeed;DistortionSpeed;8;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;8;-436.9565,205.1326;Inherit;False;Property;_DistortionIntensity;DistortionIntensity;27;0;Create;True;0;0;0;False;0;False;0;0.4306035;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-496.3519,-554.4911;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;38;-76.65408,80.14715;Inherit;False;37;SMask;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexturePropertyNode;6;-401.2921,-11.97887;Inherit;True;Property;_DistortionNormalTex;DistortionNormalTex;10;0;Create;True;0;0;0;False;0;False;None;ec9dfdb4c2c53bf489f5dfbd612ad391;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.OneMinusNode;47;2526.336,1341.118;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;58;2481.553,1478.422;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;22;1664.658,837.0653;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;2747.37,1345.398;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;10;-685.2605,445.0688;Inherit;True;Property;_DistMask;DistMask;11;0;Create;True;0;0;0;False;0;False;b52aa278d60b1da49a10d0543cb3f979;b52aa278d60b1da49a10d0543cb3f979;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RegisterLocalVarNode;37;-340.9799,439.5194;Inherit;False;SMask;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleAddOpNode;50;3384.178,1412.093;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;43;3209.905,1328.652;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;66;-39.2616,-331.4104;Inherit;False;UI-Sprite Effect Layer;0;;7;789bf62641c5cfe4ab7126850acc22b8;18,204,0,74,0,191,1,225,0,242,0,237,0,249,0,186,0,177,1,182,1,229,1,92,0,98,0,234,0,126,0,129,1,130,0,31,0;18;192;COLOR;1,1,1,1;False;39;COLOR;1,1,1,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0;False;75;SAMPLER2D;;False;80;FLOAT;1;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0;False;231;FLOAT;1;False;30;FLOAT;1;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.SimpleTimeNode;29;1231.281,507.359;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;42;2938.219,1295.095;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;4169.397,1175.831;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;14;302.9071,73.9639;Inherit;True;Property;_FlowTex;FlowTex;18;0;Create;True;0;0;0;False;0;False;None;6b877baad4ae59141a83a973bec1f180;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;15;295.1865,266.3022;Inherit;True;Property;_FlowFlow;FlowFlow;20;0;Create;True;0;0;0;False;0;False;None;d73d22d2a70635846a66a61cc30e1a08;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.Vector2Node;28;1334.926,385.2032;Inherit;False;Property;_FoamSpeed;FoamSpeed;19;0;Create;True;0;0;0;False;0;False;0.1,0.2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DynamicAppendNode;57;2493.52,1209.755;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;7;-455.6241,-201.1107;Inherit;True;Property;_DistortionTex;DistortionTex;15;0;Create;True;0;0;0;False;0;False;None;d3c51bd10a69ad4438c0deaca614395a;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;40;3538.013,1162.376;Inherit;True;Property;_TextureSample4;Texture Sample 4;24;0;Create;True;0;0;0;False;0;False;-1;e979e9cc177700a45a4c6c5e87faae16;e979e9cc177700a45a4c6c5e87faae16;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;12;-698.9964,-149.7809;Inherit;False;Property;_DistiortionBGSpeed;DistiortionBGSpeed;7;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;21;793.433,1065.51;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;41;2931.411,1774.275;Inherit;True;Property;_TextureSample5;Texture Sample 5;23;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;63;3948.37,1398.049;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;16;326.7895,502.3288;Inherit;False;1;0;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;9;-549.2192,-368.1142;Inherit;False;Property;_DistoritionColor;DistoritionColor;9;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,0.4009434,0.4009434,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;74;2968.224,1572.748;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;51;3663.036,1403.83;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;73;2565.65,1762.972;Inherit;False;37;SMask;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.VertexColorNode;3;4027.489,-99.90898;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;4637.545,1094.302;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;68;1662.702,12.34938;Inherit;False;UI-Sprite Effect Layer;0;;9;789bf62641c5cfe4ab7126850acc22b8;18,204,1,74,1,191,1,225,0,242,0,237,0,249,1,186,0,177,1,182,1,229,1,92,1,98,0,234,0,126,0,129,1,130,0,31,1;18;192;COLOR;1,1,1,1;False;39;COLOR;1,1,1,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0;False;75;SAMPLER2D;;False;80;FLOAT;1;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0;False;231;FLOAT;1;False;30;FLOAT;1;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.ColorNode;31;1298.072,-220.4261;Inherit;False;Property;_FoamColor;FoamColor;28;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.8734207,0.0235849,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;1530.681,372.159;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;27;1230.831,183.6244;Inherit;True;Property;_FoamFLow;FoamFLow;16;0;Create;True;0;0;0;False;0;False;None;98ea86ecc1beaa643882ca248bfb3be7;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.DynamicAppendNode;60;4332,854.383;Inherit;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector4Node;56;2063.946,1466.154;Inherit;False;Property;_Vector3;Vector 3;25;0;Create;True;0;0;0;False;0;False;1.22,2.36,0.37,0.46;1.04,2.36,0.91,0.51;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;39;1927.976,679.7049;Inherit;False;37;SMask;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.PosVertexDataNode;85;5060.501,43.08331;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;35;1974.861,337.0891;Inherit;False;Property;_RotatePosScale;RotatePos&Scale;22;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;971.8214,946.679;Inherit;True;Property;_TextureSample2;Texture Sample 2;13;0;Create;True;0;0;0;False;0;False;-1;b563d52282448234b923a1122098f595;b563d52282448234b923a1122098f595;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;33;2036.861,-22.91089;Inherit;False;Property;_Color0;Color 0;21;0;Create;True;0;0;0;False;0;False;0,0.9053459,1,1;0,0.9053459,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;80;5855.721,340.2123;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;1347.57,954.3895;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;4814.271,-1.868443;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;1;-744.2136,-341.2852;Inherit;False;0;0;_MainTex;Shader;False;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;67;754.0336,-53.96375;Inherit;False;UI-Sprite Effect Layer;0;;8;789bf62641c5cfe4ab7126850acc22b8;18,204,1,74,1,191,1,225,0,242,0,237,0,249,0,186,0,177,1,182,1,229,1,92,1,98,0,234,0,126,0,129,1,130,0,31,1;18;192;COLOR;1,1,1,1;False;39;COLOR;1,1,1,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0;False;75;SAMPLER2D;;False;80;FLOAT;1;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0;False;231;FLOAT;1;False;30;FLOAT;1;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.BreakToComponentsNode;23;775.787,839.5881;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SamplerNode;19;422.3422,1075.864;Inherit;True;Property;_TextureSample3;Texture Sample 3;14;0;Create;True;0;0;0;False;0;False;-1;d73d22d2a70635846a66a61cc30e1a08;d73d22d2a70635846a66a61cc30e1a08;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;26;1231.801,-6.367622;Inherit;True;Property;_FoamTex;FoamTex;17;0;Create;True;0;0;0;False;0;False;None;f58721830b1c41b4e827c51ad1071991;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.ColorNode;17;328.2881,-134.3868;Inherit;False;Property;_FlowColor;FlowColor;12;0;Create;True;0;0;0;False;0;False;1,0.9048885,0,1;0,0.7202115,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;34;1994.861,143.0891;Inherit;True;Property;_RotateTex;RotateTex;23;0;Create;True;0;0;0;False;0;False;e979e9cc177700a45a4c6c5e87faae16;e979e9cc177700a45a4c6c5e87faae16;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;5461.467,150.3026;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SinTimeNode;79;5109.367,410.8026;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;64;4820.924,224.5723;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;69;2298.899,138.3489;Inherit;False;UI-Sprite Effect Layer;0;;10;789bf62641c5cfe4ab7126850acc22b8;18,204,2,74,2,191,1,225,0,242,0,237,0,249,0,186,0,177,0,182,0,229,0,92,0,98,1,234,0,126,0,129,1,130,1,31,1;18;192;COLOR;1,1,1,1;False;39;COLOR;1,1,1,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0;False;75;SAMPLER2D;;False;80;FLOAT;1;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0;False;231;FLOAT;1;False;30;FLOAT;1;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;5588.779,18.73165;Float;False;True;-1;2;ASEMaterialInspector;0;7;UIShader;5056123faa0c79b47ab6ad7e8bf059a4;True;Default;0;0;Default;2;False;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;True;True;True;True;True;0;True;-9;False;False;False;False;False;False;False;True;True;0;True;-5;255;True;-8;255;True;-7;0;True;-4;0;True;-6;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;2;False;-1;True;0;True;-11;False;True;5;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;87;0;76;0
WireConnection;2;0;1;0
WireConnection;47;0;57;0
WireConnection;58;0;56;3
WireConnection;58;1;56;4
WireConnection;22;0;23;0
WireConnection;22;1;23;1
WireConnection;22;2;23;2
WireConnection;22;3;20;0
WireConnection;48;0;47;0
WireConnection;48;1;58;0
WireConnection;37;0;10;0
WireConnection;50;0;42;2
WireConnection;43;0;42;0
WireConnection;43;2;74;0
WireConnection;66;39;9;0
WireConnection;66;37;7;0
WireConnection;66;181;12;0
WireConnection;66;75;6;0
WireConnection;66;80;8;0
WireConnection;66;183;11;0
WireConnection;66;233;38;0
WireConnection;42;0;57;0
WireConnection;42;1;48;0
WireConnection;62;0;40;4
WireConnection;62;1;63;0
WireConnection;57;0;56;1
WireConnection;57;1;56;2
WireConnection;40;1;43;0
WireConnection;21;0;19;2
WireConnection;21;1;16;0
WireConnection;41;0;73;0
WireConnection;63;0;41;1
WireConnection;63;2;51;0
WireConnection;51;0;50;0
WireConnection;65;0;60;0
WireConnection;65;1;62;0
WireConnection;68;192;67;0
WireConnection;68;39;31;0
WireConnection;68;37;26;0
WireConnection;68;33;27;0
WireConnection;68;248;30;0
WireConnection;30;0;28;0
WireConnection;30;1;29;0
WireConnection;60;0;40;1
WireConnection;60;1;40;2
WireConnection;60;2;40;3
WireConnection;60;3;62;0
WireConnection;18;1;21;0
WireConnection;20;0;19;4
WireConnection;20;1;18;1
WireConnection;4;0;3;0
WireConnection;4;1;64;0
WireConnection;67;192;66;0
WireConnection;67;39;17;0
WireConnection;67;37;14;0
WireConnection;67;33;15;0
WireConnection;67;40;16;0
WireConnection;77;0;82;0
WireConnection;77;1;87;0
WireConnection;64;0;68;0
WireConnection;64;1;65;0
WireConnection;69;192;68;0
WireConnection;69;39;33;0
WireConnection;69;37;34;0
WireConnection;69;101;39;0
WireConnection;69;57;35;0
WireConnection;69;40;29;0
WireConnection;0;1;77;0
ASEEND*/
//CHKSM=DCFADAEA0B566474BA55B880C82A9581BF7CB24F