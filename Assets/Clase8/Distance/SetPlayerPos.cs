using UnityEngine;

public class SetPlayerPos : MonoBehaviour
{
    public Material mat;
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        mat.SetVector("_PlayerPos", transform.position);
    }
}
