using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

[ExecuteInEditMode]
public class Replacement : MonoBehaviour
{
    [SerializeField] private Shader replacementShader;
    [SerializeField] private Color globalColor;
    private void OnEnable()
    {
        GetComponent<Camera>().SetReplacementShader(replacementShader, "MiTag");
        Shader.SetGlobalColor("_GlobalColor", globalColor);
    }

    private void OnDisable()
    {
        GetComponent<Camera>().ResetReplacementShader();
    }
}
/*
 SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "MiTag"="Franco" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float3 worldPos;
		};

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color10 = IsGammaSpace() ? float4(0.3046733,1,0,0) : float4(0.07557425,1,0,0);
			float3 ase_worldPos = i.worldPos;
			float4 lerpResult8 = lerp( color10 , float4( 0,0,0,0 ) , (0.0 + (sin( ( ( ase_worldPos.y + _Time.y ) * 10.0 ) ) - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)));
			o.Albedo = lerpResult8.rgb;
			o.Alpha = 1;
		}

		ENDCG
	} 
 */

/*
SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  "MiTag"="Pepito" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Color;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Emission = ( _Color * step( distance( i.uv_texcoord , float2( 0.5,0.5 ) ) , 0.4 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
 */