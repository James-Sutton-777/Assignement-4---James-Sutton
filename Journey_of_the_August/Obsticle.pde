//creation of object class for colliding barriers
//contains constructor, boolean function calculating collisions, display function, movement function, and timer function
class Obsticle {
  
  PImage spikes;

  //initializing vector for obsticle position, velocity, and acceleration
  PVector position;
  PVector velocity;

  //declare variables for obsticle width and height
  float oWidth;
  float oHeight;

  //declare variables used to check edges of rectangle collider
  float leftSide;
  float rightSide;
  float topSide;
  float bottomSide;
  
  //variables controlling speed and position changes of obsticle
  float accel = 0;
  float speed;
  
  //timer variables
  int levelTime = 0;

  //contructor for the barrier with parameters to set position, width and height
  Obsticle(float x, float y, float w, float h) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    oWidth = w;
    oHeight = h;
    speed = random(0.5, 1);
    spikes = loadImage("spikerbarrier.png");
  }

  //boolean to determine collision of Obsticle and the August
  //inputing ships position and radius of hitbox as parameters
  boolean collision(float x, float y, float r) {

    //declare and intialize variables where corresponding edge values will be stored
    float checkX = x;
    float checkY = y;

    //create values for each edge of the barrier
    leftSide = position.x;
    rightSide = position.x + oWidth;
    topSide = position.y;
    bottomSide = position.y + oHeight;

    //determine if hitbox is left or right of the barrier
    if (x < leftSide) {
      checkX = leftSide;
    } else if (x > rightSide) {
      checkX = rightSide;
    }
    //determine if hitbox is above or bellow the barrier
    if (y < topSide) {
      checkY = topSide;
    } else if (y > bottomSide) {
      checkY = bottomSide;
    }

    //declare and calculate distance between ship position and edge on X and Y axis
    float distX = x - checkX;
    float distY = y - checkY;
    //declare and calculate total distance between edge and ship
    float distT = sqrt((distX * distX) + (distY * distY));

    //if statement which returns true on barrier collision with ship
    if (distT < r) {
      return true;
    } else {
      return false;
    }
  }

  //function to display the collider
  void display() {
    //fill(200);
    //rect(position.x, position.y, oWidth, oHeight);
    imageMode(CENTER);
    image(spikes, position.x + oWidth/2, position.y + 5, oWidth + 20, 80);
  }

  //function to move the collider from the top to the bottom of the screen
  //parameters for intial velocity and acceleration
  void movement() {
    velocity.y = speed + accel;
    position.add(velocity);

    if (position.y > 400) {
      position.y = random(-20, -50);
      position.x = random(-5, 395);
      oWidth = random(50, 15);
    }
  }
  //function counting time of play and adjusting variables as a result
  void timer() {
    levelTime += 1;
    
    //increase barrier acceleration by random int every time the timer reaches chosen number
    if (levelTime == 1000) {
      levelTime = 0;
      accel = accel + random(1, 1.5);
    }
  }
}
