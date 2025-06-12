// Amplify Shader Editor - Visual Shader Editing Tool
// Copyright (c) Amplify Creations, Lda <info@amplify.pt>
#if UNITY_POST_PROCESSING_STACK_V2
using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess( typeof( UVPostProcessPPSRenderer ), PostProcessEvent.AfterStack, "UVPostProcess", true )]
public sealed class UVPostProcessPPSSettings : PostProcessEffectSettings
{
	[Tooltip( "MiTextura" )]
	public TextureParameter _MiTextura = new TextureParameter {  };
	[Tooltip( "Intensity" )]
	public FloatParameter _Intensity = new FloatParameter { value = 10f };
}

public sealed class UVPostProcessPPSRenderer : PostProcessEffectRenderer<UVPostProcessPPSSettings>
{
	public override void Render( PostProcessRenderContext context )
	{
		var sheet = context.propertySheets.Get( Shader.Find( "UVPostProcess" ) );
		if(settings._MiTextura.value != null) sheet.properties.SetTexture( "_MiTextura", settings._MiTextura );
		sheet.properties.SetFloat( "_Intensity", settings._Intensity );
		context.command.BlitFullscreenTriangle( context.source, context.destination, sheet, 0 );
	}
}
#endif
