//class bullet inpired by previous assignement Tonk Destroyer of Squares
//most things are identical except the correct labeling of velocity, speed, and display function
class Bullet {

  //vectors containg velocity and position of bomb
  PVector velocity;
  PVector position;

  //timer to count lifespan of bomb
  float timer;

  //public contructor with two PVectors are parameters
  //p is enemy ship position, and d is point of aim
  public Bullet(PVector p, PVector d) {
    velocity = d;
    position = p;
    //velocuty is multiplied by speed
    velocity.mult(0.5);
  }

  //function displays the bomb as an ellipse
  void display() {
    stroke(0, 0, 245);
    fill(255);
    ellipse(position.x, position.y, 5, 5);
  }

  //function for bomb movement by adding velocity to position
  void movement() {
    position.add(velocity);
  }

  //lifespan function counts timer
  void lifespan() {
    timer++ ;
  }
}
