using UnityEngine;

[ExecuteInEditMode]
public class OceanDirections : MonoBehaviour
{
    [SerializeField] Material mat;
    [SerializeField] Transform[] directions;
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        mat.SetVector("_Dir1", directions[0].forward);
        mat.SetVector("_Dir2", directions[1].forward);
        mat.SetVector("_Dir3", directions[2].forward);
        mat.SetVector("_Dir4", directions[3].forward);
    }
}
