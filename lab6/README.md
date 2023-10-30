# Lab 6

Used:
- 28BYJ-48 Step Motor + ULN2003 Driver board
- MG90S Micro Servo Motor

lab6.ino
--------
- Wirelessly sends ambient light sensor data from the ESP32 to laptop/RPI via UDP message over Wi-Fi
  - Connects to 'yale wireless'
  - Uses port 4200

lab6-draw.pde
-------------
- Listens for the photoresistor sensor data and fills the canvas background with shades from blue (0 min) -> pink (4095 max) depending on the value.
  - Uses port 4200
  - Also prints confirmation of the data being received

lab6-log.txt
--------------
- Shared notes and libraries between me and Darwin, especially including this Processing UDP library: https://ubaa.net/shared/processing/udp/

