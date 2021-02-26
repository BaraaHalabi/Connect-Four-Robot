import processing.serial.*;

color bg;

int line = 0;

Com com;

void setup() {
  com = new Com("COM4", this, 9600);
  size(200, 200);
}

void draw() {
  com.run();
  if(com.ready) { 
    bg = color(0, 255, 0);
  }  else {
    bg = color(255, 0, 0);
  } 
  background(bg);
}

void keyPressed() {
  if(com.ready) {
    com.serial.write('s'); 
    println("sent");
    com.ready = false;
  }
}

/*
ARDUINO CODE
bool go = false;

void setup() {
  Serial.begin(9600);
  pinMode(12, INPUT_PULLUP);
  pinMode(13, OUTPUT);
}

void loop() {
  while(Serial.available()) {
    if(Serial.read() == 's') {
      go = true;
      digitalWrite(13, HIGH);
    }
  }
  if(digitalRead(12) == LOW && go) {
    Serial.write('e');
    digitalWrite(13, LOW);
    go = false;
  }
}
*/
