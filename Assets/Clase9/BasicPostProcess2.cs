using UnityEngine;
[RequireComponent(typeof(Camera))]
public class BasicPostProcess2 : MonoBehaviour
{
    public Shader _shader;
    public Texture texture;
    //[Range(0, 1)]
    [SerializeField] private float intensity, threshhold;
    //[SerializeField] private Color miColor;
    private float oldIntensity, oldthreshold;
    //private Color oldColor;
    private Material mat;

    // Variable para controlar si el post proceso está activo
    [SerializeField] private bool isPostProcessActive = true;

    void Start()
    {
        mat = new Material(_shader);
        mat.SetTexture("_MiTextura", texture);
        oldIntensity = intensity;
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.Alpha0))
        {
            isPostProcessActive = !isPostProcessActive;
            Debug.Log("Post Process: " + (isPostProcessActive ? "ON" : "OFF"));
        }

        //Vector3 colorv3 = new Vector3(miColor.r, miColor.g, miColor.b);
        //mat.SetVector("_ColorV3", colorv3);
        //mat.SetColor("_MiHermosoColor", miColor);
        if (oldIntensity != intensity || oldthreshold != threshhold)
            SetValues();
    }

    private void SetValues()
    {
        mat.SetFloat("_Intensity", intensity);
        mat.SetFloat("_Threshold", threshhold);
        oldIntensity = intensity;
        oldthreshold = threshhold;
        //oldColor = miColor;
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (isPostProcessActive && mat != null)
        {
            source.wrapMode = TextureWrapMode.Mirror;
            Graphics.Blit(source, destination, mat);
        }
        else
        {
            Graphics.Blit(source, destination);
        }
    }
}