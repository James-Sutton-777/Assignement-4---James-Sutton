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
  float power1 = 0.5;
  float power2 = 0.4;
  float power3 = 0.3;

  //total thrust on ship X and Y axis
  float thrustY;
  float thrustX;

  //August Constructor with initial position parameters
  August( float x, float y) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
  }

  void movement() {
    //call controls function to update variables
    controls();
    {
      acceleration = new PVector(thrustX, thrustY);
      velocity.add(acceleration);
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
    //place holder ship
    fill(255);
    ellipse(position.x, position.y, 10, 10);
  }
}
