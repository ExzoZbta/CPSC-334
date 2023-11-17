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
