class Enemy {

  PVector position;
  PVector velocity;
  PVector aim;

  int spawnTime;

  boolean fire = false;

  Enemy() {
    position = new PVector(random(10, 390), 10);
    velocity = new PVector(0.5, 0);
    aim = new PVector(0, 0);
    spawnTime = 0;
  }

  void fcs(float x, float y) {
    aim.x = x - position.x;
    aim.y = y - position.y;
    aim.normalize();
  }

  void movement() {

    position.add(velocity);

    if (position.x <= 10) {
      velocity.x = 0.5;
    }

    if (position.x >= 390) {
      velocity.x = -0.5;
    }
  }

  void display() {
    //enemy ship
    stroke(255);
    line(position.x, position.y, position.x + (aim.x * 25), position.y + (aim.y * 25));
    fill(180, 0, 50);
    triangle(position.x, position.y - 5, position.x + 3, position.y + 2, position.x - 3, position.y + 2);
  }

  void timer() {
    if (spawnTime >= 100) {
      spawnTime = 0;
      fire = true;
    } else {
      spawnTime += 1;
      fire = false;
    }
  }
}
