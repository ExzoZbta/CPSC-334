Overview
--------
'Emotion Waves' is an esp32-interactive Processing sketch that allows you to express your emotions by using a joystick to fiddle around with a Perlin noise-generated wave. The user can use a button to select the emotion they've most prominently felt recently (out of a small list).
  - The user input data is taken from the ‘**[esp32-data-module2.ino](https://github.com/ExzoZbta/CPSC-334/blob/main/module2/esp32-data-module2.ino)’** file.

    Description of 'Emotion Waves'
    ------------------------------
    - Upon running, you are greeted with a screen asking "Select the most prominent emotion you've felt recently."
    - Inside a colored box, lists a particular emotion: "Sadness" "Joy" "Anger" "Surprise"
      - Each emotion has its corresponding color (from blue → yellow → red → orange. The box accompanying the emotion also has the same color.
      - The user can navigate through the list by pressing the **button**.
    - When you have decided on the emotion, you can flick the **lever** on to bring up a screen with the appropriately colored Perlin noise-generated wave on a black background.
    - On this screen, the user can manipulate the x-dimensions and y-dimensions of the Perlin noise-generated wave using the **joystick**. The behavior of the manipulation of the wave differs depending on which emotion was selected.
      - The wave moves slightly on its own without user input.
    - The user can return to the starting screen and start anew by flicking the **lever** off.
      - Note: returning to the screen is unnecessary—you can use the button to change the emotion while on the wave screen.

## Creative Process

---

### Why?

- At first, I didn’t know what I wanted to do, at all. I wanted to make a fart sound generator box, but then (thanks to Scott) I realized that project seems more suited to the wireless module.
- My mind was still thinking about generative art, so I decided to continue exploring that realm.
- After spending *****A LOT* of time ********properly******** hooking up the esp32 input data into the Processing sketch (more on this in the ‘Challenges’ section), I decided to completely change my original idea.
    - **My original idea**: allow the user to control the procedural generation of a 3D sculpture. The joystick would control the size and intensity of the generation. There would be certain rules on size/intensity depending on what emotion the user chose.
    - I slowly (and regrettably) realized that this was taking wayyy too long to figure out.
- I still wanted to go down the generative/procedural path. After some googling on algorithms, and thanks to Darwin for the introduction to Perlin noise, I decided on using Perlin noise to generate something controllable by the user.
    - Decided on a ‘wave-like’ generation…perhaps due to the influence of ‘blobs.’ When I was testing it out, I was quite pleased and very relieved. It seemed to represent **my objective**: to give the user an outlet to play with emotion—to potentially think about the emotion they chose while fiddling around with its representation on a screen.

## ‘🌊 Emotion Waves 🌊’ In Action

---

- The project consists of 2 files: **[module2.pde](https://github.com/ExzoZbta/CPSC-334/blob/main/module2/module2.pde)** (the Processing sketch) + **[esp32-data-module2.ino](https://github.com/ExzoZbta/CPSC-334/blob/main/module2/esp32-data-module2.ino)** (the esp32 data uploader)

### Challenges

Reading in another source of input besides the button:

- I started by reading the values of the button pressing. Pretty simple…until I attempted to read the values of the switch flicking. My initial approach to reading in serial events apparently could only account for one source of serial data at a time.

Reading in the joystick values:

- I technically never really solved my problem since my final idea did not require me to find a solution, but I was trying to figure out a way for the user to draw on the canvas with the joystick. Regardless of what I did, the joystick ‘cursor’ would always return to its default position. For example, if I moved the joystick to x value 100 and y value 2000, the joystick would instantly return to x value 2800 and y value 2800 as soon as I let go of it. I couldn’t work out a solution so I decided to abandon the idea I had for that functionality.

—

### Enclosure:

- A cardboard box with a flap for the top (for easy removal of the esp32 + circuit)
- The positions of the joystick and the button are slightly angled toward the direction of where the fingers of the right hand would rest…ergonomics or something
    - The lever juts out from the side of the box, intended to be used by the left-hand
 
  ![Front image of enclosure](https://i.imgur.com/BFWQ2vY.jpg)

  ![Top image of enclosure](https://i.imgur.com/TLBvFaR.jpg)

  ![Image of circuitry](https://i.imgur.com/SDgusv7.jpg)

## esp32 Usage:

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
              - A singular press of the button will switch to the next emotion in the list of emotions on the emotion 
              (starting screen)
              - The user can hold down the button to quickly go through the list (just a possibility)
              - On the Perlin noise-generated wave screen, pressing the button can change the emotion 
              (thus, the color of the wave) without having to go back to the emotion screen 
