import org.processing.wiki.triangulate.*;
import processing.video.*; 

//Movie myMovie;
PImage img;
ArrayList triangles = new ArrayList();
ArrayList points = new ArrayList();
int resolution = 3*4;
boolean run = true;
boolean cam = false;
Capture camera= null;
String[] images = new String[18];
int imageIndex = 0;
int saveCount = 0;
void setup(){
 
 images[0] = "https://dl.dropbox.com/u/2493493/Trianglize/witches.jpg";
 images[1] = "http://dl.dropbox.com/u/2493493/Trianglize/triangulateMeToo.jpg";
 images[2] = "http://dl.dropbox.com/u/2493493/Trianglize/triangulateMe.jpg";
 images[3] = "http://25.media.tumblr.com/176bac1e9da3496ffef9681e5202ee5a/tumblr_mgh8nsYSFU1r2lohvo1_500.jpg";
 images[4] = "http://24.media.tumblr.com/tumblr_lwsojdLUOq1qim4txo1_500.jpg";
 images[5] = "http://24.media.tumblr.com/8e436c09ad3ce0dfaff6bd0338cd66f5/tumblr_mgtz0wFwLQ1rig072o1_500.jpg";
 images[6] = "http://24.media.tumblr.com/tumblr_maav7vDiEg1rzo3hao1_500.jpg";
 images[7] = "http://24.media.tumblr.com/tumblr_me2yf7B1jn1qa2j0ao1_500.jpg";
 images[8] = "http://25.media.tumblr.com/tumblr_m90kfgaynm1qa4bk9o1_500.jpg";
 images[9] = "http://25.media.tumblr.com/744eb08ca4da1a1de16c7318f4af2b84/tumblr_mf47okfv3y1rl7ev3o1_500.jpg";
 images[10] = "http://24.media.tumblr.com/7b9848232d754545fee3116a9d3c77bb/tumblr_mj7t1zJ8as1r45uyro1_500.jpg";
 images[11] = "http://25.media.tumblr.com/ce7ccd5c0c5a9d47278dddcadb3f6098/tumblr_mj8e7f5jrY1r3olkxo1_500.jpg";
 images[12] = "http://24.media.tumblr.com/tumblr_meemhvnZ9w1qad7r7o1_500.jpg";
 images[13] = "http://24.media.tumblr.com/e667389f1e58b8e8d74ba025403c9df3/tumblr_mirjhiatTC1qfaf1fo1_500.jpg";
 images[14] = "http://25.media.tumblr.com/tumblr_md0epioYHo1rkvmpro1_500.jpg";
 images[15] = "http://25.media.tumblr.com/tumblr_ly716sdoFS1qla7y0o1_500.jpg";
 images[16] = "http://25.media.tumblr.com/4d72a1f881ba8d4efbdfbda7e8ce36b2/tumblr_mi5i8uEXgQ1r87i11o1_500.jpg";
 
 img = loadImage(images[imageIndex]);
 size(630,800, P3D);
 //size(497 , 700);
 smooth();
 reset(); 
 frameRate(5);
 model();
 
}

void captureEvent(Capture c) {
  c.read();
}

void model(){
  //int resolutionXStep = random(1,2) * resolution;
  //int resolutionYStep = random(1,2) * resolution;
  for(int i = 0 ; i < width; i+=random(0.5,5) * resolution)
    for(int j = 0 ; j < height; j+=random(0.5,5) * resolution)
      //if(random(0,1) >= 0.25)
        points.add(new PVector(i, j, random(TWO_PI)));
      //else{
        //points.add(new PVector(i+ random(0,resolution), j + random(0,resolution), random(TWO_PI)));
      //}
     
 // println("points added");
  triangles = Triangulate.triangulate(points);
}

void draw(){
  if(img == null || !run)
    return;
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
      img.resize(width, height);
       image(img, 0,0); 
    }
  }else{
    image(camera, 0, 0);
  }
  reset();
  //if(run){
    model();
    view();
  //}
  println("frame done");
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
      if( cam ) camera.start(); 
      else camera.stop();
    break;
    case 't': // toggle image
        ++imageIndex;
       imageIndex = imageIndex % (images.length - 1);
       println("imageIndex = " + imageIndex);
       img = loadImage(images[imageIndex]);
    break;
  }
  println("resolution = " + resolution);
}
