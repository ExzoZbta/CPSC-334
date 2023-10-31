Overview
--------
'Onmetaphobia' is esp32-Processing-powered installation art relying on user interaction with a photoresistor and touch sensors within an eyeball.

  Description of 'Onmetaphobia'
  ------------------------------
  - Sensors included:
    - a photoresistor (coming out of the pupil of the enclosure)
    - 4 touch sensors (out of the left, right, top, bottom of the enclosure)

  - Upon running, you are greeted with an eye in the center of the screen.
    - The eye is randomly looking around. It might look up at you, straight at you, or beside you. The independent pupil movement is               simulated using Perlin noise.
  - There is a **photoresistor** coming out of the pupil of the enclosure.
    - The more light it senses, the more the pupil of the eye on the screen shrinks (max value: 4095)
    - The less light it senses, the more the pupil of the eye dilates (min value: 0)
