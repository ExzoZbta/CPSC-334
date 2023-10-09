Overview
--------
'Emotion Waves' is an esp32-interactive Processing sketch that allows you to express your emotions by using a joystick to fiddle around with a Perlin noise-generated wave. The user can use a button to select the emotion they've most prominently felt recently (out of a small list).

  Description of 'Emotion Waves'
  ------------------------------
  - The user is greeted with a screen asking "Select the most prominent emotion you've felt recently."
  - The list of emotions includes: "Sadness" "Joy" "Anger" "Surprise"
  - When the user is satisfied with their choice, flicking the lever on brings up a screen with the appropriately colored Perlin noise-generated wave on a black background.
  - On this screen, the user can manipulate the wave using the joystick. The wave moves on its own without user input.
  - The wave moves on its own without user input.    
  - The user can return to the starting screen and start anew by flicking the lever off.

esp32 Usage:
    Joystick Usage (esp32)
    --------------
    Using the joystick:
              - joystick's x-value increments/decrements the x dimension for the Perlin noise
              - joystick's y-value increments/decrements the y dimension for the Perlin noise
              - the Perlin noise dimensions will return to their default values if the joystick is no longer moving
    
    Lever Usage (esp32)
    --------------
    Using the lever:
              - Lever should be in the off (0) position before the program starts.
              - To load up the Perlin noise-generated wave screen, flick the lever on (1).
              - To return to the emotion selection screen, flick the lever back off (0).
    
    Button Usage (esp32)
    --------------
    Using the button:
              - A singular press of the button will switch to the next emotion in the list of emotions on the emotion (starting screen)
              - The user can hold down the button to quickly go through the list (just a possibility)
              - On the Perlin noise-generated wave screen, pressing the button can change the emotion (thus, the color of the wave) without having to go back to the emotion screen 
 
For Raspberry Pi:
- 

