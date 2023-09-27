from gpiozero import Button
from signal import pause

button = Button(4)

def button_pressed():
    print("button pressed")

def button_held():
    print("button held")

def button_released():
    print("button released")

button.when_pressed = button_pressed
button.when_held = button_held
button.when_released = button_released

pause()
