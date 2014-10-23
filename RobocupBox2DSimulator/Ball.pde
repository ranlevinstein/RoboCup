


class Ball{
  
  float x;
  float y;
  float r;
  color c;
  Body body;
  
  Ball(float _x, float _y, float _r, color _c){
    x = _x;
    y = _y;
    r = _r;
    c = _c;
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(new Vec2(x, y)));
    body = box2d.createBody(bd);

    CircleShape circle = new CircleShape();
    circle.m_radius = box2d.scalarPixelsToWorld(7.4*2);
    Vec2 offset = new Vec2(0,0);
    offset = box2d.vectorPixelsToWorld(offset);
    circle.m_p.set(offset.x,offset.y);
    FixtureDef fd = new FixtureDef();
      fd.shape = circle;
    fd.density = 40f;
    fd.friction = 0.8f;        
      fd.restitution = 0.8f;

    body.createFixture(fd);
  }
  
  
  
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    fill(175);
    stroke(0);
    ellipse(0, 0, 7.4*4, 7.4*4);
    popMatrix();
  }
  
  float getX(){
    return box2d.getBodyPixelCoord(body).x;
  }
  
  float getY(){
    return box2d.getBodyPixelCoord(body).y;
  }
  
  
  
}
