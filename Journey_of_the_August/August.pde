//creation of object class for player sprite known as August
//contains constructor, movement function, controls function, display function, and boolean to detect bomb collisions
class August {

  //initializing objects and declaring variables
  //sprite for the August
  PImage ship;

  //vector for the August's position, speed, and acceleration
  PVector position;
  PVector velocity;
  PVector acceleration;

  //booleans for the August's controls
  boolean bow;
  boolean stern;
  boolean port;
  boolean starboard;

  //Variables for thrusters

  //ship engines
  float engine1;
  float engine2;
  float engine3;
  float engine4;

  //thrust power
  float power1 = 0.08;
  float power2 = 0.06;
  float power3 = 0.04;

  //total thrust on ship X and Y axis
  float thrustY;
  float thrustX;

  //dragstrentgh for use in lerp function
  float drag = 0.02;

  //variables for control of August's rotation
  boolean rLeft;
  boolean rRight;
  float rotation;
  float rotationAmount = 0.08;

  //August Constructor with initial position parameters, load sprite image
  August( float x, float y) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    imageMode(CENTER);
    ship = loadImage("august_ship.png");
  }

  //function controls movement of the player ship
  void movement() {
    //call controls function to update variables
    controls();

    //contrains the August the the area of the screen
    position.x = constrain(position.x, 10, 390);
    position.y = constrain(position.y, 10, 390);

    //creat new acceleration PVector using total thrust of X and Y
    acceleration = new PVector(thrustX, thrustY);
    //apply rotation to the August's acceleration by rotation
    acceleration.rotate(rotation);
    //add acceleration to the velocity creating the speed of the August
    velocity.add(acceleration);
    //Lerp function to simulate drag, reduces velocity to zero at the rate of drag
    velocity.x = lerp(velocity.x, 0, drag);
    velocity.y = lerp(velocity.y, 0, drag);
    //add final velocity to position to update the position of the August
    position.add(velocity);

    //use matrix to rotate and move the August visual model by calling display function within it
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation);
    display();
    popMatrix();
  }

  //Ship propulsion controls
  void controls() {

    if (bow == true) {
      engine1 = power1;
    } else {
      engine1 = 0;
    }

    if (stern == true) {
      engine2 = -power2;
    } else {
      engine2 = 0;
    }

    if (port == true) {
      engine3 = -power3;
    } else {
      engine3 = 0;
    }

    if (starboard == true) {
      engine4 = power3;
    } else {
      engine4 = 0;
    }

    //Calculating total X and Y thrust of spaceship
    thrustY = engine1 + engine2;
    thrustX = engine3 + engine4;

    //adjust rotation depending on control input
    if (rLeft == true) {
      rotation -= rotationAmount;
    }
    if (rRight == true) {
      rotation += rotationAmount;
    }
  }

  //display function
  void display() {
    //hitbox indicator for testing
    //fill(255);
    //ellipse(0, 0, 13, 13);
    //space ship sprite
    image(ship, 0, 0, 50, 50);
  }

  //boolean function returns true whe is distance between bomb and player origin is less than hitbox of 13
  boolean isHit(Bullet contact) {
    //intake of player position and bomb position to calculate distance
    float distance = dist(position.x, position.y, contact.position.x, contact.position.y);
    //if statement containing hitbox radius to determine if return is true
    if (distance < 13) {
      return true;
    } else {
      return false;
    }
  }
}
