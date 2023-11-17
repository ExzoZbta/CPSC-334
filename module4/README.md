Overview
--------
'The Toonish Dauber' is an esp32-Processing-powered piece of interactive kinetic art relying on user interaction with a multi-state button, a photoresistor, and 2 touch sensors.

  Specs of 'The Toonish Dauber' project
  ------------------------------
  - Files included:
    - module4-data.ino
      - Contains functionality for the movement of the servo and stepper motors, the photoresistor, the 2 touch sensors, and the button
      - Sends the sensor/motor data to whatever device the esp32 is connected to (laptop/RPI)
    - splatter-canvas.pde
      - Takes in photoresistor + motor input from the ESP32
        - Whenever the servo motors reach a certain position, a splat of paint appears on the Processing canvas. The x-value of the splat of paint's position is determined by the current position of the stepper motor, and the y-value is determined by Perlin noise.  
       
  - Sensors/motors included:
    - a photoresistor 
    - 2 touch sensors
    - a button
    - a vibration motor
    - 2 servo motors
    - 1 stepper motor
   
  Description of 'The Toonish Dauber' project
  --------------------------------------
  - Upon running, you are greeted with a blank canvas on your screen

  - The circuit contains a red **button**, which has 3 different states. The user can toggle between each state by alternating between the state numbers 1-3 with each button press (the state numbers are printed for user view to the Processing/Arduino IDE terminal as the program is running):
      - State 1:
          - touching and holding the **touch sensor 1 (**for at least 1 second) starts moving both **servo motors** *clockwise* until the touch sensor is no longer held. This moves the apparatus (upon which the hands are fixed onto) *clockwise*.
      - State 2:
          - touching and holding the **touch sensor 1 (**for at least 1 second) starts moving both **servo motors** *counterclockwise* until the touch sensor is no longer held. This moves the apparatus (upon which the hands are fixed onto) *counterclockwise*.
      - State 3:
          - touching and holding the **touch sensor 1** (for at least 1 second) starts moving both hands in opposite directions to prepare to clap. They keep moving outwards until the touch sensor is no longer held. Then, before the hands reset to their original position, the hands clap together.
      - Touching the **touch sensor 2** at any point (at any state) causes the **vibration motor** to start at a high vibration to alert the user (feature richness), and clears the canvas on Processing of the preexisting paint splatters. The user can then continue as before to produce the paint splatters on the screen.
   
- Attached to each **servo motor** is a chopstick with a stuffed latex glove (the toon hand).
    - The hands will rotate into each other relatively quickly, simulating a clapping motion.
    - When the hands collide, some combination of colors of paint will appear on the canvas.
        - The colors are determined by the amount of light recorded by the **************************photoresistor**************************
            - The larger the value = the warmer the colors
            - The smaller the value = the colder the colors

  - Between the ************servo motors************ is a circle with a smiley face on it.
      - A **************************stepper motor************************** beneath the circle rotates it.
  
  - The x-and-y positioning of a paint splatter is determined by 2 features:
      - The positioning of the **stepper motor** in rotation determines the x-position of a splatter
      - The y-position is determined by Perlin noise
  - The user can clear the canvas by holding one of the **touch sensors**
      - After a brief delay, a **vibration motor** in the center of the toon eyes will activate
   
  - **(Extra) Feature richness & some fun value normalization:**
      - The user can adjust the colors of the paint splatters produced on the screen by adjusting the light conditions the system (specifically, the photosensor) is exposed to. The more light that is sensed by the photosensor, the more red the paint splatters will be. The less light (darker values) sensed, the more blue the splatters will be.
      - Perlin noise: While the horizontal (x-axis) values of where the paint splatters appear on the screen is determined by the motor position (normalizing the step-count value), the y values are determined by Perlin noise and are also influenced by the motor step-count values. This produces a smoother transition between the paint splatters—ultimately a more natural/realistic effect as the user interacts with our kinetic sculpture.
