class Transformable {
  
  // attaributes
  PVector _position;
  float   _rotation;
  float   _scale;
  
  // constructor (without arguments)
  public Transformable() {
    _position = new PVector(0, 0);
    _rotation = 0;
    _scale = 1.0;
  }
  
  // constructor (with arguments)
  public Transformable(int x, int y) {
    _position = new PVector(x, y);
    _rotation = 0;
    _scale = 1.0;    
  }
  
  /////////////////////////////////
  // (absolute) transforms
  
  public void rotate_to(float r) {
    _rotation = r;
  }
  
  public void translate_to(float x, float y) {
    _position.x = x;
    _position.y = y;
  }
  
  public void scale_to(float s) {
    _scale = s;
  }
  
  ///////////////////////////////////
  // (incremental) transforms
  
  public void rotate_increment(float r) {
    _rotation += r;
  }
  
  public void translate_increment(float x, float y) {
    _position.x += x;
    _position.y += y;
  }
  
  public void scale_increment(float s) {
    _scale += s;
  }
  
  ///////////////////////////////////
  // display method
  // + applies transformations
  // + draws shape of the subclass 
  
  public void display() {
    pushMatrix();
    translate(_position.x, _position.y);
    rotate(_rotation);        
    scale(_scale);
    draw_shape();
    popMatrix();
  }
  
  ///////////////////////////////////
  // helper method - distance_from 
  // + computes distance from other position 
  
  public float distance_from(int x, int y) {
    return dist(_position.x, _position.y, x, y);
  }
  
  ///////////////////////////////////
  // ** METHODS FOR SUBCLASSES **
  
  
  // draws a (subclass) shape (in own coordinates)
  public void draw_shape(){}
  
  // evaluates if mx and my are inside the (subclass) shape 
  public boolean inside(int mx, int my){return false;}
  
};
