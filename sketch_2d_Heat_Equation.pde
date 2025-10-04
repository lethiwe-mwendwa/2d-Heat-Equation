Rod metalPlane = new Rod(300,0.4,500,500);
boolean locked;

void setup(){
  size(1060,720,P2D);
  
}


void draw() {
  metalPlane.update();
  
  background(51);
  metalPlane.display();
}

void mousePressed() {
  locked = true;
  metalPlane.heatUpSquareAt(mouseX,mouseY);
}

void mouseDragged() {
  if(locked) {
    metalPlane.heatUpSquareAt(mouseX,mouseY);
  }
}

void mouseReleased() {
  locked = false;
}
