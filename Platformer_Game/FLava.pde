class FLava extends FGameObject {

  int frame;

  FLava(float x, float y) {
    super();
    setPosition(x, y);
    frame = 0;
    setName("lava");
    setFillColor(lavacolor);
    setStatic(true);
  }

  void act() {
    action = lava;
    animate();
  }

  void animate() {
    if (frame >= action.length) frame = 0;
    if (frameCount %5 == 0) {
      attachImage(action[frame]);
      frame++;
    }
  }
}
