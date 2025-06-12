using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Camera))]
public class DistancePostProcess : MonoBehaviour
{
    public Shader _shader;
    public Texture texture;
    //[Range(0, 1)]
    [SerializeField] private float intensity, fallOff;
    //[SerializeField] private Color miColor;
    private float oldIntensity, oldFallOff;
    //private Color oldColor;

    private Material mat;
    void Start()
    {
        mat = new Material(_shader);
        mat.SetTexture("_MiTextura", texture);
        oldIntensity = intensity;
        oldFallOff = fallOff;
    }
    private void Update()
    {
        //Vector3 colorv3 = new Vector3(miColor.r, miColor.g, miColor.b);
        //mat.SetVector("_ColorV3", colorv3);
        //mat.SetColor("_MiHermosoColor", miColor);

        if (oldIntensity != intensity || oldFallOff != fallOff)
            SetValues();
    }
    private void SetValues()
    {
        mat.SetFloat("_Intensity", intensity);
        mat.SetFloat("_FallOff", fallOff);
        oldIntensity = intensity;
        oldFallOff = fallOff;
        //oldColor = miColor;
    }
    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        source.wrapMode = TextureWrapMode.Mirror;
        Graphics.Blit(source, destination, mat);
    }
}
