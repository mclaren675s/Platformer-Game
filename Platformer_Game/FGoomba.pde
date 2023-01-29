class FGoomba extends FGameObject {

  int direction = L;
  int speed = 50;
  int frame = 0;

  FGoomba(float x, float y) {
   super();
   setPosition(x, y);
   setName("goomba");
   setRotatable(false);
  }
  
  //void act() {
  // animate();
  // collide();
  // move();
  //}
  
  
}
