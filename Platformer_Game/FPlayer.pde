class FPlayer extends FGameObject {

  int frame;
  int direction;
  int lives;

  FPlayer() {
    super();
    frame = 0;
    lives = 3;
    direction = R;
    setPosition(500, 32);
    setName("player");
    setRotatable(false);
    setFillColor(red);
  }

  void act() {
    input();
    collisions();
    animate();
  }

  void input() {
    float vy = getVelocityY();
    float vx = getVelocityX();
    if (vy < 0.1) {
      action = idle;
    }
    if (akey) {
      direction = L;
      setVelocity(-250, vy);
      action = run;
    }
    if (dkey) {
      direction = R;
      setVelocity(250, vy);
      action = run;
    }

    if (wkey) {
      setVelocity(vx, -250);
    }
    if (abs(vy) > 0.1) {
      action = jump;
    }
  }


  void collisions() {
    if (isTouching("spikes")) {
      setPosition(500, 32);
    }
      if (isTouching("lava")) {
      setPosition(500, 32);
    }
    
  }

  void animate() {
    if (frame >= action.length) frame = 0;
    if (frameCount %5 == 0) {
       if (direction == R) attachImage(action[frame]);
       if (direction == L) attachImage(reverseImage(action[frame]));
       frame++;
      }
    }
  }
