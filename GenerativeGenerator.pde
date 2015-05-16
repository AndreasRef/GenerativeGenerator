ArrayList<Transformable> elements = new ArrayList<Transformable>(); //Arraylist

//Transformable t; 
Oscillator osc = new Oscillator(1, 3, 0.01);

boolean showCircles = true;
float randRange;
float strokeRange;
float sizeRange;
float driftSpeedX, driftSpeedY;
color backgroundColor = #C0DEF7; 


import controlP5.*;

ControlP5 cp5;

ListBox l;
int cnt = 0;
int listBoxVal = 0;

String[] drawMode = {
  "Random", "Drift", "Drift+Random ", "Circles+Random", "Drift towards mouse"
}; 


void setup() {
  size(displayWidth, displayHeight);
  cp5 = new ControlP5(this);

  // add listbox
  ControlP5.printPublicMethodsFor(ListBox.class);
  l = cp5.addListBox("myList")
    .setPosition(20, 50)
      .setSize(120, 120)
        .setItemHeight(15)
          .setBarHeight(15)
            //.setColorBackground(color(255, 128))
            .setColorActive(color(0))
              .setColorForeground(color(255, 100, 0))
                ;

  l.captionLabel().toUpperCase(true);
  l.captionLabel().set("Move pattern");

  l.captionLabel().style().marginTop = 3;
  l.valueLabel().style().marginTop = 3;

  for (int i=0; i<drawMode.length; i++) {
    ListBoxItem lbi = l.addItem(drawMode[i], i);
  } 
  
  cp5.addSlider("lineStroke")
    .setPosition(20, height-80)
      .setSize(200, 20)
        .setRange(0, 255)
          .setValue(10)
            ;
  
  cp5.addSlider("randomSlider")
    .setPosition(350, height-80)
      .setSize(200, 20)
        .setRange(0, 15)
          .setValue(3)
            ;

  cp5.addSlider("sizeSlider")
    .setPosition(650, height-80)
      .setSize(200, 20)
        .setRange(0, 5)
          .setValue(1)
            ;
            
    cp5.addSlider("driftSpeedX")
    .setPosition(900, height-80)
      .setSize(100, 20)
        .setRange(-5, 5)
          .setValue(1)
            ;            
            
   cp5.addSlider("driftSpeedY")
    .setPosition(1100, height-80)
      .setSize(100, 20)
        .setRange(-5, 5)
          .setValue(1)
            ;        

}



void draw() {
  if (showCircles) {
    background(backgroundColor);
  }



  float scaler = osc.update();
  
  scaler*= sizeRange;

  for (int i = 0; i < elements.size (); i ++) {
    Transformable t = elements.get(i);
    PVector _random = new PVector(random(-randRange, randRange), random(-randRange, randRange));

    switch(listBoxVal) {
    case 0: //Random
      t.translate_increment(int(_random.x), int(_random.y));
      break;
      
    case 1: // Drift
      t.translate_increment(driftSpeedX, driftSpeedY);
      break;
    
    case 2: // Random + drift
     t.translate_increment(driftSpeedX+_random.x, driftSpeedY+_random.y);
      break;  

    case 3: // Circles + drift
       t.translate_increment(random(0,_random.x)*sin(frameCount/100.0), random(0, _random.x)*cos(frameCount/100.0));
      break;    
      
    case 4: // Drift towards mouse
       PVector mouse = new PVector(mouseX,mouseY);
       PVector dir = PVector.sub(mouse,t._position);  // Find vector pointing towards mouse
       dir.normalize();     // Normalize
       t.translate_increment(dir.x, dir.y);
       //t.translate_increment(random(0,_random.x)*sin(frameCount/100.0), random(0, _random.x)*cos(frameCount/100.0));
      break;    

    }

    t._position.x = constrain(t._position.x, 0, width);
    t._position.y = constrain(t._position.y, 0, height-120);
    //t.rotate_increment(radians(3));
    t.scale_to(scaler);
    if (showCircles) {
      t.display();
    }
  }

  if (showCircles == false) {
    stroke(0, strokeRange);
  }
  //Lines between every (overlapping) circle
  for (int i = 0; i < elements.size ()-1; i++) {
    for (int j = elements.size ()-1; j > 0; j--) {
      if (dist(elements.get(i)._position.x, elements.get(i)._position.y, elements.get(j)._position.x, elements.get(j)._position.y)<40*scaler) {
        line(elements.get(i)._position.x, elements.get(i)._position.y, elements.get(j)._position.x, elements.get(j)._position.y);
      }
    }
  } 

  stroke(20);
  noFill();
}

void mousePressed() {
  if (mouseY<height-100 && mouseX > 150) {
    Transformable t;

    t = new Circle(mouseX, mouseY, 20);
    elements.add(t);
  }
}
void keyPressed() {
  if (key == '1') {
    background(backgroundColor);
    showCircles =! showCircles;
  } 

  if (key == '2') {
    for (int i = elements.size ()-1; i >= 0; i--) {
      elements.remove(i);
    }
  }
}


void controlEvent(ControlEvent theEvent) {

  if (theEvent.isGroup()) {
    // you need to check the Event with
    // if (theEvent.isGroup())
    // to avoid an error message from controlP5.
    //println(theEvent.group().value()+" from "+theEvent.group());
  }

  if (theEvent.isGroup() && theEvent.name().equals("myList")) {
    listBoxVal = (int)theEvent.group().value();
    println(listBoxVal);
  }
}


void randomSlider(float theRandRange) {
  randRange = theRandRange;
}

void lineStroke(int thestrokeRange) {
  strokeRange = thestrokeRange;
}

void sizeSlider(float theSizeRange) {
  sizeRange = theSizeRange;
}

void driftSpeedX(float thedriftSpeedX) {
  driftSpeedX = thedriftSpeedX;
}

void driftSpeedY(float thedriftSpeedY) {
  driftSpeedY = thedriftSpeedY;
}
