import fisica.*;  
  FWorld world;
  Robot robot;
  int i = 0;
  void setup(){
    size(244*4, 182*4);
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
    robot = new Robot(250, 250, 0, 90, 2, world, this);
    createBlueGoal(105.2, 364);
    createYellowGoal(870.8, 364);
  }
  
  
  void draw(){
    
     moveTo(mouseX, mouseY,i++, 40, 0.1, robot);
     
     
  }
  
  
  void createBlueGoal(float x, float y){
    FPoly goal = new FPoly();
    goal.setPosition(x, y);
    goal.setStatic(true);
    goal.setStrokeWeight(3);
    goal.setFill(55, 94, 199);
    goal.setDensity(10);
    goal.setRestitution(0.5);
    goal.vertex(-14.8, -120);
    goal.vertex(14.8, -120);
    goal.vertex(14.8, 120);
    goal.vertex(-14.8, 120);
    if (goal!=null) world.add(goal); 
  }
  

  void createYellowGoal(float x, float y){
    FPoly goal = new FPoly();
    goal.setPosition(x, y);
    goal.setStatic(true);
    goal.setStrokeWeight(3);
    goal.setFill(234, 255, 36);
    goal.setDensity(10);
    goal.setRestitution(0.5);
    goal.vertex(-14.8, -120);
    goal.vertex(14.8, -120);
    goal.vertex(14.8, 120);
    goal.vertex(-14.8, 120);
    if (goal!=null) world.add(goal); 
  }

  
  
  void moveTo(float x, float y, float theta, float speed, float speedOfRotation, Robot robot){
     theta = -theta-90;
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
