class Rod{

   float rodLength;
   float thermalDiffusivity;
   int columnTotal;
   int rowTotal;
   float deltaX;
   float deltaY;
   float deltaT;
   float rX;
   float rY;
   
   float[][] squares;
  
   public Rod(float rodLength, float thermalDiffusivity, int columnTotal, int rowTotal){
     this.rodLength = rodLength;
     this.thermalDiffusivity = thermalDiffusivity;
     this.columnTotal = columnTotal;
     this.rowTotal = rowTotal;
     
     // Δx = L / (xN-1)
     deltaX = rodLength/(rowTotal-1);
     
     // Δy = L / (yN-1)
     deltaY = rodLength/(columnTotal-1);
     
     // Δt ≤ (Δx² * Δy²) / (2α(Δx² + Δy²))
     deltaT = ((deltaX * deltaX) * (deltaY * deltaY)) / (2 * thermalDiffusivity * ((deltaX * deltaX) + (deltaY * deltaY)));
     
     // α(Δt/Δx²)
     rX = (thermalDiffusivity * deltaT)/ (deltaX * deltaX);
     
     // α(Δt/Δy²)
     rY = (thermalDiffusivity * deltaT)/ (deltaY * deltaY);
     
     squares = new float[rowTotal][columnTotal];
     
     // Distribution pattern
     for (int i = 0; i < rowTotal; i++){
       for (int j = 0; j < columnTotal; j++){
         if( i != 0 && i != rowTotal-1 && j != 0 && j != columnTotal-1){
           squares[i][j] = (float)(Math.random() * 180);
         }else{
           squares[i][j] = 0;
         }
       }
     }
     // Random heat spots
     for (int n = 0; n < 5; n++) {
       int x = (int)random(1, rowTotal - 1);
       int y = (int)random(1, columnTotal - 1);
       squares[x][y] = 100;
     }
     
   }
   
   void update(){
     float[][] newSquares = new float[rowTotal][columnTotal];
     
     // Read phase
     for (int i = 0; i < rowTotal; i++){
       for (int j = 0; j < columnTotal; j++){
         
         // If it is not a X edge
         if( i != 0 && i != rowTotal-1 && j != 0 && j != columnTotal-1){
           // Calculate phase
           newSquares[i][j] = squares[i][j] + (rX *( squares[i-1][j] - ( 2 * squares[i][j]) + squares[i+1][j]))  + (rY *( squares[i][j-1] - ( 2 * squares[i][j]) + squares[i][j+1]));
         }else{
           // Handle passing on old boundary values
           newSquares[i][j] = squares[i][j];
         }
       }
     }
     
     // Write phase
     squares = newSquares;
     
     
   }

   void display(){
     noStroke();
     for (int i = 0; i < rowTotal; i++){
       
       for (int j = 0; j < columnTotal; j++){
         // Set Square Location
         float x = (i * deltaX) + (width/2 - (rowTotal* deltaX)/2);
         float y = (j * deltaY) + (height/2 - (columnTotal* deltaY)/2);
         
         // Calculate & Set temperature colour
         float temp = squares[i][j];
         float colorFactor = map(temp, 0, 100, 0, 1);
         color coldColor = color(0, 0, 255);    // Blue
         color hotColor = color(255, 0, 0);     // Red
         color squareColor = lerpColor(coldColor, hotColor, colorFactor);
         
         fill(squareColor);
         
         // Draw Square
         rect(x, y, deltaX, deltaY);
         
       }
     }
     
   }
  
}
