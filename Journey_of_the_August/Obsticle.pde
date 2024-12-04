//creation of object class for colliding obsticle
class Obsticle {

  //initializing vector for obsticle position, velocity, and acceleration
  PVector position;
  PVector velocity;
  PVector acceleration;

  //declare variables for obsticle width and height
  float oWidth;
  float oHeight;

  //declare variables used to check edges of rectangle collider
  float leftSide;
  float rightSide;
  float topSide;
  float bottomSide;

  //contructor for the obsticle with parameters to set position, width and height
  Obsticle(float x, float y, float w, float h) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    oWidth = w;
    oHeight = h;
  }

  //boolean to determine collision of obsticle and the August
  //inputing ships position and radius of hitbox as parameters
  boolean collision(float x, float y, float r) {

    //declare and intialize variables where corresponding edge values will be stored
    float checkX = x;
    float checkY = y;

    //create values for each edge of the obsticle
    leftSide = position.x;
    rightSide = position.x + oWidth;
    topSide = position.y;
    bottomSide = position.y + oHeight;

    //determine if hitbox is left or right of the obsticle
    if (x < leftSide) {
      checkX = leftSide;
    } else if (x > rightSide) {
      checkX = rightSide;
    }
    //determine if hitbox is above or bellow the obsticle
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

    //if statement which returns true on obsticle collision with ship
    if (distT <= r) {
      return true;
    } else {
      return false;
    }
  }
  
  void display() {
    fill(200);
    rect(position.x, position.y, oWidth, oHeight);
  }
}
