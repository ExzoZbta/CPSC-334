Overview
--------
Onmetaphobia is an esp32-Processing-powered installation art relying on user interaction with a photoresistor and 2 touch sensors within an eyeball. The effects of the user interaction, however, are not immediately clear. What happens when the user places a finger on the touch sensor—or does anything happen at all? What happens when the photoresistor takes in too much light, or too little?
    - The sensor input data is taken from the ‘[module3-sensor.ino](https://github.com/ExzoZbta/CPSC-334/blob/main/module3/module3-sensor.ino)**’** file
    - The output is displayed by the ‘[onmetaphobia.pde](https://github.com/ExzoZbta/CPSC-334/blob/main/module3/eyes-processing/onmetaphobia.pde)’ file

    Description of 'Onmetaphobia'
    ------------------------------
    - Upon running, you are greeted with an eye in the center of the screen.
        - The eye is randomly looking around. It might look up at you, straight at you, or beside you. The independent pupil movement is simulated using Perlin noise.
    - There is a **photoresistor** within the pupil of the enclosure.
        - The more light it senses, the more the pupil of an eye on the screen shrinks (max 4095).
        - The less light it senses, the more the pupil of an eye dilates (min 0).
    - “Element of the “unseen effect:”
        - One of the ****************touch sensors**************** does not immediately cause anything when the user touches it. The user needs to keep their finger on the sensor for at least 3 seconds for another eye to spawn.
            - Newly spawned eyes will typically be of varying size, as long as they can fit within the window. This also means that, eventually, some of the eyes might be the same size if that is the only way more eyes can fit within the screen.
            - A maximum of 20 eyes can appear.
        - Touching **both sensors** results in blood drops flowing out of the eyes until the sensors no longer recognize the user touching both of them simultaneously
            - This is not exactly intuitive to the user as touching the 2nd sensor does not cause anything.
    - “Element of the “lack of consequence/control:”
        - The user can never stop the eyes from staring. The pupils may be manipulated, but, no matter what, their gazes will perpetually remain.
            
            [See 1st bullet point under ‘Challenges’ for further explanation]
        

## Creative Process

---

### Why?

- I wanted to explore the representation of the feelings of uncertainty and uneasiness. When a person approaches this installation for the first time, without any experience or knowledge of what they are viewing, they are stuck with a virtual eye looking at and around them. They might be curious about the enclosure in front of them. They might want to explore it. “What might happen when I touch this thing coming out of the top of the eye? What happens if I hold onto this thing for a long time? If I move around with the eye, will anything happen to the eye on the screen?” These are the questions I want the user to have. This installation prompts the user to employ their intuition and explore the unknown—while the unknown ceaselessly stares at them.
    
    [See the 1st bullet point under ‘Challenges’ below, for an explanation of how this project came about]
    

## ‘Onmetaphobia’ In Action

---

### Challenges

Coming up with an overall concept and approach:

- For a painfully long time, I could not come up with an idea for this module. The “unseen effect” condition plagued me as I thought of wacky ideas, such as a hat or a box depicting a prison cell with piezoelectric sensors within the bars. I wanted something less obviously interactive to challenge the user to explore my installation—to challenge their curiosity. I thought about my roots, for a bit. When I started taking art classes in my sophomore year (when I switched to CPAR), most of my work centered around some emotion/feeling intimately related to humans. Fear, dread, sadness, anxiousness, struggle, and even curiosity—for some reason, I enjoyed exploring these concepts. How could I translate a couple of these emotions/feelings to this module, though? Then, it finally came to me. Eyes. The unnerving feeling of something persistently staring at you. I know it would be too ambitious to create a horror experience, so this final result is more of an expression of that feeling of anxiety. Regardless of the extent to which the user investigates the sensors’ functionalities, the eyes will continue to stare.

### Enclosure:

- I sought to implement some sort of irony by having the user interact with an eye object that is also staring at them. I also wanted to make the touch sensors resemble a pair of blood vessels but I couldn’t find any aluminum foil to paint over.

  ![Front image of enclosure](https://i.imgur.com/bK7zJpw.jpg)

  ![Top image of enclosure](https://i.imgur.com/QOlvPau.jpg)

  ![Image of circuitry](https://i.imgur.com/93Slzts.jpg)
