import fisica.*;
FWorld world;

color white = #FFFFFF;
color black = #000000;

color green = #00FF00;
color red = #FF0000;
color blue = #0000FF;
color orange = #F0A000;
color brown = #996633;

PImage map;
int gridSize = 32;
float zoom = 1.5;
boolean upkey, downkey, leftkey, rightkey, wkey, akey, skey, dkey, qkey, ekey, spacekey;
FPlayer player;


void setup() {
  size(1000, 1000);
  Fisica.init(this);
  
  map = loadImage("map.png");
  loadWorld(map);
  loadPlayer();
}

void loadWorld(PImage img) {
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);
  
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = map.get(x, y);
      if (c == black) {
        FBox b = new FBox(gridSize, gridSize);
        b.setPosition(x*gridSize, y*gridSize);
        b.setStatic(true);
        world.add(b);
      }
    }
  }
}

void loadPlayer() {
  player = new FPlayer();
  world.add(player);
  
}

void draw() {
  background(white);
  drawWorld();
  player.act();
}

void drawWorld() { 
 pushMatrix();
 translate(-player.getX()*zoom+width/2, -player.getY()*zoom+height/2);
 scale(zoom);
 world.step();
 world.draw();
 popMatrix();
}

boolean touchingGround(FBox ground) {
  ArrayList<FContact> contactList = player.getContacts();
  int i = 0;
  while (i < contactList.size()) {
   FContact myContact = contactList.get(i);
   if (myContact.contains(ground))
    i++;
  }
  
}
