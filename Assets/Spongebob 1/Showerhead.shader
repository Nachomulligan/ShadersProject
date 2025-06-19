// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Showerhead"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Scale("Scale", Float) = 0.25
		_NoiseScale("NoiseScale", Float) = 0.2
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
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
		uniform float _Scale;
		uniform sampler2D _TextureSample2;
		uniform float _NoiseScale;
		uniform sampler2D _TextureSample1;


		float2 voronoihash28( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi28( float2 v, float time, inout float2 id, inout float2 mr, float smoothness )
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
			 		float2 o = voronoihash28( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
					float d = 0.707 * sqrt(dot( r, r ));
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			 		}
			 	}
			}
			return F1;
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float2 appendResult25 = (float2(ase_worldPos.x , ase_worldPos.y));
			float2 temp_output_41_0 = ( appendResult25 * _Scale );
			float time28 = 0.0;
			float2 coords28 = appendResult25 * _NoiseScale;
			float2 id28 = 0;
			float2 uv28 = 0;
			float fade28 = 0.5;
			float voroi28 = 0;
			float rest28 = 0;
			for( int it28 = 0; it28 <3; it28++ ){
			voroi28 += fade28 * voronoi28( coords28, time28, id28, uv28, 0 );
			rest28 += fade28;
			coords28 *= 2;
			fade28 *= 0.5;
			}//Voronoi28
			voroi28 /= rest28;
			float4 lerpResult36 = lerp( tex2D( _TextureSample0, temp_output_41_0 ) , tex2D( _TextureSample2, temp_output_41_0 ) , step( voroi28 , 0.2942304 ));
			float4 color39 = IsGammaSpace() ? float4(0.7924528,0.1532574,0.1532574,0) : float4(0.5911142,0.02036269,0.02036269,0);
			float4 lerpResult42 = lerp( lerpResult36 , ( tex2D( _TextureSample1, temp_output_41_0 ) * color39 ) , step( voroi28 , 0.1930269 ));
			o.Albedo = lerpResult42.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;622;1466;364;251.2661;95.76802;1;True;False
Node;AmplifyShaderEditor.WorldPosInputsNode;24;-1147.336,318.0362;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;29;-677.2493,618.4171;Inherit;False;Property;_NoiseScale;NoiseScale;2;0;Create;True;0;0;0;False;0;False;0.2;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-852.3527,13.577;Inherit;False;Property;_Scale;Scale;1;0;Create;True;0;0;0;False;0;False;0.25;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;25;-863.2422,162.3038;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.VoronoiNode;28;-439.9406,427.7115;Inherit;False;0;1;1;0;3;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.RangedFloatNode;31;-324.5879,552.0168;Inherit;False;Constant;_ThresholdRust;ThresholdRust;3;0;Create;True;0;0;0;False;0;False;0.2942304;0;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-663.5319,-37.5849;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-314.5342,684.4725;Inherit;False;Constant;_ThresholdRust2;ThresholdRust2;3;0;Create;True;0;0;0;False;0;False;0.1930269;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;39;-278.4261,235.0742;Inherit;False;Constant;_Color0;Color 0;5;0;Create;True;0;0;0;False;0;False;0.7924528,0.1532574,0.1532574,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-346.2144,-383.2963;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;54c61a9879f62cf44a1d23108e7cb634;54c61a9879f62cf44a1d23108e7cb634;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;37;-335.9985,-171.573;Inherit;True;Property;_TextureSample2;Texture Sample 2;4;0;Create;True;0;0;0;False;0;False;-1;db69f66ba102ae341b850fd0d124520c;6d8e15d897debda4b9181611615bafe8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;30;-42.68675,375.6042;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;34;-327.8047,27.27066;Inherit;True;Property;_TextureSample1;Texture Sample 1;3;0;Create;True;0;0;0;False;0;False;-1;fc395b0d6bf0b2f4c8efe18e70818af4;fc395b0d6bf0b2f4c8efe18e70818af4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;36;107.0585,-49.57688;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-6.374907,150.9859;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;33;31.16681,519.3721;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;42;384.8586,-38.08204;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;687.4296,-30.63143;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Showerhead;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;25;0;24;1
WireConnection;25;1;24;2
WireConnection;28;0;25;0
WireConnection;28;2;29;0
WireConnection;41;0;25;0
WireConnection;41;1;27;0
WireConnection;1;1;41;0
WireConnection;37;1;41;0
WireConnection;30;0;28;0
WireConnection;30;1;31;0
WireConnection;34;1;41;0
WireConnection;36;0;1;0
WireConnection;36;1;37;0
WireConnection;36;2;30;0
WireConnection;40;0;34;0
WireConnection;40;1;39;0
WireConnection;33;0;28;0
WireConnection;33;1;32;0
WireConnection;42;0;36;0
WireConnection;42;1;40;0
WireConnection;42;2;33;0
WireConnection;0;0;42;0
ASEEND*/
//CHKSM=22FA04C729E19CE49FB0AAEAB9568E416AA72B82