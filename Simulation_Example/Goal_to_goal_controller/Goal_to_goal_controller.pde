  Robot robot;
  float a,b;
  
  void setup(){
    size(500, 500);
    robot = new Robot(250, 250, 0, 30, 3);
  }
  
  
  void draw(){
     moveTo(mouseX, mouseY);
    
  }
  
  
  void moveTo(float x, float y){
     float m = (y-robot._y)/(x-robot._x);
     float angle = degrees(atan(m))+45;
     if(x-robot._x < 0){
       angle+=180;
     }
     angle = angle%360;
     println(m);
     moveByAngle(angle, 0.8);
  }
  
  
  void moveByAngle(float angle, float speed)
  {
    float a = cos(radians(angle)) * speed;
    float b = sin(radians(angle)) * speed;
    robot.move(a, a, b, b); 
  }

