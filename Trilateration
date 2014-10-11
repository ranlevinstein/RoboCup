import java.awt.Point;

Point p1;
Point p2;
Point p3;

void setup(){
  size(500, 500);
  p1 = new Point(0, 0);
  p2 = new Point(5, 4);
  p3 = new Point(2, 337);
  
}


double distance(Point p){
  return sqrt((mouseY-p.y)*(mouseY-p.y)+(mouseX-p.x)*(mouseX-p.x));
  
}

void calculate(Point p1, double d1, Point p2, double d2, Point p3, double d3){
        double i1=p1.x,i2=p2.x,i3=p3.x;
        double j1=p1.y,j2=p2.y,j3=p3.y;
        double x = ((2*(j3-j2)*((d1*d1-d2*d2)+(i2*i2-i1*i1)+(j2*j2-j1*j1)) - 2*(j2-j1)*((d2*d2-d3*d3)+(i3*i3-i2*i2)+(j3*j3-j2*j2)))/
                (4*((i2-i3)*(j2-j1)-(i1-i2)*(j3-j2))));
        double y = ((d1*d1-d2*d2)+(i2*i2-i1*i1)+(j2*j2-j1*j1)+x*2*(i1-i2))/(2*(j2-j1));
        println("("+(mouseX-x)+", "+(mouseY-y)+")");
        point((float)x, (float)y);
      }


void draw(){
  calculate(p1, distance(p1), p2, distance(p2), p3, distance(p3));
  
}
