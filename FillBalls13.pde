//Fill array of balls so that none overlap
//Then they adjust their position to minimize "Energy", defined as 1/r**2
//You can "pop" the balls with the mouse and watch the array adjust to the opening
//Changing to toroidal boundary conditions 
//Moved the overlap test to a method within the Ball class
//Simplified code by using "dist" function.
//Cleaned up code.

Ball [] balls = new Ball [700];

int space = 3;  //minimum space between balls
int num_balls = 0;
int min_r = 4;
int max_r = 30;

void setup () {
  int max_attempts = 25000;
  Ball btemp = new Ball();

  size (1920, 1080);
  background (176, 176, 255);

  balls[0] = new Ball();
  // println ("0 ", num_balls, balls[0].x, balls[0].y, balls[0].rad);

  num_balls++;

  for (int i = 0; i < max_attempts && num_balls < (balls.length - 1); i++) {
    btemp = new Ball();
    //    println (i, num_balls, btemp.x, btemp.y, btemp.rad);
    if (!btemp.isOverlap (num_balls)) {
      balls[num_balls] = new Ball();
      balls[num_balls] = btemp;
      num_balls++;
    }
  }
} 

void draw () { 
  float [] [] E = new float [3] [3];  //Surface of total energy one unit around point x,y.  Centerpoint is [1][1]
  float E_min;
  int dir_min_x, dir_min_y;
  int x, y;
  float E_scale;
  int x_dist, y_dist;
  Ball b = new Ball ();

  E_scale = width * height;

  for (int i = 0; i < num_balls; i++) {

    // zero Energy array
    for (int m = 0; m < 3; m++) {
      for (int n = 0; n < 3; n++) {
        E[m][n] = 0;
      }
    }

    //find total energy for center point and for adjacent points
    for (int j = 0; j < num_balls; j++) {
      if (i != j) {
        for (int m = 0; m < 3; m++) {      
          for (int n = 0; n < 3; n++) {
            x_dist = min ((balls[i].x+n-1 - balls[j].x + width)  % width, (balls[j].x - (balls[i].x+n-1) + width) % width);
            y_dist = min ((balls[i].y+m-1 - balls[j].y + height) % height, (balls[j].y - (balls[i].y+m-1) + height) % height);
            E[m][n] = E[m][n] + E_scale*balls[i].rad*balls[j].rad/(x_dist*x_dist + y_dist*y_dist);
          }
        }
      }
    }

    //find direction that lowers energy most
    E_min = E[1][1];
    dir_min_x = 0;
    dir_min_y = 0;

    for (int m = 0; m < 3; m++) {
      for (int n = 0; n < 3; n++) {
        if (E[m][n] < E_min) {
          dir_min_x = n-1;
          dir_min_y = m-1;
          E_min = E[m][n];
        }
      }
    }
    //    println (dir_min_x, dir_min_x);

    b.x = (balls[i].x + dir_min_x + width) % width;
    b.y = (balls[i].y + dir_min_y + height) % height;
    b.rad = balls[i].rad;

    //test if moving ball there is still valid location -- no overlap    
    if (!b.isOverlap (i)) {
      balls[i].x = b.x;
      balls[i].y = b.y;
    }
  }

  //refresh screen with new ball locations
  background (176, 176, 255);
  for (int i = 0; i < num_balls; i++) {
    balls[i].show();
    //textSize (12);
    //fill (0);
    //text(str(i), balls[i].x, balls[i].y);
  }
  saveFrame ("output/FillBalls10_####.png");
}

void mousePressed() {
  //if you click on a balloon, it "pops" and disappears
  for (int i = 0; i < num_balls; i++) {
    float d = dist (balls[i].x, balls[i].y, mouseX, mouseY);
    if (d < balls[i].rad) {
      for (int j = i; j < num_balls-1; j++) {
        balls[j] = balls[j+1];
      }
      num_balls = num_balls -1;
    }
  }
}

void mouseDragged() {
  //if you click on a balloon, it "pops" and disappears
  for (int i = 0; i < num_balls; i++) {
    float d = dist (balls[i].x, balls[i].y, mouseX, mouseY);
    if (d < balls[i].rad) {
      for (int j = i; j < num_balls-1; j++) {
        balls[j] = balls[j+1];
      }
      num_balls = num_balls -1;
    }
  }
}

void keyPressed () {
  if (key == 's' || key == 'S') {
    saveFrame ("FillBalls-#####.png");
    println ("saved");
  }
}