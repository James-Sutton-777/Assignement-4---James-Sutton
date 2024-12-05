//class enemy object of the opposing ship
//contains constructor, fcs(fire control system) function, movement function, display function, and timer function
class Enemy {

  //declare sprite variable
  PImage spiker;

  //declare variables for position, velocity, and point of aim
  PVector position;
  PVector velocity;
  PVector aim;

  //interger for determing time between bombs fired
  int spawnTime;

  //boolean to fire bomb
  boolean fire = false;

  //constructor
  Enemy() {
    //initial X position is random, in position vector
    position = new PVector(random(10, 390), 25);
    //enemy only moves along the X axis by fixed speed in velocity
    velocity = new PVector(0.5, 0);
    //initial aim vector
    aim = new PVector(0, 0);
    //spawntime counter is set to 0
    spawnTime = 0;
    //load sprite of spiker enemy
    spiker = loadImage("spiker_bomber.png");
  }

  //fcs function determing angle of aim
  //parameters intake target position, in this case the player
  void fcs(float x, float y) {
    aim.x = x - position.x;
    aim.y = y - position.y;
    //normalized to obtain only the direction not the magnitude
    aim.normalize();
  }

  //movment function controls spiker movement from left to right
  void movement() {

    //add velocity to update position
    position.add(velocity);

    //if spiker is on left edge of the screen they reverse their velocity
    if (position.x <= 10) {
      velocity.x = 0.5;
    }

    //if spiker is on right edge of the screen they reverse their velocity
    if (position.x >= 390) {
      velocity.x = -0.5;
    }
  }

  //display function
  void display() {
    //enemy ship sprite
    imageMode(CENTER);
    image(spiker, position.x, position.y, 65, 65);
  }

  //timer function determines rate of fire of bombs
  void timer() {
    //if statement determines at what time bombs are fired
    //resets timer to zero after bomb fired
    if (spawnTime >= 100) {
      spawnTime = 0;
      fire = true;
    } else {
      spawnTime += 1;
      fire = false;
    }
  }
}
