class Popup {
  int x, y, h, w;
  String message;
  color popupColor, messageColor;
  Button button;
  
  Popup(int x, int y, int w, int h, String message) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.message = message;
    button = null;
  }
  
  Popup(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.message = "";
    button = null;
  }
  
  void render() {
    stylePresets();
    filter(BLUR, 5);
    fill(popupColor, 128);
    rectMode(CORNER);
    textAlign(CORNER);
    rect(this.x, this.y, this.w, this.h, 30);
    fill(messageColor);
    text(message, this.x + (w / 2 - textWidth(message) / 2), this.y + 50);
    if(button != null) {
      button.render(); 
    }
  }
  
  void stylePresets() {
    stroke(popupColor);
    strokeWeight(5);
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
  
  void setButton(int x, int y, int w, int h, String label, color buttonColor, color labelColor) {
    button = new Button(this.x + x, this.y + y, w, h, label);
    button.setButtonColor(buttonColor);
    button.setLabelColor(labelColor);
  }
}
