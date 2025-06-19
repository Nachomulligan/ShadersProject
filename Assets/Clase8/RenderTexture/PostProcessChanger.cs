using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class PostProcessChanger : MonoBehaviour
{
    [SerializeField] private Volume volume; // Asignar el Volume en el Inspector
    [SerializeField] private VolumeProfile newProfile; // Asignar el nuevo perfil a usar

    public void ChangePostProcessingProfile()
    {
        if (volume != null && newProfile != null)
        {
            volume.profile = newProfile;
        }
        else
        {
            Debug.LogWarning("Volume o NewProfile no asignado.");
        }
    }
}