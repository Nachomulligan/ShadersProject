using System.Collections;
using System.Collections.Generic;
using UnityEngine;


[RequireComponent(typeof(Camera))]
public class FlashBang : MonoBehaviour
{
    public Shader shader;
    [SerializeField] private float intensity;
    public float flashTime;

    private Camera _cam;
    private Material _mat;
    private float _timer;
    private RenderTexture _flashFrame;
    private void Awake()
    {
        _cam = GetComponent<Camera>();
        _mat = new Material(shader);
    }

    void Update()
    {
        if(Input.GetKeyDown(KeyCode.Space))
        {
            _timer = Time.time + flashTime;
            _flashFrame = new RenderTexture(_cam.pixelWidth, _cam.pixelHeight, 10, RenderTextureFormat.ARGB32);
            Graphics.Blit(_mat.GetTexture("_MainTex"), _flashFrame);
            _mat.SetTexture("_FlashTexture", _flashFrame);
        }

        intensity = Mathf.Clamp(_timer - Time.time, 0, flashTime);
        intensity = 0 + (intensity - 0) * (1 - 0) / (flashTime - 0);

        _mat.SetFloat("_Intensity", intensity);
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, _mat);
    }
}
