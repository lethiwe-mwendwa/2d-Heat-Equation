Rod metalBar = new Rod(800,5,200);

void setup(){
  size(1060,720,P2D);
  
}


void draw() {
  metalBar.update();
  
  background(51);
  metalBar.display();
}
