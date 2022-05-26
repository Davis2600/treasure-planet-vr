using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using UnityEngine.SceneManagement;
public class MorphController : MonoBehaviour
{
    public Animator animator;
    public Vector3[] positions;
    public Vector3[] rotations;
    private float t;
    private bool gameplayLoop;
    private int current_index;
    private float move_timer;
    public GameObject teleport_flash;
    public GameObject to_move;
    public AudioClip teleport_sound;
    public AudioClip hit_sound;
    private float next_move;
    public bool started;
    public bool exposition;
    public float expos_timer;
    public int hits;
    public TMPro.TextMeshProUGUI myText;
    public TMPro.TextMeshProUGUI timer_text;
    private string score_text; 
    public GameObject table_items;
    public GameObject button;
    public float timer;
    public Animator ben_animator;
    public AudioClip ben_voice_clip;
    public float exposition_volume;
    private bool playing;
    public GameObject Ben;
    private Vector3 init_position;
    private Quaternion init_rotation;
    public AudioClip ben_win_clip;
    public GameObject panel;
    public GameObject instruction;
    void Start()
    {
        animator = GetComponent<Animator>();    
        t = 0;
        gameplayLoop = false;
        timer = 60.0f;
        current_index = 0;
        move_timer = 0.0f;
        next_move = 5.0f;
        expos_timer = 31.0f;
        started = false;
        hits = 0;
        score_text = "Push the button to start!";
        myText.text = score_text;
        table_items.SetActive(false);
        init_position = to_move.transform.position;
        init_rotation = to_move.transform.rotation;
    }

    // Update is called once per frame
    void Update()
    {
        if (exposition) {
            expos_timer -= Time.deltaTime;
        }
        float transitionDuration = 0.5f;
        t += Time.deltaTime;
        if (started && t > 1.0f && !gameplayLoop) {
            //animator.SetTrigger("Shrink");
            gameplayLoop = true;
            Debug.Log("Moving Morph");
            animator.SetTrigger("Shrink");
            Instantiate(teleport_flash, this.transform.position, this.transform.rotation);
            to_move.transform.position = positions[current_index];
            to_move.transform.rotation = Quaternion.Euler(rotations[current_index]);
            move_timer = 0.0f;


        }
        if(gameplayLoop) {
            move_timer += Time.deltaTime;
            if(move_timer > next_move) {
                // we move to the next location
                Debug.Log(current_index);
                int new_index = Random.Range(0, positions.Length);
                current_index = new_index == current_index ? (current_index + 1) % positions.Length : new_index;
                Instantiate(teleport_flash, this.transform.position, this.transform.rotation);
                AudioSource.PlayClipAtPoint(teleport_sound, transform.position, 0.5f);
                to_move.transform.position = positions[current_index];
                to_move.transform.rotation = Quaternion.Euler(rotations[current_index]);
                move_timer = 0.0f;
                next_move = Random.Range(4.0f, 8.0f);
                
            }
        }
        if(started) {
            timer -= Time.deltaTime;
            timer_text.text = $"Time: {timer:F1}";
            if(timer <= 0) {
                timer_text.text = "GAME OVER";
                gameplayLoop = false;
                started = false;
                this.transform.position = init_position;
                this.transform.rotation = init_rotation;
                animator.ResetTrigger("Shrink");
                animator.SetTrigger("PopOut");
                AudioSource.PlayClipAtPoint(ben_win_clip, Ben.transform.position, 5.0f);
                ben_animator.SetTrigger("Celebration");
                
            }
        }
    }

    void OnTriggerEnter(Collider col) {
        if(col.gameObject.tag == "blaster" && gameplayLoop) {
            Debug.Log("Hit");
            hits++;
            gameplayLoop = false;
            animator.SetTrigger("PopOut");
            AudioSource.PlayClipAtPoint(hit_sound, transform.position, 5f); 
            t = 0;
            int new_index = Random.Range(0, positions.Length);
            current_index = new_index == current_index ? (current_index + 1) % positions.Length : new_index;
            animator.SetTrigger("Shrink");
            score_text = $"Score: {hits}";
            myText.text = score_text;
        }
    }

    public void buttonPush() {
        if(!exposition && !started) {
            exposition = true; 
            myText.text="";
            AudioSource.PlayClipAtPoint(ben_voice_clip, Ben.transform.position, exposition_volume);
            ben_animator.SetTrigger("Talk1");
        } else if (exposition && expos_timer < 0.0) {
            started = true;
            score_text = $"Score: {hits}";
            timer_text.text = $"Time: {timer:F1}";
            myText.text = score_text;
            table_items.SetActive(true);
            button.SetActive(false);
            panel.SetActive(false);
            instruction.SetActive(false);
        }
    }
}
