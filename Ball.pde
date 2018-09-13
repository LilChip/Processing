class Ball {
  int x, y;
  int rad;
  int r = 28;
  int g = int (random(100, 255));
  int b = 26;
  
  Ball () {
   x = int (random (0, width));
   y = int (random (0, height));
   rad = int (random (min_r, max_r));       
  }
  
  void show () {
    stroke (0);
    fill (r, g, b);
    ellipse (x, y, 2*rad, 2*rad);
  } 

  boolean isOverlap (int i) {
    boolean overlap = false;
    //    println ("In isOverlap ", i, b.x, b.y, b.rad);
    for (int j = 0; j < num_balls; j++) { 
      if (j!=i) {
        //println (i, j, num_balls, balls[j].x, balls[j].y, balls[j].rad);
        float d = dist(balls[j].x, balls[j].y, x, y);
        if (d < (balls[j].rad + rad + space)) { 
          overlap = true;
          break;
        }
      }
    } 
    return overlap;
  }
}