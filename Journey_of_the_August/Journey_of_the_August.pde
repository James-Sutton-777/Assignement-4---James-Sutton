//game where small ship avoids being hit for as long as possible

//initialization and variables
August ship;
Obsticle wall;
//variable for storing game state
int state;

//setup initial variables and window
void setup() {
  //window size and background
  size(400, 400);
  background(0);
  
  //begin as state 1, main menu
  state = 1;
  
  //create August
  ship = new August(200, 200);
  
  //create obticle
  wall = new Obsticle(random(50, 300), -20, random(100, 20), 20);
  }
  
//testing August object and movement
void draw() {
  //redraw background
  background(0);
  
  //variable to test collision
  boolean hit = wall.collision(ship.position.x, ship.position.y, 10);
  
  ship.movement();
  wall.movement(0, 0.5);
  wall.display();
  
  //collision function
  if (hit == true) {
    println("hit");
  }
}

//activate engines in direction of the pressed key
void keyPressed() {
  if (keyCode == DOWN) {
    ship.stern = true;
  }

  if (keyCode == UP) {
    ship.bow = true;
  }

  if (keyCode == RIGHT) {
    ship.port = true;
  }

  if (keyCode == LEFT) {
    ship.starboard = true;
  }
  
  //Rotation key inputs
    if (key == 'a') {
    ship.rLeft = true;
  }
  
  if (key == 'd') {
    ship.rRight = true;
  }
}

//activate engines in direction of the pressed key
void keyReleased() {
  if (keyCode == DOWN) {
    ship.stern = false;
  }

  if (keyCode == UP) {
    ship.bow = false;
  }

  if (keyCode == RIGHT) {
    ship.port = false;
  }

  if (keyCode == LEFT) {
    ship.starboard = false;
  }
  
  //Rotation key inputs
    if (key == 'a') {
    ship.rLeft = false;
  }
  
  if (key == 'd') {
    ship.rRight = false;
  }
}
