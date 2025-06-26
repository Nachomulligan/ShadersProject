// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "FaucetWater"
{
	Properties
	{
		_NoiseScale("NoiseScale", Float) = 1
		_Speed("Speed", Float) = 4
		_Intensity("Intensity", Float) = 1
		_Vector1("Vector 1", Vector) = (1,0,1,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
		};

		uniform float _Speed;
		uniform float _NoiseScale;
		uniform float _Intensity;
		uniform float3 _Vector1;


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


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float mulTime4 = _Time.y * _Speed;
			float simplePerlin2D5 = snoise( ( ase_vertex3Pos + mulTime4 ).xy*_NoiseScale );
			simplePerlin2D5 = simplePerlin2D5*0.5 + 0.5;
			float temp_output_9_0 = sin( ( simplePerlin2D5 * _Intensity ) );
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( saturate( temp_output_9_0 ) * ase_vertexNormal * _Vector1 );
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color16 = IsGammaSpace() ? float4(0.2511125,0.5377358,0.5028762,0) : float4(0.0513226,0.2506461,0.216713,0);
			float4 color15 = IsGammaSpace() ? float4(0,0.4622642,0.4622642,0) : float4(0,0.1807607,0.1807607,0);
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float mulTime4 = _Time.y * _Speed;
			float simplePerlin2D5 = snoise( ( ase_vertex3Pos + mulTime4 ).xy*_NoiseScale );
			simplePerlin2D5 = simplePerlin2D5*0.5 + 0.5;
			float temp_output_9_0 = sin( ( simplePerlin2D5 * _Intensity ) );
			float4 lerpResult12 = lerp( color16 , color15 , (0.6 + (temp_output_9_0 - -1.0) * (1.0 - 0.6) / (1.0 - -1.0)));
			o.Emission = lerpResult12.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;402;1467;592;1791.969;509.3516;2.012918;True;False
Node;AmplifyShaderEditor.CommentaryNode;23;-819.5768,-425.4488;Inherit;False;1448.799;776.7393;Color and Speed;14;3;1;4;2;6;8;5;7;9;16;15;10;17;12;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-759.9818,170.6138;Inherit;False;Property;_Speed;Speed;1;0;Create;True;0;0;0;False;0;False;4;5.53;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;4;-528.7283,144.7402;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;1;-769.5768,4.411349;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;6;-438.2404,236.1305;Inherit;False;Property;_NoiseScale;NoiseScale;0;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2;-336.5,38.5;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-171.5024,207.3864;Inherit;False;Property;_Intensity;Intensity;2;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;5;-208.5,82.5;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;18.24677,130.7087;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;22;125.3175,371.558;Inherit;False;580.4807;390.64;Water Offset;3;21;19;20;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SinOpNode;9;161.8859,140.2717;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;19;320.3178,577.5577;Inherit;False;Property;_Vector1;Vector 1;3;0;Create;True;0;0;0;False;0;False;1,0,1;1,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalVertexDataNode;21;175.3176,421.558;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;17;334.5437,214.4943;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;16;107.6121,-375.4488;Inherit;False;Constant;_Color1;Color 1;0;0;Create;True;0;0;0;False;0;False;0.2511125,0.5377358,0.5028762,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;15;106.6121,-189.4488;Inherit;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;0;False;0;False;0,0.4622642,0.4622642,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;10;349.8656,-21.37272;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0.6;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;542.3184,488.558;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;12;446.6121,-186.4488;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;800.5002,-100.4341;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;FaucetWater;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;3;0
WireConnection;2;0;1;0
WireConnection;2;1;4;0
WireConnection;5;0;2;0
WireConnection;5;1;6;0
WireConnection;7;0;5;0
WireConnection;7;1;8;0
WireConnection;9;0;7;0
WireConnection;17;0;9;0
WireConnection;10;0;9;0
WireConnection;20;0;17;0
WireConnection;20;1;21;0
WireConnection;20;2;19;0
WireConnection;12;0;16;0
WireConnection;12;1;15;0
WireConnection;12;2;10;0
WireConnection;0;2;12;0
WireConnection;0;11;20;0
ASEEND*/
//CHKSM=98E1EF50479E60C3F1407858FADA6BAEF95D6204