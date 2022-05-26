using UnityEngine;
using System.Collections;

public class ShotBehavior : MonoBehaviour {
	public float laser_speed;
	private float time = 0.0f;
	private Vector3 init_position;
	
    public AudioClip shootSound;
    public float shootVolume = 1f;
	public GameObject spawnOnHit;
	public GameObject spawnOnHit2;
	// Use this for initialization
	void Start () {
		init_position = this.transform.position;
	}
	
	// Update is called once per frame
	void Update () {
		this.transform.Translate (-Vector3.forward * laser_speed * Time.deltaTime);
		if(Vector3.Distance(init_position, this.transform.position) > 100.0f) {
			Destroy(this.gameObject);
		}
     

	}

	void OnTriggerEnter(Collider col ){
         AudioSource.PlayClipAtPoint(shootSound, transform.position, shootVolume);
         Destroy(this.gameObject);
		 Instantiate(spawnOnHit, this.transform.position, this.transform.rotation);
		 Instantiate(spawnOnHit2, this.transform.position, this.transform.rotation);
		 Debug.Log("HIT");
	}
}
