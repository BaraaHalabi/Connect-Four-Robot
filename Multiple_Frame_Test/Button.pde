class Button {
  private int x, y, w, h, fontSize, alpha;
  private color buttonColor, labelColor;
  private String label;
  PApplet applet;
  
  Button(int x, int y, int w, int h, PApplet applet) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    alpha = 150;
    this.applet = applet;
  }
  
  void render() {
    graphics();
    
    applet.rectMode(CENTER);
    applet.ellipseMode(CENTER);
    applet.textAlign(CENTER);
    applet.stroke(buttonColor);
    applet.strokeWeight(2);
    
    applet.fill(buttonColor, alpha);
    applet.rect(x, y, w, h, 10);
    
    if(label != null) {
      applet.fill(labelColor);
      applet.textSize(fontSize);
      applet.text(label, x, y + textDescent());
    }
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
  }
  
  void setLabel(String label, int fontSize) {
    this.fontSize = fontSize;
    this.label = label;
  }
  
  void setButtonColor(color buttonColor) {
     this.buttonColor = buttonColor; 
  }
  
  void setLabelColor(color labelColor) {
    this.labelColor = labelColor; 
  }
  
  boolean isPressed() {
    if(applet.mouseX >= x - (w - h) / 2 && applet.mouseX <= x + (w - h) / 2 && applet.mouseY >= y - h / 2 && applet.mouseY <= y + h / 2 ||
       dist(applet.mouseX, applet.mouseY, x - (w - h) / 2, y) <= h / 2 || dist(applet.mouseX, applet.mouseY, x + (w - h) / 2, y) <= h / 2) {
      return true;     
    } else {
      return false; 
    }
  }
}
