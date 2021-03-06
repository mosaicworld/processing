// artistic statement
// using interaction to rotate shapes, suggest colors, and randomize scale
// 1 when the user clicks the mouse, a starter square will be drawn
// 2 afterward, if the user drags the mouse from the left to the right, the square will be
// rotated by a factor of 5 degrees
// 3 if the user drags the mouse from the right to the left, a smaller set of squares will be
// drawn and rotated (no fill)
// 4 if the user presses a keyboard key (not 's' or 'S'), the scale of the unfilled squares
// will be changed (observed when dragging the mouse from right to left again)
// 5 if the user presses the 's' or 'S' key, the current image will be saved as 
// "screenshot.png" in the Processing project

// global vars
  int count_mouse_press, image_count;
  int[] mouse_loc;
  float scale_x, scale_y;  

// setup
  void setup() {
    size(800, 800);
    background(#ffffff);
    colorMode(HSB, width, height, 100);
    count_mouse_press = 0;
    mouse_loc = new int[2];
    scale_x = 0.7;
    scale_y = 0.7;
    image_count = 0;  
  }

// drawing
  void draw() {

    // waits until mouse pressed to draw on canvas 
    if (mousePressed == true) {
      count_mouse_press++;
      mouse_loc[0] = mouseX;
      mouse_loc[1] = mouseY;
      
      //rectMode(CENTER);
      pushMatrix();
      translate(width/2, height/2);
      rotate(radians(45));
      rect(0, 0, int(width*(0.3)), int(height*(0.3)));
      popMatrix();       
    }
    
    if (keyPressed == true) {
      if (key != 's' && key != 'S') {
        //background(random(mouseX), random(mouseY), 180, 50);
        scale_x = random(1.5);
        scale_y = random(1.5);
      }    
    }
    
  }
  
  void mouseDragged() {
    if (mouseX > mouse_loc[0]) {
      //println("mouseX: " + mouseX + " ; mouse_loc[0]: " + mouse_loc[0]); 
      
      stroke(random(mouseX), random(mouseY), 100);
      fill(random(mouseX), random(mouseY), 100, 100);
      pushMatrix();
      translate(width/2, height/2);
      rotate(radians(5) * (mouseX - mouse_loc[0]));
      rect(0, 0, int(width*(0.3)), int(height*(0.3)));
      popMatrix();      
      
    } else {
      
      noFill();
      stroke(random(mouseY*2), random(mouseX*2), 150);
      pushMatrix();
      translate(width/2, height/2);
      scale(scale_x, scale_y);
      rotate(radians(5) * (mouseX - mouse_loc[0]));
      rect(0, 0, int(width*(0.3)), int(height*(0.3)));
      popMatrix();      
      
    }
  }
  
  void mouseMoved() {
    //background(random(mouseX), random(mouseY), 180, 50);
  }
  
  void keyPressed() {
    if (key == 's' || key == 'S') {
      save();
    } 
  }
  
  // enhances the saveFrame() function by appending a date and timestamp to the saved image file name
  // this prevents overwriting previously saved frames (unless you save more than one frame per second
  void save() {  

    String fileName;
    String s = String.valueOf(image_count%5);     
    fileName = "screenshot" + s + ".png"; 
    saveFrame(fileName);
    println("image_count before increment: " + image_count);
    image_count++;    
  }

