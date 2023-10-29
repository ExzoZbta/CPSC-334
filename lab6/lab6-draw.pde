import hypermedia.net.*;

UDP udp;

PGraphics window;

void setup() {
  udp = new UDP(this, 4200);
  udp.log(true);
  udp.listen(true);
  
  size(500, 500);
  window = createGraphics(width, height);
}

float background_color = 1.0;

void draw() {
  window.beginDraw();
  window.background(66, 135, 245);
  window.fill(189, 116, 237, background_color);
  window.square(0, 0, width);
  window.endDraw();
  
  image(window, 0, 0);
  println(background_color);
}


void receive( byte[] data, String ip, int port ) {
  
  String message = new String(data);
  background_color = int(message)/4095.0*255;
  
  println( "receive: \""+message+"\" from "+ip+" on port "+port );
}
