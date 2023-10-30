#include "WiFi.h"
#include <WiFiUdp.h>

#define PHOTORESISTOR_PIN 35
#define ssid "yale wireless" // change depending on wifi
#define password "" // change depending on wifi

// touch pin - Touch0 is T0 which is on GPIO 4.
#define TOUCH_PIN 4

const int touch_threshold = 35;
int touch_value;

WiFiUDP Udp;

void initWiFi() {
  
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
  
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
  }
  Serial.println(WiFi.localIP());
}

void setup() {
  Serial.begin(9600);
  delay(1000); // serial monitor period

  pinMode(PHOTORESISTOR_PIN, INPUT);
  initWiFi();
}

void loop() {

  int light_val = analogRead(PHOTORESISTOR_PIN);
  int touch_val = touchRead(TOUCH_PIN);
  
  Serial.println(String("Touch Value: ") + touch_val);  // get value of Touch 0 pin = GPIO 4

  if (touch_val < touch_threshold) {
    Serial.println("Wake The Eyes");
  }
  else {
    Serial.println("The Eyes are Calm");
  }

  // int beginPkt = Udp.beginPacket("172.29.32.91", 4200); // ip address changes for some reason

  Serial.println(String("Light: ") + light_val);

  // Serial.println(String("Begin Packet: ") + beginPkt);

  // Create separate UDP packets for light and touch values
  Udp.beginPacket("172.29.32.91", 4200); // Change the IP address accordingly
  Udp.print("Light: ");
  Udp.println(light_val);
  Udp.endPacket();

  Udp.beginPacket("172.29.32.91", 4200); // Change the IP address accordingly
  Udp.print("Touch Value: ");
  Udp.println(touch_val);
  Udp.endPacket();
  
  // int pkt = Udp.endPacket();
  // Serial.println(String("Sent Packet: ") + pkt);

  delay(500);
}
