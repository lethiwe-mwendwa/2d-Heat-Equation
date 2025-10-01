class Rod{

   float rodLength;
   float thermalDiffusivity;
   int totalPoints;
   float deltaX;
   float deltaT;
   float r;
   
   float[] points;
  
   public Rod(float rodLength, float thermalDiffusivity, int totalPoints){
     this.rodLength = rodLength;
     this.thermalDiffusivity = thermalDiffusivity;
     this.totalPoints = totalPoints;
     
     // Δx = L / (N-1)
     deltaX = rodLength/(totalPoints-1);
     
     // Δt ≤ 0.5 × Δx² / α
     deltaT = 0.5 * ((deltaX * deltaX) / thermalDiffusivity);
     
     r = (thermalDiffusivity * deltaT)/ (deltaX * deltaX);
     
     points = new float[totalPoints];
     
     // Distribution pattern
     for (int i = 0; i < totalPoints; i++){
       float pos = i * deltaX;
       float cycle = (pos / rodLength) % 0.5;  
       points[i] = (cycle < 0.25) ? (cycle * 400) : (100 - (cycle - 0.25) * 400);
     }
   }
   
   void update(){
     float[] newPoints = new float[totalPoints];
     
     // Read phase
     for (int i = 0 ; i != totalPoints; i++){
       if( i != 0 && i != totalPoints-1){
         // Calculate phase
         newPoints[i] = points[i] + (r *( points[i-1] - ( 2 * points[i]) + points[i+1]));
       }
     }
     
     // Handle boundary
     newPoints[0] = points[0];
     newPoints[totalPoints-1] = points[totalPoints-1];
     
     // Write phase
     points = newPoints;
     
     
   }

   void display(){
     noFill();
     beginShape();
     for (int i = 0 ; i != totalPoints; i++){
       float x = (i * deltaX) + (width/2 - (totalPoints* deltaX)/2);
       
       float y = height/2 - points[i];
       
       strokeWeight(10);
       vertex(x,y);
     }
     endShape();
     strokeWeight(0);
     for (int i = 0 ; i != totalPoints; i++){
       float x = (i * deltaX) + (width/2 - (totalPoints* deltaX)/2);
       
       float y = height/2 - points[i];
       
       // Calculate & Set temperature colour
       float temp = points[i];
       float colorFactor = map(temp, 0, 100, 0, 1);
       
       color coldColor = color(0, 0, 255);    // Blue
       color hotColor = color(255, 0, 0);     // Red
       
       color pointColor = lerpColor(coldColor, hotColor, colorFactor);
       
       fill(pointColor);
       
       // Draw point
       
       ellipse(x, y, 30, 30);
       
     }
     
   }
  
}
