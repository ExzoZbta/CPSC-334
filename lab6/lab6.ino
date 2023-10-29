#include "WiFi.h"
#include <WiFiUdp.h>


#define PHOTORESISTOR_PIN 35
#define ssid "yale wireless" // change depending on wifi
#define password "" // change depending on wifi

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
  pinMode(PHOTORESISTOR_PIN, INPUT);

  initWiFi();

}

void loop() {

  int light_val = analogRead(PHOTORESISTOR_PIN);
  int beginPkt = Udp.beginPacket("172.29.32.91", 4200); // ip address changes for some reason
  
  Serial.println(String("Light: ") + light_val);

  // Serial.println(String("Begin Packet: ") + beginPkt);

  String msg = String(analogRead(PHOTORESISTOR_PIN));
  Udp.printf(msg.c_str());

  int pkt = Udp.endPacket();
  // Serial.println(String("Sent Packet: ") + pkt);

  delay(500);
}
