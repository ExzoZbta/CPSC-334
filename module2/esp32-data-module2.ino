#define BUTTON_PIN 23
#define SWITCH_PIN 17

#define VRX_PIN 26 // ESP32 pin GPIO36 (ADC0) connected to VRX pin
#define VRY_PIN 25 // ESP32 pin GPIO39 (ADC0) connected to VRY pin


void setup() {
  Serial.begin(9600);
  pinMode(BUTTON_PIN, INPUT_PULLUP);
  pinMode(SWITCH_PIN, INPUT_PULLUP);
}

void loop() {
  int vrx_value = analogRead(VRX_PIN);
  int vry_value = analogRead(VRY_PIN);

  Serial.println(String("VRX: ") + vrx_value);
  Serial.println(String("VRY: ") + vry_value);
  Serial.println(String("SWITCH: ") + !digitalRead(SWITCH_PIN));
  Serial.println(String("BUTTON: ") + !digitalRead(BUTTON_PIN));

  delay(200);

}
