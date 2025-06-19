// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "GB_View"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}

	SubShader
	{
		LOD 0

		
		
		ZTest Always
		Cull Off
		ZWrite Off

		
		Pass
		{ 
			CGPROGRAM 

			

			#pragma vertex vert_img_custom 
			#pragma fragment frag
			#pragma target 3.0
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"


			struct appdata_img_custom
			{
				float4 vertex : POSITION;
				half2 texcoord : TEXCOORD0;
				
			};

			struct v2f_img_custom
			{
				float4 pos : SV_POSITION;
				half2 uv   : TEXCOORD0;
				half2 stereoUV : TEXCOORD2;
		#if UNITY_UV_STARTS_AT_TOP
				half4 uv2 : TEXCOORD1;
				half4 stereoUV2 : TEXCOORD3;
		#endif
				float4 ase_texcoord4 : TEXCOORD4;
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			inline float Dither4x4Bayer( int x, int y )
			{
				const float dither[ 16 ] = {
			 1,  9,  3, 11,
			13,  5, 15,  7,
			 4, 12,  2, 10,
			16,  8, 14,  6 };
				int r = y * 4 + x;
				return dither[r] / 16; // same # of instructions as pre-dividing due to compiler magic
			}
			
			float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }
			float snoise( float2 v )
			{
				const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
				float2 i = floor( v + dot( v, C.yy ) );
				float2 x0 = v - i + dot( i, C.xx );
				float2 i1;
				i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
				float4 x12 = x0.xyxy + C.xxzz;
				x12.xy -= i1;
				i = mod2D289( i );
				float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
				float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
				m = m * m;
				m = m * m;
				float3 x = 2.0 * frac( p * C.www ) - 1.0;
				float3 h = abs( x ) - 0.5;
				float3 ox = floor( x + 0.5 );
				float3 a0 = x - ox;
				m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
				float3 g;
				g.x = a0.x * x0.x + h.x * x0.y;
				g.yz = a0.yz * x12.xz + h.yz * x12.yw;
				return 130.0 * dot( m, g );
			}
			


			v2f_img_custom vert_img_custom ( appdata_img_custom v  )
			{
				v2f_img_custom o;
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord4 = screenPos;
				
				o.pos = UnityObjectToClipPos( v.vertex );
				o.uv = float4( v.texcoord.xy, 1, 1 );

				#if UNITY_UV_STARTS_AT_TOP
					o.uv2 = float4( v.texcoord.xy, 1, 1 );
					o.stereoUV2 = UnityStereoScreenSpaceUVAdjust ( o.uv2, _MainTex_ST );

					if ( _MainTex_TexelSize.y < 0.0 )
						o.uv.y = 1.0 - o.uv.y;
				#endif
				o.stereoUV = UnityStereoScreenSpaceUVAdjust ( o.uv, _MainTex_ST );
				return o;
			}

			half4 frag ( v2f_img_custom i ) : SV_Target
			{
				#ifdef UNITY_UV_STARTS_AT_TOP
					half2 uv = i.uv2;
					half2 stereoUV = i.stereoUV2;
				#else
					half2 uv = i.uv;
					half2 stereoUV = i.stereoUV;
				#endif	
				
				half4 finalColor;

				// ase common template code
				float4 color2 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
				float4 color3 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float4 screenPos = i.ase_texcoord4;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float2 clipScreen4 = ase_screenPosNorm.xy * _ScreenParams.xy;
				float dither4 = Dither4x4Bayer( fmod(clipScreen4.x, 4), fmod(clipScreen4.y, 4) );
				float2 uv_MainTex = i.uv.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float grayscale5 = Luminance(tex2D( _MainTex, uv_MainTex ).rgb);
				dither4 = step( dither4, grayscale5 );
				float4 lerpResult1 = lerp( color2 , color3 , dither4);
				float mulTime30 = _Time.y * -0.2;
				float2 temp_cast_1 = (( ase_screenPosNorm.x + mulTime30 )).xx;
				float simplePerlin2D27 = snoise( temp_cast_1*10.16 );
				

				finalColor = saturate( ( ( lerpResult1 * ( 1.0 - sin( ( ( ase_screenPosNorm.x + _Time.y ) * 100.05 ) ) ) ) + saturate( (0.0 + (saturate( ( simplePerlin2D27 - 0.72 ) ) - 0.0) * (1.0 - 0.0) / (0.28 - 0.0)) ) ) );

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
0;622;1466;364;1254.44;-311.3718;1;True;False
Node;AmplifyShaderEditor.ScreenPosInputsNode;26;-1437.562,259.7124;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;30;-1459.092,462.2666;Inherit;False;1;0;FLOAT;-0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1570.004,786.0469;Inherit;False;Constant;_TimeS1;TimeS;0;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;22;-1338.936,113.792;Inherit;False;0;0;_MainTex;Shader;False;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;29;-1128.092,395.2666;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-1112.092,532.2666;Inherit;False;Constant;_Float0;Float 0;0;0;Create;True;0;0;0;False;0;False;10.16;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;15;-1426.005,734.0469;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-1325.005,817.0469;Inherit;False;Constant;_Frecuency1;Frecuency;0;0;Create;True;0;0;0;False;0;False;100.05;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-1243.005,636.0471;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;10;-1064.082,115.9358;Inherit;True;Property;_u1;u;0;0;Create;True;0;0;0;False;0;False;-1;None;e9f062386536d7b47b56d6f144b4bac1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;27;-936.9221,372.3061;Inherit;True;Simplex2D;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCGrayscale;5;-733.0822,125.9358;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;31;-674.0923,353.2666;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.72;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-1078.594,649.3649;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;20;-871.5925,649.2396;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2;-565.2465,-240.7776;Inherit;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DitheringNode;4;-530.7465,124.5224;Inherit;False;0;False;4;0;FLOAT;0;False;1;SAMPLER2D;;False;2;FLOAT4;0,0,0,0;False;3;SAMPLERSTATE;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;3;-563.9466,-69.17757;Inherit;False;Constant;_Color1;Color 1;0;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;33;-475.0923,359.2666;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;24;-673.2659,647.5778;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1;-314.1465,-39.27753;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;32;-317.0923,353.2666;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.28;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-170.6841,615.5234;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;35;-54.08301,353.5215;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;34;55.33763,248.7601;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;36;220.4739,151.4779;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;330.2047,-34.21039;Float;False;True;-1;2;ASEMaterialInspector;0;4;GB_View;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;29;0;26;1
WireConnection;29;1;30;0
WireConnection;15;0;14;0
WireConnection;17;0;26;1
WireConnection;17;1;15;0
WireConnection;10;0;22;0
WireConnection;27;0;29;0
WireConnection;27;1;28;0
WireConnection;5;0;10;0
WireConnection;31;0;27;0
WireConnection;19;0;17;0
WireConnection;19;1;18;0
WireConnection;20;0;19;0
WireConnection;4;0;5;0
WireConnection;33;0;31;0
WireConnection;24;0;20;0
WireConnection;1;0;2;0
WireConnection;1;1;3;0
WireConnection;1;2;4;0
WireConnection;32;0;33;0
WireConnection;21;0;1;0
WireConnection;21;1;24;0
WireConnection;35;0;32;0
WireConnection;34;0;21;0
WireConnection;34;1;35;0
WireConnection;36;0;34;0
WireConnection;0;0;36;0
ASEEND*/
//CHKSM=CD60F7FAFDBC6139CC246D291C11B1E497227D1E