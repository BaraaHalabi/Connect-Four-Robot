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
    
    w += 10; h += 10;
    fill(buttonColor, alpha);
    ellipse(x - (w - h) / 2, y, h, h);
    ellipse(x + (w - h) / 2, y, h, h);
    fill(255); //this should follow the background color
    rect(x - (w - h) / 2.0 + h / 4.0, y, h / 2, h);
    rect(x + (w - h) / 2.0 - h / 4.0, y, h / 2, h);
    fill(buttonColor, alpha);
    rect(x, y, w - h, h);
    w -= 10; h -= 10;
    
    w += 5; h += 5;
    fill(255); //this should follow the background color
    ellipse(x - (w - h) / 2, y, h, h);
    ellipse(x + (w - h) / 2, y, h, h);
    rect(x, y, w - h, h);
    w -= 5; h -= 5;
    
    fill(buttonColor, alpha);
    ellipse(x - (w - h) / 2, y, h, h);
    ellipse(x + (w - h) / 2, y, h, h);
    fill(255); //this should follow the background color
    rect(x - (w - h) / 2.0 + h / 4.0, y, h / 2, h);
    rect(x + (w - h) / 2.0 - h / 4.0, y, h / 2, h);
    fill(buttonColor, alpha);
    rect(x, y, w - h, h);
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
    noStroke();
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
