import fisica.*;
FPoly poly;
  FWorld world;
  Robot robot;
  int i = 0;
  void setup(){
    size(500, 500);
    smooth();
    Fisica.init(this);
    world = new FWorld();
    world.setGravity(0, 0);
    world.setEdges();
    //world.remove(world.left);
    //world.remove(world.right);
    //world.remove(world.top);
    world.setEdgesRestitution(0.5);
    mouseX = 500;
    mouseY = 500;
    robot = new Robot(0, 0, 0, 30, 3, world, this);
  }
  
  
  void draw(){
     moveTo(mouseX, mouseY, i++, 30, 0.01);
     
  }
  

  

  
  
  void moveTo(float x, float y, float theta, float speed, float speedOfRotation){
     float m = (y-robot._y)/(x-robot._x);
     float angle = degrees(atan(m))+45-robot._theta;
     if(x-robot._x < 0){
       angle+=180;
     }
     angle = angle%360;
     println(robot._theta);
     float a = cos(radians(angle)) * speed;
     float b = sin(radians(angle)) * speed;
     float d1 = a+(theta-robot._theta)*speedOfRotation;
     float d2 = a-(theta-robot._theta)*speedOfRotation;
     float d3 = b+(theta-robot._theta)*speedOfRotation;
     float d4 = b-(theta-robot._theta)*speedOfRotation;
     robot.move(d1, d2, d3, d4); 
  }

