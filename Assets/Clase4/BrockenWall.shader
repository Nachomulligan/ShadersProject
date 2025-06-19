// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BrockenWall"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		_ThreshHoldConcret("ThreshHoldConcret", Range( 0 , 0.3)) = 0.2941177
		_Float0("Float 0", Range( 0 , 0.3)) = 0.2941177
		_NoiseScale("NoiseScale", Float) = 1
		_TexScale("TexScale", Float) = 0.1
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float3 worldPos;
		};

		uniform sampler2D _TextureSample0;
		uniform float _TexScale;
		uniform sampler2D _TextureSample1;
		uniform float _NoiseScale;
		uniform float _ThreshHoldConcret;
		uniform sampler2D _TextureSample2;
		uniform float _Float0;


		float2 voronoihash7( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi7( float2 v, float time, inout float2 id, inout float2 mr, float smoothness )
		{
			float2 n = floor( v );
			float2 f = frac( v );
			float F1 = 8.0;
			float F2 = 8.0; float2 mg = 0;
			for ( int j = -1; j <= 1; j++ )
			{
				for ( int i = -1; i <= 1; i++ )
			 	{
			 		float2 g = float2( i, j );
			 		float2 o = voronoihash7( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
					float d = 0.5 * dot( r, r );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			 		}
			 	}
			}
			return (F2 + F1) * 0.5;
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float2 appendResult6 = (float2(ase_worldPos.x , ase_worldPos.y));
			float2 temp_output_16_0 = ( _TexScale * appendResult6 );
			float time7 = 0.0;
			float2 coords7 = appendResult6 * _NoiseScale;
			float2 id7 = 0;
			float2 uv7 = 0;
			float fade7 = 0.5;
			float voroi7 = 0;
			float rest7 = 0;
			for( int it7 = 0; it7 <8; it7++ ){
			voroi7 += fade7 * voronoi7( coords7, time7, id7, uv7, 0 );
			rest7 += fade7;
			coords7 *= 2;
			fade7 *= 0.5;
			}//Voronoi7
			voroi7 /= rest7;
			float4 lerpResult13 = lerp( tex2D( _TextureSample0, temp_output_16_0 ) , ( tex2D( _TextureSample1, temp_output_16_0 ) * float4( 0.6037736,0.6037736,0.6037736,0 ) ) , step( voroi7 , _ThreshHoldConcret ));
			float4 color15 = IsGammaSpace() ? float4(0.490566,0.1383832,0.06247775,0) : float4(0.2054128,0.01704508,0.005153324,0);
			float4 lerpResult19 = lerp( lerpResult13 , ( tex2D( _TextureSample2, temp_output_16_0 ) * color15 ) , step( voroi7 , _Float0 ));
			o.Albedo = lerpResult19.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;631;1465;363;1510.998;514.0104;1.595588;True;False
Node;AmplifyShaderEditor.WorldPosInputsNode;5;-825.5517,151.2557;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;6;-636.6985,169.4156;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-610.6775,-52.48474;Inherit;False;Property;_TexScale;TexScale;6;0;Create;True;0;0;0;False;0;False;0.1;0.17;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-587.1086,390.2853;Inherit;False;Property;_NoiseScale;NoiseScale;5;0;Create;True;0;0;0;False;0;False;1;0.02;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-402.7986,7.785394;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;2;-141.1478,-209.2163;Inherit;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;0;False;0;False;-1;None;a0f86152841a54448863d97277b9a34d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VoronoiNode;7;-280.4205,329.9344;Inherit;False;0;0;1;3;8;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.RangedFloatNode;10;-86.60583,405.9936;Inherit;False;Property;_ThreshHoldConcret;ThreshHoldConcret;3;0;Create;True;0;0;0;False;0;False;0.2941177;0.1176471;0;0.3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-171.9235,-433.4041;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;None;60d874ccefe52b542a27ba46609ede27;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;9;197.2211,285.012;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;15;-98.46313,205.4624;Inherit;False;Constant;_Color0;Color 0;6;0;Create;True;0;0;0;False;0;False;0.490566,0.1383832,0.06247775,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;233.723,-172.0538;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.6037736,0.6037736,0.6037736,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-18.80103,550.0466;Inherit;False;Property;_Float0;Float 0;4;0;Create;True;0;0;0;False;0;False;0.2941177;0.1055386;0;0.3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;3;-103.4878,9.612976;Inherit;True;Property;_TextureSample2;Texture Sample 2;2;0;Create;True;0;0;0;False;0;False;-1;None;58a921806dc28c84c8bb2f29d4899f69;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;13;613.8714,-178.9695;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;12;290.199,446.0466;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;236.8185,43.42662;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;19;824.4075,-113.451;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;4;-269.5444,501.9615;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1116.016,-16.01102;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;BrockenWall;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;5;1
WireConnection;6;1;5;2
WireConnection;16;0;17;0
WireConnection;16;1;6;0
WireConnection;2;1;16;0
WireConnection;7;0;6;0
WireConnection;7;2;8;0
WireConnection;1;1;16;0
WireConnection;9;0;7;0
WireConnection;9;1;10;0
WireConnection;18;0;2;0
WireConnection;3;1;16;0
WireConnection;13;0;1;0
WireConnection;13;1;18;0
WireConnection;13;2;9;0
WireConnection;12;0;7;0
WireConnection;12;1;11;0
WireConnection;14;0;3;0
WireConnection;14;1;15;0
WireConnection;19;0;13;0
WireConnection;19;1;14;0
WireConnection;19;2;12;0
WireConnection;4;0;6;0
WireConnection;0;0;19;0
ASEEND*/
//CHKSM=905622B320566775C5ECCD96A0CE2E9B08B43D68