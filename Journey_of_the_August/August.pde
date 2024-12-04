//creation of object class for player sprite known as August
class August {

  //initializing objects and declaring variables

  //vector for the August's position, speed, and acceleration
  PVector position;
  PVector velocity;
  PVector acceleration;

  //booleans for the August's thruster controls
  boolean bow;
  boolean stern;
  boolean port;
  boolean starboard;

  //Variables for thrusters controls

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

  //August Constructor with initial position parameters
  August( float x, float y) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
  }

  void movement() {
    //call controls function to update variables
    controls();
    {
      //creat new acceleration PVector using total thrust of X and Y
      acceleration = new PVector(thrustX, thrustY);
      //add acceleration to the velocity creating the speed of the August
      velocity.add(acceleration);
      //Lerp function to simulate drag, reduces velocity to zero at the rate of drag
      velocity.x = lerp(velocity.x, 0, drag);
      velocity.y = lerp(velocity.y, 0, drag);
      //add final velocity to position to update the position of the August
      position.add(velocity);
    }
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

    //Calculating total thrust of spaceship
    thrustY = engine1 + engine2;
    thrustX = engine3 + engine4;
  }

  void display() {
    //hitbox indicator for testing
    fill(255);
    ellipse(position.x, position.y, 10, 10);
    //ship
    fill(100);
    triangle(position.x, position.y - 5, position.x + 3, position.y +2, position.x - 3, position.y + 2);
  }
}
