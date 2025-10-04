Rod metalBar = new Rod(700,0.5,100,100);

void setup(){
  size(1060,720,P2D);
  
}


void draw() {
  metalBar.update();
  
  background(51);
  metalBar.display();
}
