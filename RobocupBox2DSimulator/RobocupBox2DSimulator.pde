import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;

  ArrayList<Boundary> boundaries;
  Robot robot;
  Robot robot1;
  int goalsYellow;
  int goalsBlue;
  int steps;
  int stepsFromLastGoal = 0;
  int ties;
  boolean recentlyRedy;
  Ball ball;
  void setup(){
    smooth();
  size(244*4, 182*4);
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this,20);
  box2d.createWorld();
  box2d.setGravity(0, 0);
  boundaries = new ArrayList<Boundary>();
  color boundariesColor = color(0, 0, 0);
  boundaries.add(new Boundary(width,height/2,5,height,0,boundariesColor));
  boundaries.add(new Boundary(0,height/2,5,height,0,boundariesColor));
  boundaries.add(new Boundary(0, 0,width*2,5,0,boundariesColor));
  boundaries.add(new Boundary(0, height-0,width*2,5,0,boundariesColor));
  
    ties = 0;
    stepsFromLastGoal = 0;
    steps = 0;
    goalsYellow = 0;
    goalsBlue = 0;
    recentlyRedy = false;
    
    smooth();
    mouseX = 500;
    mouseY = 500;
    robot = new Robot(244*2-250, 182*2, 90, 90, 2, 870.8, 364);
    robot1 = new Robot(244*2+250, 182*2, 0, 90, 2, 105.2, 364);
    createBlueGoal(105.2, 364);
    createYellowGoal(870.8, 364);
    createBall(random(100, 240*3), random(180, 180*3));
    
    


    
    
  }
  
  //robot1 -> right
  //robot -> left
  void draw(){
    
   for(int i = 0; i < 5; i++){
     //robot.move(20, 20, 0, 0);
    play(robot, 1, ball.getX(), ball.getY());
    float m = -(robot._y-ball.getY())/(robot._x-ball.getX());
    float angle = degrees(atan(m));
    if(robot._x-ball.getX() < 0){
     angle +=180; 
    }
    //println(m);
    //moveTo(ball.getX(), ball.getY(), angle, 2, 0.5, robot);
    box2d.step();
   }
   drawField();
    for (Boundary wall: boundaries) {
    wall.display();
  }
  robot.display();
  ball.display();
    
  }
  
  
  void play(Robot robot, float speed, float ballX, float ballY){
     float m = (robot._goalY-ballY)/(robot._goalX-ballX);
     float angle = degrees(atan(-m));
     float b = ballY-ballX*m;
     float l = 80;
     float redyX = ballX-l;
     float redyY = (ballX-l)*m+b;
     float allowedErrorX = 10;
     float allowedErrorY = 10;
     
     if(robot._goalX < robot._x){
       redyX = ballX+l;
       redyY = (ballX+l)*m+b;
     }
     if(ballX-robot._goalX < 0){
       angle+=180;
     }
     //println(angle);
     if(redyX > robot._x-allowedErrorX && redyX < robot._x+allowedErrorX && redyY > robot._y-allowedErrorY && redyY < robot._y+allowedErrorY)
       recentlyRedy = true;
     if(robot.holdsBall(ball.getX(), ball.getY())){
       moveTo(robot._goalX, robot._goalY, angle, speed, 2, robot);
       recentlyRedy = false;
       println("goal");
     }else if(!recentlyRedy){
       moveToAvoid(redyX, redyY, angle, speed, 2, robot, ballX, ballY);
       println("avoid to perfect");
   }else{
       moveTo(ballX, ballY, angle, speed, 2, robot);
       //recentlyRedy = false;
       println("go to ball");
     } 
    //println(robot.holdsBall(ballX, ballY));
  }
  
  

  
  
  
  void createBlueGoal(float x, float y){
    boundaries.add(new Boundary(x, y,29.6,240, 0,color(55, 94, 199)));
  }
  

  void createYellowGoal(float x, float y){
    boundaries.add(new Boundary(x, y,29.6,240, 0,color(234, 255, 36)));
  }
  
  void createBall(float x, float y){
    ball = new Ball(x, y, 7.4*4, color(120, 120, 190));
  }

  
  
  void moveTo(float x, float y, float theta, float speed, float speedOfRotation, Robot robot){
     theta = theta-90;
     float m = (y-robot._y)/(x-robot._x);
     float angle = degrees(atan(m))+45-robot._theta;
     if(x-robot._x < 0){
       //angle+=180;
     }
     angle = angle%360;
     //println(angle);
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
     float lastM = m;
      m = findMWithoutContact(robot._x, robot._y, m, ax, ay, 21*4);
     //println(degrees(atan(m))+"    " + degrees(atan(lastM)));
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
      m = tan((atan(-m)+15%360));
    }
    float upperM = m;
    m = startM;
    for(int i = 0; i < 360/15 && willContact(x0, y0, m, x1, y1, r); i++){
      m = tan((atan(-m)-15%360));
    }
    float lowerM = m;
    if(abs(startM-upperM) < abs(startM-lowerM)) return upperM;
    else return lowerM;
  }
  
  
  public void drawField(){
     background(58, 203, 82);
     fill(0, 102, 153);
     textSize(32);
     text("RoboCup Simulator", 10, 30); 
     

     stroke(255, 255, 255);
     
     line(120, 120, 856, 120);
     line(120, 120, 120, 608);
     line(856, 608, 856, 120);
     line(120, 608, 856, 608);
     
     stroke(0, 0, 0);
     
     line(240, 184, 240, 544);
     line(240, 184, 120, 184);
     line(240, 544, 120, 544);
     
     line(736, 184, 736, 544);
     line(736, 184, 856, 184);
     line(736, 544, 856, 544);
     noFill();
     ellipse(488, 364, 240, 240); 
    
    
  }
  
  
  
