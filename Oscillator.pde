class Oscillator {
  float _step, _theta;
  float _min, _max, _length;
  
  public Oscillator(float min, float max, float step) {
    _min = min;
    _max = max;
    _length = max - min;
    _step = step;
    _theta = 0;
  }
  
  public float update() {
    _theta += _step;
    return ((sin(_theta)*_length/2) + _length/2 + _min); 
  }
  
}
