//game where small ship avoids being hit for as long as possible

//initialization and variables
August ship;
ArrayList<Obsticle> wallz = new ArrayList<Obsticle>();
//variable for storing game state
int state;
boolean gameStart = false;
boolean gameEnd = false;

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

  //start state
  if (state == 1) {
    startScreen();
  }

  //gameplay state
  if (state == 2) {
    gamePlay();
  }

  //gameover state
  if (state == 3) {
    gameOver();
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

  if (state == 1) {
    if (key == ' ') {
      gameStart = true;
    }
  } else if (state == 3) {
    if (key == ' ') {
      gameEnd = true;
    }
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
    gameStart = false;
    gameEnd = false;
    state = 3;
  }
}

void scoring() {
  score += 1;
  println(score);

  if (score == 500) {
    wallz.add(new Obsticle(random(-25, 375), -20, random(50, 15), 10));
  } else if (score == 1000) {
    wallz.add(new Obsticle(random(-25, 375), -20, random(50, 15), 10));
  } else if (score == 7500) {
    wallz.add(new Obsticle(random(-25, 375), -20, random(50, 15), 10));
  } else if (score == 10000) {
    wallz.add(new Obsticle(random(-25, 375), -20, random(50, 15), 10));
  } else if (score == 11000) {
    wallz.add(new Obsticle(random(-25, 375), -20, random(50, 15), 10));
  }
}

void startScreen() {
  background(0);

  fill(255);
  ellipse(200, 200, 10, 10);

  if (gameStart == true) {
    state = 2;
  }
}

void gameOver() {
  background(200, 0, 10);

  hit = false;

  ship.velocity.y = 0;
  ship.velocity.x = 0;
  ship.position.x = 200;
  ship.position.y = 200;
  score = 0;

  if (wallz.size() >= 3) {
    for (int i = wallz.size() - 1; i > 1; i--) {
      wallz.remove(i);
      int t = 0;
      if (i == 2) {
        t += 1;
      }
      if (t >= 1) {
        break;
      }
    }
  }
  for (int j = 0; j < 2; j++) {
    Obsticle walli = wallz.get(j);
    walli.position.y = -20 - (20*j);
    walli.accel = 0;
    walli.velocity.y = 0;

    if (j >= 2) {
      break;
    }
  }


  if (gameEnd == true) {
    state = 1;
  }
}
