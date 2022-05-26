using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class sparkScript : MonoBehaviour
{
    // Start is called before the first frame update
    private float updates;
    public float kill_time;
    void Start()
    {
        updates = 0.0f;
    }

    // Update is called once per frame
    void Update()
    {
        updates += Time.deltaTime;
        if(updates > kill_time) {
            Destroy(this.gameObject);
        }
    }
}
