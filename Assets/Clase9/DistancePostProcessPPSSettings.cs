// Amplify Shader Editor - Visual Shader Editing Tool
// Copyright (c) Amplify Creations, Lda <info@amplify.pt>
#if UNITY_POST_PROCESSING_STACK_V2
using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess( typeof( DistancePostProcessPPSRenderer ), PostProcessEvent.AfterStack, "DistancePostProcess", true )]
public sealed class DistancePostProcessPPSSettings : PostProcessEffectSettings
{
	[Tooltip( "Range" )]
	public FloatParameter _Range = new FloatParameter { value = 1f };
	[Tooltip( "FallOff" )]
	public FloatParameter _FallOff = new FloatParameter { value = 1f };
	[Tooltip( "Intensity" )]
	public FloatParameter _Intensity = new FloatParameter { value = 0f };
	[Tooltip( "Color" )]
	public ColorParameter _Color = new ColorParameter { value = new Color(0f,0f,0f,0f) };
}

public sealed class DistancePostProcessPPSRenderer : PostProcessEffectRenderer<DistancePostProcessPPSSettings>
{
	public override void Render( PostProcessRenderContext context )
	{
		var sheet = context.propertySheets.Get( Shader.Find( "DistancePostProcess" ) );
		sheet.properties.SetFloat( "_Range", settings._Range );
		sheet.properties.SetFloat( "_FallOff", settings._FallOff );
		sheet.properties.SetFloat( "_Intensity", settings._Intensity );
		sheet.properties.SetColor( "_Color", settings._Color );
		context.command.BlitFullscreenTriangle( context.source, context.destination, sheet, 0 );
	}
}
#endif
