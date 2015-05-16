class Circle extends Transformable {
  
  int _radius;
  
  public Circle(float x, float y, int r) {
    _position = new PVector(x, y);
    _radius = r;
    ellipseMode(RADIUS);
  }  
  
  
  public void draw_shape(){
    ellipse(0, 0, _radius, _radius);  
  }
  
  public boolean inside(int mx, int my) {    
    if(dist(mx, my, _position.x, _position.y) < _radius) return true;
    return false;
  }
  
};
