//game where small ship avoids being hit for as long as possible//
//press space to start and to return to start screen on game over//

//initialize images 
//background for function backgroundStars
PImage stars;
//idle state background
PImage start;


//initialization and variables

//player sprite object
August ship;
//enemy sprite object
Enemy enemy;

//arraylist containing barriers that descend the screen
ArrayList<Obsticle> wallz = new ArrayList<Obsticle>();
//arralist containing bombs fired by enemy ship
ArrayList<Bullet> bombs = new ArrayList<Bullet>();

//variable for storing game state
int state;
//variable indicating game is in play
boolean gameStart = false;
//variable indicating game has ended
boolean gameEnd = false;

//gameplay variables
//boolean to determine if the ship has been hit by a barrier or bullet
boolean hit = false;
//integers containing score during play and finalscore after gameover
int score = 0;
int finalScore = 0;

//setup initial variables and window
void setup() {
  //window size and background
  size(400, 400);
  background(0);

  //load png files
  stars = loadImage("star_background.png");
  start = loadImage("start_screen.png");

  //begin as state 1, idle
  state = 1;

  //create August and enemy
  ship = new August(200, 200);
  enemy = new Enemy();

  //create initial colliders at the start of a round
  for (int i = 0; i < 2; i++) {
    wallz.add(new Obsticle(random(-25, 375), -20, random(50, 15), 10));
  }
}

//draw function contains if statements determining which function to run depending on declared game state
void draw() {

  //start state, idle
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

//activate engines in direction of the pressed key, activates roation, and game start button
void keyPressed() {

  //translation controls
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

  //rotation controls
  if (key == 'a') {
    ship.rLeft = true;
  }

  if (key == 'd') {
    ship.rRight = true;
  }

  //space bar to change game state
  //if statement so that it changes the correct boolean value corresponding to current game state
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

//deactivates engines and rotation
void keyReleased() {

  //translation controls
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

  //rotation controls
  if (key == 'a') {
    ship.rLeft = false;
  }

  if (key == 'd') {
    ship.rRight = false;
  }
}

//function containing code for gameplay state, i.e. the game part
void gamePlay() {
  //draw background by calling background function
  backgroundStars();

  //call function to count score and display it
  //this function also handles barrier spawns
  scoring();

  //function dictating to enemy behaviour
  enemy.movement();
  enemy.display();
  //input player position so that enemy can target them
  enemy.fcs(ship.position.x, ship.position.y);
  //timer function determines rate of fire
  enemy.timer();

  //function for player controlled vessel, the August
  //contains display and controls functions
  ship.movement();

  //loop runs function for each wall in arraylist
  for (int i = 0; i < wallz.size(); i++) {
    Obsticle walli = wallz.get(i);
    walli.display();
    walli.movement();
    //if statement uses collision function returns boolean to determine if player was hit
    //collision function takes player postion and hitbox radius as paramerter
    if (walli.collision(ship.position.x, ship.position.y, 13)) {
      hit = true;
    }
  }

  //loop runs functions for each bomb in arraylist
  for (int i = 0; i < bombs.size(); i++) {
    Bullet bombi = bombs.get(i);
    bombi.display();
    bombi.movement();
    bombi.lifespan();
    //if statement sets hit to true when player contacts bomb
    //bomb is then deleted from array
    if (ship.isHit(bombi)== true) {
      hit = true;
      bombs.remove(i);
    }
    //if statement deletes bomb when lifespan counter reaches chosen number
    if (bombi.timer == 950) {
      bombs.remove(0);
    }
  }

  //if statement adds bomb to arraylist when enemy fires
  //bomb then spawns in previous loop
  if (enemy.fire == true) {
    Bullet bomb = new Bullet(enemy.position.copy(), enemy.aim.copy());
    bombs.add(bomb);
  }

  //if statement changes game state to game over when player is hit
  if (hit == true) {
    //player hit consol feedback
    println("hit");
    //reset game states
    gameStart = false;
    gameEnd = false;
    //takes copy of score at time of game over
    finalScore = score;
    //state changed to game over
    state = 3;
  }
}


//scoring function counts score, displays score, and manages barrier spawn
void scoring() {
  //increases score by 1 per draw loop
  score += 1;
  //uses text string to display score
  textSize(10);
  text(("Score:"+score), 330, 380);

  //spawns additional barrier every 700 score to a maximum of 7 (initial 2 + 5)
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

//function for game start state
void startScreen() {
  background(0);
  
  //background image
  imageMode(CENTER);
  image(start, width/2, height/2, width, height);

  
  //if statement changes to gameplay when corresponding key is pressed
  if (gameStart == true) {
    state = 2;
  }
}

//function for game over state
void gameOver() {
  background(200, 0, 10);
  //text string depicting final score at game over
  textSize(30);
  text(("Final Score:  "+finalScore), 100, 200);

  //hit boolean is reset
  hit = false;

  //player ship movement variables are reset
  ship.velocity.y = 0;
  ship.velocity.x = 0;
  ship.position.x = 200;
  ship.position.y = 200;

  //score is set to zero
  score = 0;

  //additional barriers are removed until two are left
  if (wallz.size() >= 3) {
    for (int i = wallz.size() - 1; i > 1; i--) {
      wallz.remove(i);
      //t variable to count amount of times loop as run
      int t = 0;
      //brute force method of preserving initial 2 barriers
      //it works and i can't be bothered to clean it up, "if it ain't broke don't fix it"
      if (i == 2) {
        t += 1;
      }
      //break loop when it has run more than once
      if (t >= 1) {
        break;
      }
    }
  }

  //loop reset wall movement variables for 2 remaining barriers
  for (int j = 0; j < 2; j++) {
    Obsticle walli = wallz.get(j);
    walli.position.y = -20 - (20*j);
    walli.accel = 0;
    walli.velocity.y = 0;
    //ends loop when adjustment is done
    if (j >= 2) {
      break;
    }
  }

  //loop to deleted any bombs that were spawned
  for (int i = bombs.size() - 1; i >= 0; i--) {
    Bullet dead = bombs.get(i);
    if (dead.timer >= 0) {
      bombs.remove(i);
    }
  }

  //if statement goes to idle state when corresponding key is pressed
  if (gameEnd == true) {
    state = 1;
  }
}

//function to create background image using sprite
void backgroundStars() {
  imageMode(CENTER);
  image(stars, width/2, height/2, width, height);
}
