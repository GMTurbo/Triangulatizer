import org.processing.wiki.triangulate.*;
import processing.video.*; 
import gifAnimation.*;

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
//GifMaker gifExport;

void setup(){
  

  
 images.add("http://25.media.tumblr.com/tumblr_m95nyli2j51qc0s10o1_500.gif");
 images.add("http://24.media.tumblr.com/tumblr_m92uxpZjSa1qfrkf9o1_500.gif");
 
 images.add("http://25.media.tumblr.com/tumblr_m9unz6lhs01qkcsn8o1_500.gif");
 images.add("http://25.media.tumblr.com/tumblr_ls08k3Shm11qzq5nno1_1280.jpg");
 
 images.add("http://24.media.tumblr.com/2dba38da589e38788ada7164b676a8c9/tumblr_mj22k7ZDmN1qdwh13o1_400.gif");
 images.add("http://25.media.tumblr.com/1ad8d847af4085cf638e14a4e8146e1a/tumblr_mhcu9tx0bd1qzvx7mo1_500.gif");
 
 images.add("http://24.media.tumblr.com/d64ca51cafd5dfd64bc74af3f7b3855d/tumblr_miws4i0FBn1qax2qko1_500.gif");
 
 images.add("http://25.media.tumblr.com/15bc51bc7e3a0d918805c9de92bd1da3/tumblr_mia1fxiydl1s14nvmo1_400.gif");
 
 images.add("http://25.media.tumblr.com/7a05b55d6ef3005937d618686c25f17e/tumblr_miltj4E7zt1r2wuvao1_400.gif");
 images.add("http://24.media.tumblr.com/693afd7be5bb266842b6835a4ebeb30d/tumblr_mir5flOOKd1qdlh1io1_250.gif");
 
 if(images.get(imageIndex).indexOf(".gif") == -1){
         img = loadImage(images.get(imageIndex));
         gifRunning = false;
 }else{
         gifRunning = true;
         //myAnimation.stop();
         myAnimation = new Gif(this, images.get(imageIndex));
         myAnimation.play();
       }
 frame.setResizable(true);  
 size(630,800, P3D);
 
 //size(497 , 700);
 smooth();
 reset(); 
 frameRate(15);
 
 //gifExport = new GifMaker(this, "export.gif");
 //gifExport.setRepeat(0);        // make it an "endless" animation
 //gifExport.setTransparent(0,0,0);  // black is transparent
 
 model();
 
}

void captureEvent(Capture c) {
  c.read();
}

void model(){
  //int resolutionXStep = random(1,2) * resolution;
  //int resolutionYStep = random(1,2) * resolution;
  for(int i = 0 ; i < width; i+=random(0.5,5) * resolution){
    for(int j = 0 ; j < height; j+=random(0.5,5) * resolution){
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

void draw(){
  println(run ? "Running" : "Stopped");
  if(gifRunning) {
      img = myAnimation; 
      
  }
  if(img == null || !run)
    return;
    
  if(width != img.width || img.height != height)
       frame.setSize(img.width,img.height);
       
  background(255);
  if(!cam){
    /*if(imageIndex == 3){
      pushMatrix();
      translate(img.width/2, img.height/2);
      rotate(radians(90));
      translate(-width/2, -height+45);
      image(img, 0, 0);
      popMatrix();
    }else if(imageIndex == 2){
     pushMatrix();
      img.resize(width,height);
      translate(img.width/2, img.height/2);
      rotate(radians(90));
      translate(-width/2, -height+45);
      image(img, 0, 0);
      popMatrix();*/
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
     case ENTER:
       RunTriangles = !RunTriangles;
     break;
     default:
     break;
  } 
  switch(key){
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
         frame.setSize(img.width, img.height);
         gifRunning = false;
       }else{
        // myAnimation.stop();
         myAnimation = new Gif(this, images.get(imageIndex));
         myAnimation.play();
         gifRunning = true;
         frame.setSize(300, 200);
       }
       //insets = frame.getInsets();
       
    break;
  }
  println("resolution = " + resolution);
}
boolean gifRunning = true;
