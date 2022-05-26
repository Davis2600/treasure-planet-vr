using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TeleportBackToTable : MonoBehaviour
{
    private Vector3 init_position;
    private Quaternion init_rotation;
    // Start is called before the first frame update
    void Start()
    {
        init_position = this.transform.position;
        init_rotation = this.transform.rotation; 
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void OnTriggerEnter(Collider col) {
        if(col.gameObject.tag == "floor") {
            this.transform.position = init_position;
            this.transform.rotation = init_rotation;
        }
    }
}
