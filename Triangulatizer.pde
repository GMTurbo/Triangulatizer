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
//Capture camera= null;
ArrayList<String> images = new ArrayList<String>();
int imageIndex = 0;
int saveCount = 0;
boolean RunTriangles = false;
//GifMaker gifExport;

void setup(){
//
 
 //porn
 //images.add("http://25.media.tumblr.com/1e44f8f9788f94ffe5e525525234e851/tumblr_mhbifxtwSJ1rq6vz1o1_500.gif");
images.add("http://24.media.tumblr.com/tumblr_m826fmkpdP1qgu6fio1_500.jpg");
 images.add("http://24.media.tumblr.com/cc3bba07ab5c867cb2ad6c5c8ad63172/tumblr_mjgpnjHlEY1qjj0p8o1_500.gif");
 images.add("http://25.media.tumblr.com/12edf9036677111a8204da7dc6f18728/tumblr_mi4gg3hFIt1r1hjx6o1_500.gif");
 images.add("http://24.media.tumblr.com/3f078e1f669cd37d10f5889bd2bd6125/tumblr_mjdupxRdWl1rsnzy2o1_500.gif");
 images.add("http://24.media.tumblr.com/7224d114db902771521a3e4667ed19c2/tumblr_mjh725kZ6E1rlitlno1_500.gif");
 images.add("http://25.media.tumblr.com/9cbfef78b21c82126fda10cd6dd8d734/tumblr_mhhqjaAa3G1rwkc5bo1_400.gif");
 images.add("http://25.media.tumblr.com/c82b077207735dfe31a0c73f5c50662b/tumblr_mjijqvby5N1rn0oofo1_500.jpg");
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
 frameRate(5);
 
 //gifExport = new GifMaker(this, "export.gif");
 //gifExport.setRepeat(0);        // make it an "endless" animation
 //gifExport.setTransparent(255,255,255);  // black is transparent
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
      
      //if
      //(gifFrameCount == FRAMES.length-2 || !RunTriangles){
       // gifExport.finish();
       // RunTriangles = false;
      //}
  }
  
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
    //image(camera, 0, 0);
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
       imageIndex = abs(imageIndex) % (images.size());
       LoadImage(imageIndex);
       println(imageIndex);
     break;
     case RIGHT:
     ++imageIndex;
       imageIndex = abs(imageIndex) % (images.size());
       println(imageIndex);
       LoadImage(imageIndex);
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
      //cam = !cam;
      //if(camera == null)  camera = new Capture(this);
      //if( cam ) {camera.start(); frame.setSize(640, 480);}
      //else camera.stop();
    break;
    case 't': // toggle image
        ++imageIndex;
       imageIndex = abs(imageIndex) % (images.size());
       LoadImage(imageIndex);
       //insets = frame.getInsets();
       
    break;
  }
  println("resolution = " + resolution);
  
  
}

void LoadImage(int imageIndex){
  
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
   }
   
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
