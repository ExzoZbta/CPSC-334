#include <Stepper.h>
#include <Servo.h>


const int stepsPerRevolution = 2048;  // change this to fit the number of steps per revolution

// ULN2003 Motor Driver Pins
#define IN1 19
#define IN2 18
#define IN3 5
#define IN4 17

#define SERVO_PIN 4

// initialize the stepper library
Stepper myStepper(stepsPerRevolution, IN1, IN3, IN2, IN4);

Servo servoMotor;

void setup() {
  // set the speed at 5 rpm
  myStepper.setSpeed(10);
  servoMotor.attach(SERVO_PIN);  // attaches the servo on ESP32 pin

  // initialize the serial port
  Serial.begin(115200);
}

int pos = 0;
int count = 0;

void loop() {

  Serial.println("clockwise");
  myStepper.step(stepsPerRevolution);
 
  // every time stepper does a full 360, increment servo by 10 degrees
  for (count = 0; count < 10; count += 1) {

    servoMotor.write(pos);
    pos = pos + 1;
    delay(15);
  }

  // rotates from 180 degrees to 0 degrees after 18 10degrees rotations
  if (pos >= 180) {
    for (pos = 180; pos >= 0; pos -= 1) {
      servoMotor.write(pos);
      delay(15); 
    }
  }
  delay(100);
}
