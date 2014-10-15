import fisica.*;  
  FWorld world;
  FCircle ball;
  Robot robot;
  Robot robot1;
  boolean recentlyRedy;
  void setup(){
    recentlyRedy = false;
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
    robot = new Robot(250, 250, 0, 90, 2, world, this, 870.8, 364);
    robot1 = new Robot(650, 250, 0, 90, 2, world, this, 105.2, 364);
    createBlueGoal(105.2, 364);
    createYellowGoal(870.8, 364);
    createBall(244*2, 182*2);
  }
  
  
  void draw(){
     play(robot1);
     play(robot);
  }
  
  
  void play(Robot robot){
     float m = (robot._goalY-ball.getY())/(robot._goalX-ball.getY());
     float angle = degrees(atan(m));
     float b = ball.getY()-ball.getX()*m;
     float l = 90;
     float redyX = ball.getX()-l;
     float redyY = (ball.getX()-l)*m+b;
     if(robot._goalX < robot._x){
       redyX = ball.getX()+l;
       redyY = (ball.getX()+l)*m+b;
     }
     if(robot._goalX-robot._x < 0){
       angle+=180;
     }
     if(redyX > robot._x-10 && redyX < robot._x+10 && redyY > robot._y-10 && redyY < robot._y+10)
       recentlyRedy = true;
     if(robot.holdsBall(ball.getX(), ball.getY())){
       moveTo(robot._goalX, robot._goalY, angle, 100, 2, robot);
       recentlyRedy = false;
     }else if(!recentlyRedy){
       moveToAvoid(redyX, redyY, angle, 100, 2, robot, ball.getX(), ball.getY());
     }else{
       moveTo(ball.getX(), ball.getY(), angle, 100, 2, robot);
     } 
    
  }
  
  
  void createBlueGoal(float x, float y){
    FPoly goal = new FPoly();
    goal.setGrabbable(false);
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
    goal.setGrabbable(false);
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
  
  void createBall(float x, float y){
    ball = new FCircle(7.4*4);
    ball.setPosition(x, y);
    ball.setDensity(70);
    ball.setFill(120, 120, 190);
    ball.setNoStroke();
    world.add(ball);
  }

  
  
  void moveTo(float x, float y, float theta, float speed, float speedOfRotation, Robot robot){
     theta = theta-90;
     float m = (y-robot._y)/(x-robot._x);
     float angle = degrees(atan(m))+45-robot._theta;
     if(x-robot._x < 0){
       angle+=180;
     }
     angle = angle%360;
     //println(robot._theta);
     float a = cos(radians(angle)) * speed;
     float b = sin(radians(angle)) * speed;
     float d1 = a+(theta-robot._theta)*speedOfRotation;
     float d2 = a-(theta-robot._theta)*speedOfRotation;
     float d3 = b+(theta-robot._theta)*speedOfRotation;
     float d4 = b-(theta-robot._theta)*speedOfRotation;
     robot.move(d1, d2, d3, d4); 
  }
  
  void moveToAvoid(float x, float y, float theta, float speed, float speedOfRotation, Robot robot, float ax, float ay){
     theta = theta-90;
     float m = (y-robot._y)/(x-robot._x);
      m = findMWithoutContact(robot._x, robot._y, m, ball.getX(), ball.getY(), 21*4);
     float angle = degrees(atan(m))+45-robot._theta;
     if(x-robot._x < 0){
       angle+=180;
     }
     angle = angle%360;
     //println(robot._theta);
     float a = cos(radians(angle)) * speed;
     float b = sin(radians(angle)) * speed;
     float d1 = a+(theta-robot._theta)*speedOfRotation;
     float d2 = a-(theta-robot._theta)*speedOfRotation;
     float d3 = b+(theta-robot._theta)*speedOfRotation;
     float d4 = b-(theta-robot._theta)*speedOfRotation;
     robot.move(d1, d2, d3, d4); 
  }
  
  boolean isInCircle(float px, float py, float x, float y, float r){
    return sqrt((px-x)*(px-x)+(py-y)*(py-y)) < r; 
  }
  
  boolean willContact(float x0, float y0, float m, float x1, float y1, float r){
    float b = y0-x0*m;
    for(float x = x0; x < x0+100; x+=0.5){
      if(isInCircle(x, x*m+b, x1, y1, r)) return true;
    } 
    return false;
  }
  
  float findMWithoutContact(float x0, float y0, float m, float x1, float y1, float r){ 
    float startM = m;
    for(int i = 0; i < 360/15 && willContact(x0, y0, m, x1, y1, r); i++){
      m = tan((atan(m)+15%360));
    }
    float upperM = m;
    m = startM;
    for(int i = 0; i < 360/15 && willContact(x0, y0, m, x1, y1, r); i++){
      m = tan((atan(m)-15%360));
    }
    float lowerM = m;
    if(abs(startM-upperM) < abs(startM-lowerM)) return upperM;
    else return lowerM;
  }
  
