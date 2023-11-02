#include "WiFi.h"
#include <WiFiUdp.h>

#define PHOTORESISTOR_PIN 35
#define ssid "yale wireless" // change depending on wifi
#define password "" // change depending on wifi

// touch pin - Touch0 is T0 which is on GPIO 4.
#define TOUCH_PIN 4
// touch pin #2 - Touch2 is T2 which is on GPIO 2.
#define TOUCH2_PIN 2

const int touch_threshold = 35;

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
  int touch2_val = touchRead(TOUCH2_PIN);
  
  Serial.println(String("Touch Value: ") + touch_val);  // get value of Touch 0 pin = GPIO 4
  Serial.println(String("Touch #2 Value: ") + touch2_val);  // get value of Touch 2 pin = GPIO 2


  if (touch_val < touch_threshold) {
    Serial.println("Wake The Eyes");
  }
  else {
    Serial.println("The Eyes are Calm");
  }

  if (touch2_val < touch_threshold) {
    Serial.println("The Eyes Cry");
  }
  else {
    Serial.println("The Eyes Rest");
  }

  // int beginPkt = Udp.beginPacket("172.29.32.91", 4200); // ip address changes for some reason

  Serial.println(String("Light: ") + light_val);

  // Serial.println(String("Begin Packet: ") + beginPkt);

  // Create separate UDP packets for light and touch values
  Udp.beginPacket("172.29.132.18", 4200); // Change the IP address accordingly
  Udp.print("Light: ");
  Udp.println(light_val);
  Udp.endPacket();

  Udp.beginPacket("172.29.132.18", 4200); // Change the IP address accordingly
  Udp.print("Touch Value: ");
  Udp.println(touch_val);
  Udp.endPacket();

  Udp.beginPacket("172.29.132.18", 4200); // Change the IP address accordingly
  Udp.print("Touch#2 Value: ");
  Udp.println(touch2_val);
  Udp.endPacket();
  
  // int pkt = Udp.endPacket();
  // Serial.println(String("Sent Packet: ") + pkt);

  delay(500);
}
