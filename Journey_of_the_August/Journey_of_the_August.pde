//game where small ship avoids being hit for as long as possible

PImage stars;

//initialization and variables
August ship;
Enemy enemy;
ArrayList<Obsticle> wallz = new ArrayList<Obsticle>();
ArrayList<Bullet> shellsFired = new ArrayList<Bullet>();
//variable for storing game state
int state;
boolean gameStart = false;
boolean gameEnd = false;

//gameplay variables
boolean hit = false;
int score = 0;
int finalScore = 0;

//setup initial variables and window
void setup() {
  //window size and background
  size(400, 400);
  background(0);
  
  stars = loadImage("star_background.png");

  //begin as state 1, main menu
  state = 1;

  //create August
  ship = new August(200, 200);
  enemy = new Enemy();

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
  backgroundStars();

  scoring();

  enemy.movement();
  enemy.display();
  enemy.fcs(ship.position.x, ship.position.y);
  enemy.timer();


  ship.movement();

  for (int i = 0; i < wallz.size(); i++) {
    Obsticle walli = wallz.get(i);
    walli.display();
    walli.movement();
    if (walli.collision(ship.position.x, ship.position.y, 10)) {
      hit = true;
    }
  }

  for (int i = 0; i < shellsFired.size(); i++) {
    Bullet shelli = shellsFired.get(i);
    shelli.display();
    shelli.movement();
    shelli.lifespan();
    if (ship.isHit(shelli)== true) {
      hit = true;
      shellsFired.remove(i);
    }
    if (shelli.timer == 800) {
      shellsFired.remove(0);
    }
  }

  if (enemy.fire == true) {
    Bullet shell = new Bullet(enemy.position.copy(), enemy.aim.copy());
    shellsFired.add(shell);
    println("PEW");
  }

  //collision function
  if (hit == true) {
    println("hit");
    gameStart = false;
    gameEnd = false;
    finalScore = score;
    state = 3;
  }
}



void scoring() {
  score += 1;
  textSize(10);
  text(("Score:"+score), 330, 380);

  if (score == 700) {
    wallz.add(new Obsticle(random(-25, 375), -20, random(50, 15), 10));
  } else if (score == 1400) {
    wallz.add(new Obsticle(random(-25, 375), -20, random(50, 15), 10));
  } else if (score == 2100) {
    wallz.add(new Obsticle(random(-25, 375), -20, random(50, 15), 10));
  } else if (score == 2800) {
    wallz.add(new Obsticle(random(-25, 375), -20, random(50, 15), 10));
  } else if (score == 3500) {
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
  textSize(30);
  text(("Final Score:  "+finalScore), 100, 200);

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

  for (int i = shellsFired.size() - 1; i >= 0; i--) {
    Bullet dead = shellsFired.get(i);
    if (dead.timer >= 0) {
      shellsFired.remove(i);
    }
  }

  if (gameEnd == true) {
    state = 1;
  }
}

void backgroundStars() {
  imageMode(CENTER);
  image(stars, width/2, height/2, width, height);
}
