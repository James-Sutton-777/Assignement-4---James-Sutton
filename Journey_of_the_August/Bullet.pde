class Bullet{
 PVector velocity;
 PVector position;
 
 float timer;

 public Bullet(PVector p, PVector d) {
   velocity = d;
   position = p;
   velocity.mult(0.5);
 }
void display(){
  noStroke();
  fill(255);
  ellipse(position.x, position.y, 5, 5);
}

void movement(){
  position.add(velocity);
}

void lifespan(){
  timer++ ;
}
  
}
