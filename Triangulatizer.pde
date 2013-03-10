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

 images.add("http://25.media.tumblr.com/tumblr_m73ia9nHPf1qetdhio1_500.gif");
 images.add("http://25.media.tumblr.com/tumblr_mck3wyHKz01resjnxo1_400.gif");
 images.add("http://25.media.tumblr.com/e0602877ad2251f0f8d7179b06deb700/tumblr_mf6pvxUHU01rsq9eyo1_r2_500.gif");
 images.add("http://24.media.tumblr.com/tumblr_m8cmoeTpk21r3smugo1_500.gif");
 images.add("http://25.media.tumblr.com/tumblr_m9sj257BHv1qdoqhwo1_250.gif");
 images.add("http://24.media.tumblr.com/tumblr_mc5kc4DqZM1rr442mo1_r3_250.gif");
 images.add("http://24.media.tumblr.com/tumblr_lxv4o5rNbS1qefm89o3_500.gif");
 images.add("http://25.media.tumblr.com/tumblr_mcvrskTPj01r9ms9mo1_250.gif");
 images.add("http://24.media.tumblr.com/tumblr_mdzd6bFPcq1qassaoo1_500.gif");
 images.add("http://25.media.tumblr.com/tumblr_mcto2mkniR1qg39ewo1_500.gif");
 images.add("http://25.media.tumblr.com/tumblr_mcmc9gPjCj1r6esiso1_250.gif");
 images.add("http://25.media.tumblr.com/tumblr_m2gkcq0d5J1qc10j6o1_250.gif");
 images.add("http://25.media.tumblr.com/tumblr_mcmtevAmsj1qeumowo1_500.gif");
 images.add("http://25.media.tumblr.com/tumblr_m92a7knkEY1qe6mn3o1_400.gif");
 images.add("http://25.media.tumblr.com/tumblr_lvdpaykuNW1r4zr2vo1_r4_500.gif");
 images.add("http://25.media.tumblr.com/tumblr_m8ph0g0Xqu1qzy0ygo1_1280.gif");
 images.add("http://25.media.tumblr.com/tumblr_m8ph0g0Xqu1qzy0ygo4_1280.gif");
 images.add("http://24.media.tumblr.com/tumblr_m8gg2yolcP1qlolyqo1_500.gif");
 images.add("http://24.media.tumblr.com/tumblr_m7a2s4Akm81qc0cxpo1_500.gif");
 
 images.add("http://25.media.tumblr.com/tumblr_mcxfzmOoai1rcmfhmo1_250.gif");
 images.add("http://25.media.tumblr.com/tumblr_m9gw12l0OY1r4zr2vo1_r1_500.gif");
 images.add("http://24.media.tumblr.com/ebd1336e26321408a2bc0bc7c0dd0076/tumblr_mhvsbsIJxz1s1f4sxo1_500.gif");
 images.add("http://25.media.tumblr.com/75608fd46e3ea44eb96cb948275a1edc/tumblr_mhiuffDHsA1qg7sdjo1_400.gif");
 images.add("http://24.media.tumblr.com/043b1c88a0c6742f277b63d2bb92fed8/tumblr_mi0xy8dBaw1qg39ewo1_500.gif");
 images.add("http://25.media.tumblr.com/fe4f2d997f246ae65dcf28f0ee3fd1de/tumblr_mevn1acZPF1qj73e2o1_500.gif");
 images.add("http://25.media.tumblr.com/5a4be317a0f1bc8cc97a50094b9348b6/tumblr_mh3qgwLJag1qfjvexo1_500.gif");
 images.add("http://25.media.tumblr.com/019af60da338fa6291d68b0fedefbd47/tumblr_mh3j5tbkwN1qiuoc0o1_500.gif");
 images.add("http://25.media.tumblr.com/90eefe212136f9fbf4983618ecb7a314/tumblr_mh8357hIzs1r260qwo1_500.gif");
 images.add("http://25.media.tumblr.com/fc467f30c4ee22e5e07dac0a71860e6f/tumblr_mh1yoewPmH1qb2ullo1_250.gif");
 images.add("http://24.media.tumblr.com/e98b3b34401474914867c4d77fa558f6/tumblr_mhge22yEfi1r5vp1oo1_500.gif");
 images.add("http://24.media.tumblr.com/tumblr_m11c49Jl4H1r0mbpqo1_500.gif");
 images.add("http://24.media.tumblr.com/36569e6741758340fd6063f091f06421/tumblr_mgceyk5Y1z1s29mkao1_400.gif");
 images.add("http://25.media.tumblr.com/b71afc497a968bcc5fdf0ed823ea17a2/tumblr_mh2091tmYL1qfkp3oo1_1280.jpg");
 images.add("http://24.media.tumblr.com/tumblr_mbc2z6R6L91r4zr2vo1_r1_500.gif");
 images.add("http://25.media.tumblr.com/063845b0a1b8dcc8465287bbf79627ee/tumblr_mgy71iG19f1qit0qco1_400.gif");
 images.add("http://25.media.tumblr.com/b9bc2bd4a820590227209c48c9d315fd/tumblr_mf795m25dt1qzmm04o1_1280.jpg");
 images.add("http://25.media.tumblr.com/tumblr_mehl5vbm1D1qh8o2eo1_500.gif");
 images.add("http://24.media.tumblr.com/ee41c4e93f305890d27695ddd043c795/tumblr_mgsf3selUP1qjwiuoo1_500.gif");
 images.add("http://25.media.tumblr.com/004d09af9281c01596e035d4e57302e0/tumblr_mglda1i0XH1qcpu1mo1_500.gif");
 images.add("http://24.media.tumblr.com/ea55a31b4e7f45efd28dcd72b85c71f0/tumblr_mgskjtG5Je1rb8tmvo1_r1_500.gif");
 images.add("http://24.media.tumblr.com/3368cabe247b839520b3c121bf810af4/tumblr_mgl047PCDw1rm4a7jo1_500.gif");
 images.add("http://24.media.tumblr.com/835a50cfc521024c17bbe964bc9a8d5f/tumblr_mggqlhRUWX1qhzzuvo1_400.gif");
 images.add("http://24.media.tumblr.com/tumblr_m90rx1aXKc1qi23vmo1_500.gif");
 images.add("http://25.media.tumblr.com/c2878f7eba42aa2f4fabbf3278f09d12/tumblr_mg51nt2LjC1r4atx9o1_500.gif");
 images.add("http://25.media.tumblr.com/3301a13ac3fcadfba8ccb2d6682e7701/tumblr_mfrq1sONTe1rp04tto1_500.gif");

  Collections.reverse(images);
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
