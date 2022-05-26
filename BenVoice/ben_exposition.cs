using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ben_exposition : MonoBehaviour
{
    private float t;
    public Animator ben_animator;
    public AudioClip ben_voice_clip;
    public float exposition_volume;
    private bool playing;
    // Start is called before the first frame update
    void Start()
    {
        t = 0;
        playing = false;
        
    }

    // Update is called once per frame
    void Update()
    {
        return;
        t += Time.deltaTime;
        if (!playing) {
            playing = true;
            AudioSource.PlayClipAtPoint(ben_voice_clip, this.transform.position, exposition_volume);
            ben_animator.SetTrigger("Talk1");
        }
        
    }
}
