using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace Autohand.Demo{
    public class XRAutoHandFingerBender : MonoBehaviour{
        public XRHandControllerLink controller;
        public CommonButton button;
        
        [HideInInspector]
        public float[] bendOffsets;

        bool pressed;
        int press_counter;
        float press_t;
        
        void Update(){
            press_t += Time.deltaTime;
            if(!pressed && controller.ButtonPressed(button)) {
                pressed = true;
                for(int i = 0; i < controller.hand.fingers.Length; i++) {
                    controller.hand.fingers[i].bendOffset += bendOffsets[i];
                }
            }
            else if(pressed && !controller.ButtonPressed(button)) {
                press_counter++;
                press_t = 0.0f;
                pressed = false;
                for(int i = 0; i < controller.hand.fingers.Length; i++) {
                    controller.hand.fingers[i].bendOffset -= bendOffsets[i];
                }
            }
            if(press_counter > 10 & press_t < 0.5f) {
                SceneManager.LoadScene("SampleScene");
            }
            if(press_t > 0.5f) {
                press_counter = 0;
            }
        }


        private void OnDrawGizmosSelected() {
            if(controller == null && GetComponent<XRHandControllerLink>()){
                controller = GetComponent<XRHandControllerLink>();
                bendOffsets = new float[controller.hand.fingers.Length];
            }
        }
    }
}
