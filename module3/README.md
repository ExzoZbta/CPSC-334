Overview
--------
'Onmetaphobia' is esp32-Processing-powered installation art relying on user interaction with a photoresistor and touch sensors within an eyeball.

  Specs of 'Onmetaphobia' project
  ------------------------------
  - Files included:
    - module3-sensor.ino
      - Allows the esp32 to connect to 'yale wireless' wifi automatically
      - Sends the sensor data to whatever device the esp32 is connected to (laptop/RPI)
    - eyes-processing (folder)
      - onmetaphobia.pde
        - Takes in the sensor data from module3-sensor
        - Displays the eyes and the output of the user interaction with the sensors onto the device's screen
      - background.jpg
        - img for the background canvas of 'onmetaphobia.pde'
       
  - Sensors included:
    - a photoresistor (coming out of the pupil of the enclosure)
    - 2 touch sensors (out of the sid of the enclosure)
   
  Description of 'Onmetaphobia' project
  --------------------------------------
  - Upon running, you are greeted with an eye in the center of the screen.
    - The eye is randomly looking around. It might look up at you, straight at you, or beside you. The independent pupil movement is               simulated using Perlin noise.
  - There is a **photoresistor** coming out of the pupil of the enclosure.
    - The more light it senses, the more the pupil of the eye on the screen shrinks (max value: 4095)
    - The less light it senses, the more the pupil of the eye dilates (min value: 0)
   
  - “Element of the “unseen effect:”
    - One of the ****************touch sensors**************** does not immediately cause anything when the user touches it. The user needs        to keep their finger on the sensor for at least 3 seconds for another eye to spawn.
        - Newly spawned eyes will typically be of varying size, as long as they can fit within the window. This also means that, eventually,           some of the eyes might be the same size if that is the only way more eyes can fit within the screen.
        - A maximum of 20 eyes can appear.
    - Touching **both sensors** results in blood drops flowing out of the eyes until the sensors no longer recognize the user touching both        of them simultaneously
        - This is not exactly intuitive to the user as touching the 2nd sensor does not cause anything.
- “Element of the “lack of consequence/control:”
    - The user can never stop the eyes from staring. The pupils may be manipulated, but, no matter what, their gazes will perpetually remain.
