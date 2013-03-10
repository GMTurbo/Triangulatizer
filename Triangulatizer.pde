import org.processing.wiki.triangulate.*;
import processing.video.*; 
import gifAnimation.*;
import java.util.Collections;

//Movie myMovie;
PImage img;
Gif myAnimation;
ArrayList triangles = new ArrayList();
ArrayList points = new ArrayList();
int resolution = 3*4;
boolean run = true;
boolean cam = false;
Capture camera= null;
ArrayList<String> images = new ArrayList<String>();
int imageIndex = 0;
int saveCount = 0;
boolean RunTriangles = false;
GifMaker gifExport;

void setup(){
//
images.add("http://24.media.tumblr.com/d64ca51cafd5dfd64bc74af3f7b3855d/tumblr_miws4i0FBn1qax2qko1_500.gif");
 images.add("http://24.media.tumblr.com/e8b6069d637ead5e43df69e1b28318e7/tumblr_mj53peFukI1s79rl8o1_500.jpg");
 images.add("http://25.media.tumblr.com/b670405752d8c1f773472f497d3b9b70/tumblr_mh1ieelcJK1rk3dwvo1_400.gif");
 
 images.add("http://24.media.tumblr.com/600d6bb1bc8b07f9e686cb8e9c93c49b/tumblr_mfqdmn2X9r1rhzp74o1_500.jpg");
 images.add("http://24.media.tumblr.com/836a1e4c6c374792a95116384a575976/tumblr_meveg1mKSe1r87gdto1_500.gif");
 
 images.add("http://25.media.tumblr.com/tumblr_mec7fatw3C1rsl8k7o1_400.gif");
 images.add("http://25.media.tumblr.com/e1f27495a2b8ebb3018b00d26cb13a08/tumblr_mjgevbC6Ry1r95iqpo1_500.jpg");
 
 //porn
 images.add("http://25.media.tumblr.com/00dce68ce93e5921b6efe3b75ffc0ccb/tumblr_mjaeesWLfd1rsl8k7o1_400.gif");
 images.add("http://25.media.tumblr.com/f6e82a53e71e2f9c51998e67eaea25e7/tumblr_mhyh4gQdnR1rsjzk4o1_500.jpg");
 images.add("http://24.media.tumblr.com/tumblr_mavhmcWfT81ryul20o1_500.jpg");
 images.add("http://25.media.tumblr.com/6314479c2c31cf44962c042cc74b5c86/tumblr_mhnbh2weOO1qewuyto1_500.jpg");
 images.add("http://24.media.tumblr.com/tumblr_ltk5q490WB1qa3t46o1_500.jpg");
 images.add("http://24.media.tumblr.com/8e4b040a064110f179d1ab0f178fd8f8/tumblr_mg4vikKxPU1rpg9y6o1_500.jpg");
 images.add("http://24.media.tumblr.com/690f90e67209b1d14e3b6abdf5ab912b/tumblr_mf77b3k2ku1rm4e7wo1_250.gif");

 if(images.get(imageIndex).indexOf(".gif") == -1){
   
         img = loadImage(images.get(imageIndex));
         gifRunning = false;
         
 }else{
   
         gifRunning = true;
         
         //myAnimation.stop();
         myAnimation = new Gif(this, images.get(imageIndex));
         //myAnimation.play();
         FRAMES = myAnimation.getPImages();
         
 }
 
 frame.setResizable(true);  
 size(630,800, P3D);
 
 //size(497 , 700);
 smooth();
 reset(); 
 frameRate(12);
 
 gifExport = new GifMaker(this, "export.gif");
 gifExport.setRepeat(0);        // make it an "endless" animation
 gifExport.setTransparent(255,255,255);  // black is transparent
 gifFrameCount = 0;
 model();
 
}

void captureEvent(Capture c) {
  c.read();
}
PImage[] FRAMES;
void model(){
  //int resolutionXStep = random(1,2) * resolution;
  //int resolutionYStep = random(1,2) * resolution;
  for(int i = 0 ; i < width; i+= gifRunning ? random(0.5,2) * resolution : random(0.5,5) * resolution){
    for(int j = 0 ; j < height; j+= gifRunning ? random(0.5,2) * resolution : random(0.5,5) * resolution){
        points.add(new PVector(i, j, random(TWO_PI)));
      //  points.add(new PVector(width,i, random(TWO_PI))); 
    }
    points.add(new PVector(width,i, random(TWO_PI))); 
    
  }
       
   for(int i = 0 ; i < width; i+=2){
      points.add(new PVector(i,height, random(TWO_PI))); 
   }
   
   //for(int i = 0 ; i < height; i+=2){
    //  points.add(new PVector(width,i, random(TWO_PI))); 
  //r }
      
      //*/  
      //points.add(new PVector(i+ random(0,resolution), j + random(0,resolution), random(TWO_PI)));
      //}
     
 // println("points added");
  triangles = Triangulate.triangulate(points);
}

int gifFrameCount = 0;
boolean saveGIFFrame = false;

void draw(){
  println(run ? "Running" : "Stopped");
  if(gifRunning) {
     // println("Gif f #: " + gifFrameCount);
      img = FRAMES[gifFrameCount];
      gifFrameCount++;
      gifFrameCount = gifFrameCount % FRAMES.length;
      if(saveGIFFrame){
        println("Saving gif..");
        saveFrame("gif" + gifFrameCount);
        //gifExport.setDelay(100);
        //gifExport.addFrame(img);
        //println("saving gif frame " + gifFrameCount);
      }else if(!saveGIFFrame && !savedAlready){
        println("gif saved");
       //gifExport.finish(); 
       savedAlready = true;
      }
      
      //if
      //(gifFrameCount == FRAMES.length-2 || !RunTriangles){
       // gifExport.finish();
       // RunTriangles = false;
      //}
  }
  if(img == null || !run)
    return;
    
  if(width != img.width || img.height != height)
       frame.setSize(img.width,img.height);
       
  background(255);
  if(!cam){
    if(imageIndex==0){
     //img.resize(width, height);
     image(img, 0,0); 
    }else{
      //img.resize(width, height);
       image(img, 0,0); 
    }
  }else{
    image(camera, 0, 0);
  }
  reset();
  if(run && RunTriangles){
    model();
    view();
  }
  
}

void view(){
 // background(255);    
  noStroke();
  fill(70, 70, 250);
  
  // draw the points
  /*for (int i = 0; i < points.size(); i++) {
    PVector p = (PVector)points.get(i);
    ellipse(p.x, p.y, 2.5, 2.5);
  }
 */
  // draw the mesh of triangles
  stroke(0, 40);
  noStroke();
  //fill(255, 40);
  beginShape(TRIANGLES);
  //texture(img);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    fill(get(round((t.p1.x + t.p2.x + t.p3.x)/3f), round((t.p1.y + t.p2.y + t.p3.y)/3f)));
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  
  endShape();
  //println("draw loop finished");
}

void reset(){
  //println("points cleared");
  points.clear();
  triangles.clear();
}

void mouseClicked(){
  reset();
  model();
}

void keyPressed(){
  switch(keyCode){
     case UP:
       resolution *= 2;
       if(resolution > min(width, height))
         resolution = min(width, height);
     break;
     case DOWN:
      resolution /= 2;
      if(resolution < 2)
        resolution = 2;
     break;
     case LEFT:
     --imageIndex;
       if(imageIndex == -1)
         imageIndex = images.size();
       imageIndex = imageIndex % (images.size());
     break;
     case RIGHT:
     ++imageIndex;
       imageIndex = imageIndex % (images.size());
     break;
     case ENTER:
       RunTriangles = !RunTriangles;
       gifFrameCount = 0;
     break;
     default:
     break;
  } 
  switch(key){
    case 'e':
    saveGIFFrame = true;
    gifFrameCount = 0;
    break;
   case 'r': // stop animation
     run = !run;
    break; 
    case 's': // save screenshot
      save("triangulized" + (saveCount++) + ".png"); 
    break;
    case 'c': // toggle webcam
      cam = !cam;
      if(camera == null)  camera = new Capture(this);
      if( cam ) {camera.start(); frame.setSize(640, 480);}
      else camera.stop();
    break;
    case 't': // toggle image
        ++imageIndex;
       imageIndex = imageIndex % (images.size());
       println("imageIndex = " + imageIndex);
       if(images.get(imageIndex).indexOf(".gif") == -1){
         img = loadImage(images.get(imageIndex));
         //frame.setSize(img.width, img.height);
         gifRunning = false;
       }else{
        // myAnimation.stop();
         myAnimation = new Gif(this, images.get(imageIndex));
         FRAMES = myAnimation.getPImages();
         gifFrameCount = 0;
         gifRunning = true;
         //frame.setSize(300, 200);
         
       }
       //insets = frame.getInsets();
       
    break;
  }
  println("resolution = " + resolution);
  
  
}
boolean savedAlready = true;
void keyReleased(){
  if(saveGIFFrame){
    saveGIFFrame = false; 
    //gifExport = new GifMaker(this, "export" + (saveCount++) + ".gif");
    //gifExport.setRepeat(0);        // make it an "endless" animation
    //gifExport.setTransparent(0,0,0);  // black is transparent
    savedAlready = false;
  }
}
boolean gifRunning = true;
