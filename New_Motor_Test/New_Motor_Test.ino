/*
* pin 2, 3 dropper
* pin 4, 5 rail
* pin 13 back light
* pin 12 camera light
* pin 11 limit switch
* 
* Calibration values
* lever delay 350ms
* RAIL::false left true right
* DROPPER::true out false in
*/

class motor {
  public:
  
    int pin1, pin2;

    motor(int pin1, int pin2) {
      this -> pin1 = pin1;
      this -> pin2 = pin2;
      pinMode(pin1, OUTPUT);
      pinMode(pin2, OUTPUT);
    }

    void stop() {
      digitalWrite(pin1, LOW);
      digitalWrite(pin2, LOW);
    }

    void rotate(int del, bool dir) {
      if (dir) {
        digitalWrite(pin1, HIGH);
        digitalWrite(pin2, LOW);
      } else {
        digitalWrite(pin1, LOW);
        digitalWrite(pin2, HIGH);
      }
      delay(del);
      stop();
    }

    void rotate(bool dir) {
      if (dir) {
        digitalWrite(pin1, HIGH);
        digitalWrite(pin2, LOW);
      } else {
        digitalWrite(pin1, LOW);
        digitalWrite(pin2, HIGH);
      }
    }
};

#define backlight 13
#define camlight 12
#define ls 11

motor dropper(2, 3), rail(4, 5);

bool state = false;

void setup() {
  pinMode(backlight, OUTPUT);
  pinMode(camlight, OUTPUT);
  pinMode(ls, INPUT_PULLUP);
  Serial.begin(9600);
}

void loop() {
  if(Serial.available()) {
    char in = Serial.read();
    if(in == '1') {
      drop(dropper, 250);
    } else if(in == '2') {
      state = !state;
    } else if(in == 'l') {
      rail.rotate(false);
    } else if(in == 'r') {
      rail.rotate(true);
    } else if(in == 's') {
      rail.stop();
    } else if(in == 'd') {
      rail.stop();
      drop(dropper, 250);
      rail.rotate(false, 500);
      delay(500);
      rail.rotate(true);
    }
  }
  digitalWrite(camlight, state);
  delay(1000);
  if(digitalRead(ls) == LOW) {
    rail.rotate(false);
  }
}

void drop(motor m, int del) {
  //best calibration delay is 180ms with 30ms less on the way back
  m.rotate(del, true);
  delay(500);
  m.rotate(del - 50, false);
}
