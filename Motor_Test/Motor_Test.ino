/*
 * lever delay 350ms
 * RAIL::true left false right
 * DROPPER::false out true in
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

motor m1(2, 3), m2(4, 5);

void setup() {
  Serial.begin(9600);
  pinMode(13, INPUT_PULLUP);
  //m1.rotate(true);
}

void loop() {
//  m1.rotate(true);
//  while(digitalRead(13) == LOW) {
//    Serial.println("stuck");
//    m1.stop();
//  }
  
  if(Serial.available() > 0) {
    char data = Serial.read();
    if(data == 's') {
      m1.stop();
      delay(500);
      drop(m2, 350);
      m1.rotate(500, true);
      m1.rotate(false);
    } else if(data == 'b') {
      m1.rotate(true);
    }
  }

//  drop(m2, 350);
//  while(1);
}

void drop(motor m, int del) {
  m.rotate(del, false);
  delay(500);
  m.rotate(del - 50, true);
}
