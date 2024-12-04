//game where small ship avoids being hit for as long as possible

//initialization and variables
August ship;
ArrayList<Obsticle> wallz = new ArrayList<Obsticle>();
//variable for storing game state
int state;

//gameplay variables
boolean hit = false;
int score = 0;

//setup initial variables and window
void setup() {
  //window size and background
  size(400, 400);
  background(0);

  //begin as state 1, main menu
  state = 1;

  //create August
  ship = new August(200, 200);

  //create initial colliders
  for (int i = 0; i < 2; i++) {
    wallz.add(new Obsticle(random(-25, 375), -20, random(50, 15), 10));
  }
}

//testing August object and movement
void draw() {

  //gameplay state
  if (state == 1) {
    gamePlay();
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

void gamePlay() {
  //redraw background
  background(0);

  scoring();

  ship.movement();

  for (int i = 0; i < wallz.size(); i++) {
    Obsticle walli = wallz.get(i);
    walli.display();
    walli.movement();
    if (walli.collision(ship.position.x, ship.position.y, 10)) {
      hit = true;
    }
  }

  //collision function
  if (hit == true) {
    println("hit");
  }
}

void scoring() {
  score += 1;
  println(score);

  if (score == 2500) {
    wallz.add(new Obsticle(random(-25, 375), -20, random(50, 15), 10));
  } else if (score == 5000) {
    wallz.add(new Obsticle(random(-25, 375), -20, random(50, 15), 10));
  } else if (score == 7500) {
    wallz.add(new Obsticle(random(-25, 375), -20, random(50, 15), 10));
  } else if (score == 10000) {
    wallz.add(new Obsticle(random(-25, 375), -20, random(50, 15), 10));
  } else if (score == 11000) {
    wallz.add(new Obsticle(random(-25, 375), -20, random(50, 15), 10));
  }
}
