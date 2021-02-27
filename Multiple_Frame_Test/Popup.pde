class Popup {
  int x, y, h, w, fontSize;
  String message;
  color popupColor, messageColor;
  PApplet applet;
  Button button;

  Popup(int x, int y, int w, int h, String message, int fontSize, Button button, PApplet applet) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.applet = applet;
    this.button = button;
    this.message = message;
    this.fontSize = fontSize;
  }
  
  Popup(int x, int y, int w, int h, Button button, PApplet applet) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.applet = applet;
    this.button = button;
    this.message = message;
    this.fontSize = fontSize;
  }

  void render() {
    applet.filter(BLUR, 5);
    applet.fill(popupColor, 128);
    applet.stroke(popupColor);
    applet.strokeWeight(5);
    applet.rectMode(CENTER);
    applet.textAlign(CENTER);
    applet.rect(this.x, this.y, this.w, this.h, 30);
    if (message != null) {
      textSize(fontSize);
      applet.fill(messageColor);
      applet.text(message, this.x, this.y - h / 4);
    }
    if (button != null) {
      button.render();
    }
  }

  void setPopupColor(color popupColor) {
    this.popupColor = popupColor;
  }

  void setMessageColor(color messageColor) {
    this.messageColor = messageColor;
  }

  void setMessage(String message) {
    this.message = message;
  }

  void setMessage(String message, int fontSize) {
    this.message = message;
    this.fontSize = fontSize;
  }

  void setFontSize(int fontSize) {
    this.fontSize = fontSize;
  }
}
