  import fisica.*;
  public class Robot{
  FWorld _world;
  FPoly _poly;
  
  public float _x;
  public float _y;
  public float _theta;
  final float _l;
  final float _r;
  PApplet _obj;
  Robot(float x, float y, float theta, float l, float r, FWorld world, PApplet obj){
    _obj = obj;
    _world = world;
    _l = l;
    _r = r;
    _x = x;
    _y = y;
    
    _theta = theta%360;
    display();
  }
  public void display(){
    /*//translate(width/2,height/2);
    translate(_x, _y);
    background(255);
    stroke(0);
    fill(175);
    rectMode(CENTER);
    rotate(radians(_theta-45));
    rect(0, 0, 100, 30);
    rect(0, 0, 30, 100);*/
    _poly = new FPoly();
    _poly.setPosition(_x, _y);
    _poly.setRotatable(true);
    //_poly.setRotation(_theta);
    _poly.setStrokeWeight(3);
    _poly.setFill(120, 30, 90);
    _poly.setDensity(10);
    _poly.setRestitution(0.5);
    _poly.vertex(-22, -38);
    _poly.vertex(22, -38);
    _poly.vertex(44, 0);
    _poly.vertex(22, 38);
    _poly.vertex(13.5, 25.5);
    _poly.vertex(-13.5, 25.5);
    _poly.vertex(-22, 38);
    _poly.vertex(-44, 0); 
    if (_poly!=null) _world.add(_poly);
    background(255);
      
     _world.step();
     _world.draw(_obj);  

     if (_poly != null) {
       _poly.draw(_obj);
     }
  }
  
  public void move(float s1, float s2, float s3, float s4){//speeds for each motor.
    //motor 1 is left up motor 2 is right down motor 3 is right motor 4 is left down
    float dx = (_r/2)*(s1+s2) * cos(radians(_theta-45)) + (_r/2)*(s3+s4) * cos(radians(_theta+45));
    float dy = (_r/2)*(s1+s2) * sin(radians(_theta-45)) + (_r/2)*(s3+s4) * sin(radians(_theta+45));
    float dTheta = (_r/_l) * (s1-s2) + (_r/_l) * (s3-s4);
    //_x += (_r/2)*(s1+s2) * cos(radians(_theta-45)) + (_r/2)*(s3+s4) * cos(radians(_theta+45));
    //_y += (_r/2)*(s1+s2) * sin(radians(_theta-45)) + (_r/2)*(s3+s4) * sin(radians(_theta+45));
    //_theta += (_r/_l) * (s1-s2) + (_r/_l) * (s3-s4);
    //display();
     drawField();
    _poly.setVelocity(dx, dy);
    _poly.setAngularVelocity(dTheta);
    _world.step();
    _world.draw(_obj);  
     
     if (_poly != null) {
       _poly.draw(_obj);
     }
     _x = _poly.getX();
     _y = _poly.getY();
     _theta = degrees(_poly.getRotation());
     println(_theta);
     //_theta = _poly.getRotation();
  }
  
  
  public void update(float x, float y, float theta){
    new Robot(x, y, theta, _l, _r, _world, _obj);
  }
  private float fixAngle(){
   if(_theta > 0) return _theta % 360; 
   else return 360-(_theta% 360) ; 
  }
  
  
   private void wait(float millis){
    float start = millis();
    while (millis()-start < millis){}
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
  
  
}
