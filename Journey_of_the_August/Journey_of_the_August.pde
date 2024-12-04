//game where small ship avoids being hit for as long as possible

//initialization and variables
August ship;
//variable for storing game state
int state;

//setup initial variables and window
void setup() {
  //window size and background
  size(400, 400);
  background(0);
  
  //begin as state 1, main menu
  state = 1;
  
  //declaring August
  ship = new August(200, 200);
}
//testing August object and movement
void draw() {
  //redraw background
  background(0);
  ship.movement();
  ship.display();
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
}
