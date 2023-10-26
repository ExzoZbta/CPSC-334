#define PHOTORESISTOR_PIN 35
#include <WebServer.h>
#include <WiFi.h>
#include <WiFiUdp.h>

const char* ssid = "yale wireless";
const char* password = "";
WiFiUDP Udp;
unsigned int localUdpPort = 4200;  //  port to listen on
char incomingPacket[255];  // buffer for incoming packets

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
  Udp.begin(localUdpPort);
  Serial.printf("Now listening at IP %s, UDP port %d\n", WiFi.localIP().toString().c_str(), localUdpPort);

}


void loop() {
  int light_val = analogRead(PHOTORESISTOR_PIN);

  Serial.println(String("Light: ") + light_val);

  // once we know where we got the inital packet from, send data back to that IP address and port
  Udp.beginPacket("172.29.32.91", 4200);
  // Just test touch pin - Touch0 is T0 which is on GPIO 4.
  Udp.printf(String(touchRead(T0)).c_str(),2);
  Udp.endPacket();
  delay(1000);

}
