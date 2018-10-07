//This is to emulate a computer background I saw on http://partiallyderivative.com/
//Launch an array of balls with random locations and random velocities.
//At each point in time, connect points that are close with a line

Ball [] balls = new Ball [1000];

int num_balls = 150;
float max_dist = 70;
int num_frames = 50;

void setup () {
  size (720, 480);
  background (150);  
  
  for (int i = 0; i < num_balls; i++) {
    balls[i] = new Ball();
    stroke (200, 0, 0);
    point (balls [i].x, balls[i].y);
    }
} 

void draw () { 
  float dist2;  //distance squared

  background (0);
  for (int i = 0; i < num_balls; i++) {
    balls[i].move();
    balls[i].show();
  }
  //if the distance between two balls is less than max_dist then draw a line
    for (int i = 0; i < num_balls; i++){
      for (int j = 0; j < num_balls; j++) {
        dist2 = (balls[i].x - balls[j].x) * (balls[i].x - balls[j].x) + 
                (balls[i].y - balls[j].y) * (balls[i].y - balls[j].y);
        if (dist2 < max_dist * max_dist) {
          stroke(155);
          line (balls[i].x, balls[i].y, balls[j].x, balls[j].y); 
        }
      }
    }
    
//  if (frameCount < num_frames){
//    saveFrame ("network-###.png");   //<>//
//  }
}

class Ball {
  float x, y;
  float vx, vy;
  float maxv = 6;
  
  Ball () {
   x = random (0, width);
   y = random (0, height);
   
   vx = random (-maxv, maxv); 
   vy = random (-maxv, maxv); 
  }
  
  void show () {
    stroke (155);
    fill (155);
    ellipse (x, y, 4, 4);
  }
  
  void move () {
    x = x + vx;
    y = y + vy;
    
    x = (x + width) % width;
    y = (y + height) % height;    
  }
}
