Overview
--------
'The Toonish Dauber' is an esp32-Processing-powered piece of interactive kinetic art relying on user interaction with a multi-state button, a photoresistor, and 2 touch sensors.
  - In collaboration with Lucy Sun (https://github.com/lucysun118/cpsc334)

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

**Multi-state button**
  - The circuit contains a red **button**, which has 3 different states. The user can toggle between each state by alternating between the state numbers 1-3 with each button press (the state numbers are printed for user view to the Processing/Arduino IDE terminal as the program is running):
      - State 1:
          - touching and holding the **touch sensor 1 (**for at least 1 second) starts moving both **servo motors** *clockwise* until the touch sensor is no longer held. This moves the apparatus (upon which the hands are fixed onto) *clockwise*.
      - State 2:
          - touching and holding the **touch sensor 1 (**for at least 1 second) starts moving both **servo motors** *counterclockwise* until the touch sensor is no longer held. This moves the apparatus (upon which the hands are fixed onto) *counterclockwise*.
      - State 3:
          - touching and holding the **touch sensor 1** (for at least 1 second) starts moving both hands in opposite directions to prepare to clap. They keep moving outwards until the touch sensor is no longer held. Then, before the hands reset to their original position, the hands clap together.
      - Touching the **touch sensor 2** at any point (at any state) causes the **vibration motor** to start at a high vibration to alert the user (feature richness), and clears the canvas on Processing of the preexisting paint splatters. The user can then continue as before to produce the paint splatters on the screen.

**Servo motors**
- Attached to each **servo motor** is a chopstick with a stuffed latex glove (the toon hand).
    - The hands will rotate into each other relatively quickly, simulating a clapping motion.
    - When the hands collide, some combination of colors of paint will appear on the canvas.
        - The colors are determined by the amount of light recorded by the **************************photoresistor**************************
            - The larger the value = the warmer the colors
            - The smaller the value = the colder the colors

**Stepper motor**
  - Between the ************servo motors************ is a circle with a smiley face on it.
      - A **************************stepper motor************************** beneath the circle rotates it.

 **Paint splatter** 
  - The x-and-y positioning of a paint splatter is determined by 2 features:
      - The positioning of the **stepper motor** in rotation determines the x-position of a splatter
      - The y-position is determined by Perlin noise
  - The user can clear the canvas by holding one of the **touch sensors**
      - After a brief delay, a **vibration motor** in the center of the toon eyes will activate

   
  - **(Extra) Feature richness & some fun value normalization:**
      - The user can adjust the colors of the paint splatters produced on the screen by adjusting the light conditions the system (specifically, the photosensor) is exposed to. The more light that is sensed by the photosensor, the more red the paint splatters will be. The less light (darker values) sensed, the more blue the splatters will be.
      - Perlin noise: While the horizontal (x-axis) values of where the paint splatters appear on the screen is determined by the motor position (normalizing the step-count value), the y values are determined by Perlin noise and are also influenced by the motor step-count values. This produces a smoother transition between the paint splatters—ultimately a more natural/realistic effect as the user interacts with our kinetic sculpture.

  ## Creative Process

---

### Why?

- We wanted something on the more ‘artsy’ side while still being thoroughly interactive.
    - Because of this, it took a while to figure out the theme/concept of our project which has to involve at least 4 motors.
- We settled on the ‘Toonish Dauber’ after deliberating over the idea of illustrating paint splatter and immersing the user in the act of creating paint splatter.
    - Richard: the ‘Toonish’ theme derived from a video game published in 2010, called ‘Epic Mickey.’ In this game, you play as Mickey Mouse wielding a paintbrush in an action-adventure platformer.

### Feature Richness

- We chose to emphasize the user experience by implementing many different ways (photoresistor, touch sensor, multi-state button) the user has to interact with the ‘Toonish Dauber.’
    - The 3 aforementioned methods of interaction also include more depth in terms of features.
        - This is based on:
            - Time, as in how long the user interacts with a given part.
            - When the user interacts with a given part, as in what particular state according to the button.

### Challenges

1. Richard + Lucy: Implementing the stepper motor:
    - We struggled a lot in deriving some reason for including a stepper motor. We wanted a practical application, but one that would be exciting to experience for the user. The stepper just didn’t really seem to fit in the whole theme of the project that well, at first. After deliberating over how we wanted the paint splatter to appear on the canvas, as we didn’t want it to be completely random, that’s when we determined that the stepper motor could manipulate the positions of the splats.
        - The first application involved using 2 stepper motors pulling copper wire between each other, and that wire would pull the enclosure with it (back and forth). The positioning of the steppers’ rotations at a given moment would determine where a paint splatter would occur on the x-axis. We concluded this felt like a whole other project.

1. Richard: Implementing the servo motors:
    - The clapping motion itself was quite straightforward. Our struggle with the server motors was due to an attempt to demonstrate ‘wider claps’ and ‘narrow claps.’ The 2nd servo motor seemingly never wanted to move in the opposite direction of the 1st servo motor.
    - We also struggled with building a solid base for the toon hands to move on. Lots of different types of glue and methods of adhesive were used.

1. Lucy: Mapping the colors onto the range of RGB values between red (high light values received from the photosensor) and blue (low light values).
    - One of the most important challenges in transferring photoresistor values to RGB for comprehensible representation was color normalization.
        - It took rigorous calibration for us to visually associate warmth with high light values and coolness with low light values in order to achieve a smooth transition from red to blue. Accompanying paint splatters necessitated coordinated x- and y-positioning modifications.
    - We addressed this problem/proposed feature by implementing a mapping formula/algorithm that was repeatedly evaluated for user perception.
        - Our ‘Toonish Dauber’s’ actions, surrounding light, and ensuing paint splatters were all visually engagingly correlated thanks to dynamic color shifts and precise coordinate calibration. We wanted to focus on creating an overall aesthetically beautiful and intuitive user experience!

## ‘The Toonish Dauber’ In Action

---

### Enclosure:

  ![Front image of enclosure](https://i.imgur.com/tPqE8fV.jpg)

  ![Top image of enclosure](https://i.imgur.com/BX4UONe.jpg)

  ![Side image of enclosure](https://i.imgur.com/5U1UASA.jpg)

  ![Image of circuitry](https://i.imgur.com/uvjtgcr.jpg)

  ![Image of circuitry](https://i.imgur.com/JKG6jgK.jpg)
