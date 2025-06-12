// Amplify Shader Editor - Visual Shader Editing Tool
// Copyright (c) Amplify Creations, Lda <info@amplify.pt>
#if UNITY_POST_PROCESSING_STACK_V2
using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess( typeof( PP_SobelEdgeDetectPPSRenderer ), PostProcessEvent.AfterStack, "PP_SobelEdgeDetect", true )]
public sealed class PP_SobelEdgeDetectPPSSettings : PostProcessEffectSettings
{
	[Tooltip( "Intensity" )]
	public FloatParameter _Intensity = new FloatParameter { value = 10f };
	[Tooltip( "Saturation Intensity" )]
	public FloatParameter _SaturationIntensity = new FloatParameter { value = 1f };
	[Tooltip( "Step" )]
	public FloatParameter _Step = new FloatParameter { value = 1f };
	[Tooltip( "Sobel Tint" )]
	public ColorParameter _SobelTint = new ColorParameter { value = new Color(0f,0f,0f,0f) };
}

public sealed class PP_SobelEdgeDetectPPSRenderer : PostProcessEffectRenderer<PP_SobelEdgeDetectPPSSettings>
{
	public override void Render( PostProcessRenderContext context )
	{
		var sheet = context.propertySheets.Get( Shader.Find( "Hidden/PP_SobelEdgeDetect" ) );
		sheet.properties.SetFloat( "_Intensity", settings._Intensity );
		sheet.properties.SetFloat( "_SaturationIntensity", settings._SaturationIntensity );
		sheet.properties.SetFloat( "_Step", settings._Step );
		sheet.properties.SetColor( "_SobelTint", settings._SobelTint );
		context.command.BlitFullscreenTriangle( context.source, context.destination, sheet, 0 );
	}
}
#endif
