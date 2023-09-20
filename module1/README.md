Overview
--------
blobs is a p5.js sketch that creates two animated, colored blobs (referred to as "blob1" and "blob2") on a canvas. Each blob is made up of multiple nodes that move around, leaving a colored trail behind. The blobs bounce off the edges of the canvas when colliding with its boundaries, adding an element of unpredictability.

  Description of blobs
  --------------------
  - The blobs are composed of multiple nodes connected by curves, and these nodes move based on sinusoidal functions, angles, and frequencies.
  - "blob1" and "blob2" spawn randomly on the canvas, move in different directions, and (can) move at different speeds. 
  - the blobs' colors are generated randomly
  - they will pass through each other


Usage - download the module1 folder and double-click on index.html
-----
- index.html will launch the program onto a web browser. Feel free to hit F11 to make the window fullscreen.
- A new image will be created after every loading of the program.
- Every time you resize the window in which the program is loaded, the lines generated by the blobs will begin anew——providing a fresh canvas for the blobs to glide upon.
- To generate new blobs, refresh the browser (click on the refresh button or hit F5 on your keyboard)