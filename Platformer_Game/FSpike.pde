class FSpikes extends FGameObject {

  FSpikes(float x, float y) {
    super();
    setPosition(x, y);
    setName("spikes");
    attachImage(spikes);
    setStatic(true);
  }

  void act() {
    if (isTouching("player")) {
      setPosition(500, 32);
    }
  }
}
