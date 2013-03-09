import org.processing.wiki.triangulate.*;

PImage img;
ArrayList triangles = new ArrayList();
ArrayList points = new ArrayList();
int resolution = 10;
boolean run = true;

void setup(){
 img = loadImage("http://dl.dropbox.com/u/2493493/triangulateMe.jpg");
 size(700,497, P3D);
 //size(497 , 700);
 smooth();
 reset(); 
 frameRate(5);
 model();
}

void model(){
  for(int i = 0 ; i < width; i+=resolution)
    for(int j = 0 ; j < height; j+=resolution)
      if(random(0,1) > 0.5)
        points.add(new PVector(i, j, random(TWO_PI)));
     
  println("points added");
  triangles = Triangulate.triangulate(points);
}

void draw(){
  if(img == null || !run)
    return;
  background(255);
  pushMatrix();
  translate(img.width/2, img.height/2);
  rotate(radians(90));
  translate(-width/2, -height+45);
  image(img, 0, 0);
  popMatrix();
  reset();
  model();
  view();
}

void view(){
 // background(255);    
  noStroke();
  fill(70, 70, 250);
  
  // draw the points
  for (int i = 0; i < points.size(); i++) {
    PVector p = (PVector)points.get(i);
    ellipse(p.x, p.y, 2.5, 2.5);
  }
 
  // draw the mesh of triangles
  stroke(0, 40);
  noStroke();
  //fill(255, 40);
  beginShape(TRIANGLES);
  //texture(img);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    fill(get((int)((t.p1.x + t.p2.x + t.p3.x)/3f), (int)((t.p1.y + t.p2.y + t.p3.y)/3f)));
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
     break;
     case DOWN:
      resolution /= 2;
      if(resolution < 5)
        resolution = 5;
     break;
     default:
     break;
  } 
  switch(key){
   case 'r':
     run = !run;
    break; 
    case 's':
      save("triangulized.png");
    break;
  }
  println("resolution = " + resolution);
}

