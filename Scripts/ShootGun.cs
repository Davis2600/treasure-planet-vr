using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShootGun : MonoBehaviour
{
     public Rigidbody body;

    public Transform barrelTip;
    public float hitPower = 1;
    public float recoilPower = 1;
    public float range = 100;
    public LayerMask layer;

    public AudioClip shootSound;
    public float shootVolume = 1f;

    public GameObject laser;
    private GameObject[] lasers;
    // Start is called before the first frame update
    void Start()
    {
       // test 
       
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void Shoot() {
            //Play the audio sound
            if(shootSound)
                AudioSource.PlayClipAtPoint(shootSound, transform.position, shootVolume);

            RaycastHit hit;
            Instantiate(laser, barrelTip.position + (barrelTip.forward * -1.0f) , barrelTip.rotation);
            if(Physics.Raycast(barrelTip.position, barrelTip.forward, out hit, range, layer)){
                var hitBody = hit.transform.GetComponent<Rigidbody>();
                if(hitBody != null) {
                    Debug.DrawRay(barrelTip.position, (hit.point - barrelTip.position), Color.green, 5);
                    hitBody.AddForceAtPosition((hit.point - barrelTip.position).normalized*hitPower*10, hit.point, ForceMode.Impulse);
                }

            }
            else
                Debug.DrawRay(barrelTip.position, barrelTip.forward*range, Color.red, 1);

            body.AddForce(barrelTip.transform.up*recoilPower*5, ForceMode.Impulse);
        }
}
