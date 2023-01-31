import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//Alex Chapman

import fisica.*;
FWorld world;

color white = #FFFFFF;
color black = #000000;

//tree colors
color middleGreen = #16db65;
color westGreen = #008937;
color eastGreen = #12823a;
color centerGreen = #04471c;
color treeTrunkBrown = #c02d00;

color purple = #d200cd; //spikes
color cyan = #6feef9;
color aqua = #6CE3C6;

color yellow = #CBFF00;//bridge


color red = #FF0000;
color orange = #F0A000;
color brown = #996633;

color pink = #e992db; //goomba
color gray = #5b5b5b; //wall

color lavacolor = #ffa6a6;
//Images --------------

//terrain images
PImage map, ice, stone, treeTrunk, middleGreenLeaves, leftGreenLeaves, rightGreenLeaves, centerGreenLeaves, spikes, trampoline, bridge;

//character animation images
PImage[] idle;
PImage[] jump;
PImage[] run;
PImage[] action;
PImage[] lava;
PImage[] goomba;

//map controls
int gridSize = 32;
float zoom = 2;

//keyboard booleans
boolean upkey, downkey, leftkey, rightkey, wkey, akey, skey, dkey, qkey, ekey, spacekey;

//objects and lists of objects
ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;
FPlayer player;

//music
Minim minim;
AudioPlayer THEME;


void setup() { ////////////////////////////////////////////////////
  size(1000, 1000);
  Fisica.init(this);
  terrain = new ArrayList<FGameObject>();
  //music
  minim = new Minim(this);
  THEME = minim.loadFile("C418 - Subwoofer Lullaby.mp3");
  
  loadImages();
  loadWorld(map);
  loadPlayer();
} /////////////////////////////////////////////////////////////////

void loadImages() {
  map = loadImage("map.png");
  stone = loadImage("stone.png");
  ice = loadImage("blueBlock.png");
  ice.resize(32, 32); //resize ice image to the standard blocksize
  treeTrunk = loadImage("tree_trunk.png");
  middleGreenLeaves = loadImage("treetop_center.png");
  leftGreenLeaves = loadImage("treetop_w.png");
  rightGreenLeaves = loadImage("treetop_e.png");
  centerGreenLeaves = loadImage("tree_intersect.png");
  spikes = loadImage("spike.png");
  trampoline = loadImage("trampoline.png");
  bridge = loadImage("bridge_center.png");

  //load actions -----------------------------------
  idle = new PImage[2];
  idle[0] = loadImage("idle0.png");
  idle[1] = loadImage("idle1.png");

  jump = new PImage[1];
  jump[0] = loadImage("jump0.png");

  run = new PImage[3];
  run[0] = loadImage("runright0.png");
  run[1] = loadImage("runright1.png");
  run[2] = loadImage("runright2.png");

//lava ---------------------
  lava = new PImage[6];
  lava[0] = loadImage("lava0.png");
  lava[0].resize(gridSize, gridSize);
  lava[1] = loadImage("lava1.png");
  lava[1].resize(gridSize, gridSize);
  lava[2] = loadImage("lava2.png");
  lava[2].resize(gridSize, gridSize);
  lava[3] = loadImage("lava3.png");
  lava[3].resize(gridSize, gridSize);
  lava[4] = loadImage("lava4.png");
  lava[4].resize(gridSize, gridSize);
  lava[5] = loadImage("lava5.png");
  lava[5].resize(gridSize, gridSize);
  
  action = idle;

  //goombas ------------------------
  goomba = new PImage[2];
  goomba[0] = loadImage("goomba0.png");
  goomba[0].resize(gridSize, gridSize);
  goomba[1] = loadImage("goomba1.png");
  goomba[1].resize(gridSize, gridSize);
}

void loadWorld(PImage img) {
  world = new FWorld(-4600, -4600, 4600, 4600);
  world.setGravity(0, 981);

  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = map.get(x, y);
      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);

      if (c == black) { //stone block
        b.attachImage(stone);
        b.setFriction(4);
        b.setGrabbable(false);
        b.setName("stone");
        world.add(b);
        
      } else if (c == gray) { //wall for goombas
        b.attachImage(stone);
        b.setFriction(4);
        b.setName("wall");
        world.add(b);
        
      } else if (c == cyan) { //ice block
        b.attachImage(ice);
        b.setFriction(0);
        b.setName("ice");
        world.add(b);
        
      } else if (c == treeTrunkBrown) { //tree trunk
        b.attachImage(treeTrunk);
        b.setFriction(2);
        b.setSensor(true);
        b.setName("treeTrunk");
        world.add(b);
        
      } else if (c == centerGreen) { //tree intersect
        b.attachImage(centerGreenLeaves);
        b.setFriction(2);
        b.setName("centerGreenLeaves");
        world.add(b);
        
      } else if (c == middleGreen) { //tree middle
        b.attachImage( middleGreenLeaves);
        b.setFriction(2);
        b.setName("middleGreenLeaves");
        world.add(b);
        
      } else if (c == westGreen) { //tree leftside
        b.attachImage(leftGreenLeaves);
        b.setFriction(2);
        b.setName("leftGreenLeaves");
        world.add(b);
        
      } else if (c == eastGreen) { //tree rightside
        b.attachImage(rightGreenLeaves);
        b.setFriction(2);
        b.setName("rightGreenLeaves");
        world.add(b);
        
      } else if (c == purple) { //spikes
        FSpikes sp = new FSpikes(x*gridSize, y*gridSize);
        b.attachImage(spikes);
        b.setFriction(8);
        b.setName("spikes");
        terrain.add(sp);
        world.add(sp);
        
      } else if (c == lavacolor) { //lava
        FLava lav = new FLava(x*gridSize, y*gridSize);
        b.attachImage(spikes);
        b.setFriction(8);
        b.setName("lava");
        terrain.add(lav);
        world.add(lav);
        
      } else if (c == aqua) { //trampoline
        b.attachImage(trampoline);
        b.setFriction(0);
        b.setRestitution(2);
        b.setName("trampoline");
        world.add(b);
        
      } else if (c == yellow) { //bridge
        FBridge br = new FBridge(x*gridSize, y*gridSize);
        b.attachImage(bridge);
        b.setFriction(4);
        b.setName("bridge");
        terrain.add(br);
        world.add(br);
        
      } else if (c == pink) {
        FGoomba gmb = new FGoomba(x*gridSize, y*gridSize);
        b.setName("goomba");
        // enemies.add(gmb);
        world.add(gmb);
      }
    }
  }
}

void loadPlayer() {
  player = new FPlayer();
  world.add(player);
}


void draw() {
  background(black);
  THEME.play();
  drawWorld();
  actWorld();
}

void actWorld() {
  player.act();
  for (int i = 0; i < terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
  }
  //for (int i = 0; i < enemies.size(); i++) {
  //  FGameObject e = enemies.get(i);
  //  e.act();
  //}
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom+width/2, -player.getY()*zoom+height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}
