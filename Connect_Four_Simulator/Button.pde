class Button {
  private int x, y, w, h, fontSize = 150, alpha = 150;
  private color buttonColor = color(55, 55, 55), labelColor = color(255, 255, 255);
  private String label = "";
  
  Button(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  Button(int x, int y, int w, int h, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    setLabel(label);
  }
  
  void render() {
    graphics();
    stylePresets();
    
    fill(buttonColor, alpha);
    rect(x, y, w, h, 10);
    
    fill(labelColor);
    if(label != "")
      text(label, x, y + textDescent());
  }
  
  void graphics() {
    if(mouseX >= x - (w - h) / 2 && mouseX <= x + (w - h) / 2 && mouseY >= y - h / 2 && mouseY <= y + h / 2 ||
       dist(mouseX, mouseY, x - (w - h) / 2, y) <= h / 2 || dist(mouseX, mouseY, x + (w - h) / 2, y) <= h / 2) {
      if(alpha < 200) {
        alpha += 5; 
      }
    } else {
      if(alpha > 150) {
        alpha -= 5; 
      }
    }
  }
  
  void setLabel(String label) {
    this.label = label;
    textSize(fontSize);
    while(textWidth(label) > w - h / 2) {
      //println(w - h, textWidth(label));
      fontSize --;
      textSize(fontSize);
    }
  }
  
  void setLabel(String label, int fontSize) {
    this.label = label;
    this.fontSize = fontSize;
  }
  
  void setButtonColor(color buttonColor) {
     this.buttonColor = buttonColor; 
  }
  
  void setLabelColor(color labelColor) {
    this.labelColor = labelColor; 
  }
  
  void stylePresets() {
    rectMode(CENTER);
    ellipseMode(CENTER);
    textAlign(CENTER);
    textSize(fontSize);
    stroke(buttonColor);
    strokeWeight(2);
  }
  
  boolean isPressed() {
    if(mouseX >= x - (w - h) / 2 && mouseX <= x + (w - h) / 2 && mouseY >= y - h / 2 && mouseY <= y + h / 2 ||
       dist(mouseX, mouseY, x - (w - h) / 2, y) <= h / 2 || dist(mouseX, mouseY, x + (w - h) / 2, y) <= h / 2) {
      return true;     
    } else {
      return false; 
    }
  }
}
