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

void setup() {
 size(600,600);
 Fisica.init(this);
 world = new FWorld(-2000,-2000, 2000, 2000);
 world.setGravity(0, 900);
 map = loadImage("map.png");
 
 s
}

void draw() {
world.step();
world.draw();
}
