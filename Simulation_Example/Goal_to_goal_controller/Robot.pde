  public class Robot{
  public float _x;
  public float _y;
  public float _theta;
  final float _l;
  final float _r;
  Robot(float x, float y, float theta, float l, float r){
    _l = l;
    _r = r;
    _x = x;
    _y = y;
    _theta = theta%360;
    display();
  }
  public void display(){
    //translate(width/2,height/2);
    translate(_x, _y);
    background(255);
    stroke(0);
    fill(175);
    rectMode(CENTER);
    rotate(radians(_theta-45));
    rect(0, 0, 100, 30);
    rect(0, 0, 30, 100);
  }
  
  public void move(float s1, float s2, float s3, float s4){//speeds for each motor.
    //motor 1 is left up motor 2 is right down motor 3 is right motor 4 is left down
    _x += (_r/2)*(s1+s2) * cos(radians(_theta-45)) + (_r/2)*(s3+s4) * cos(radians(_theta+45));
    _y += (_r/2)*(s1+s2) * sin(radians(_theta-45)) + (_r/2)*(s3+s4) * sin(radians(_theta+45));
    _theta += (_r/_l) * (s1-s2) + (_r/_l) * (s3-s4);
    display();
  }
  
  
  public void update(float x, float y, float theta){
    new Robot(x, y, theta, _l, _r);
  }
  private float fixAngle(){
   if(_theta > 0) return _theta % 360; 
   else return 360-(_theta% 360) ; 
  }
  
  
   private void wait(float millis){
    float start = millis();
    while (millis()-start < millis){}
  }
  
  
}
