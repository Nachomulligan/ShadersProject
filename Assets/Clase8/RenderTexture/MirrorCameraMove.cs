using UnityEngine;

public class MirrorCameraMove : MonoBehaviour
{
    public Camera playerCam;
    public Camera mirrorCam;
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        var playerLocalPos = transform.InverseTransformPoint(playerCam.transform.position);
        mirrorCam.nearClipPlane = playerLocalPos.z;
        playerLocalPos.z *= -1;
        mirrorCam.transform.position = transform.TransformPoint( playerLocalPos);

        var playerLocalRot = transform.InverseTransformDirection(playerCam.transform.forward);
        playerLocalRot.z *= -1;
        mirrorCam.transform.forward = transform.InverseTransformDirection( playerLocalRot);
    }
}
