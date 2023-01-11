class FPlayer extends FBox {
 
  FPlayer() {
   super(gridSize, gridSize);
   setPosition(500,32);
   setFillColor(red);
  }
  
  void act() {
    float vy = getVelocityY();
    if (akey) setVelocity(-500, vy);
    if (dkey) setVelocity(500, vy);
    float vx = getVelocityX();
    if (skey) setVelocity(vx, 500);
    if (wkey) setVelocity(vx, -500);
  }
  
 
}
