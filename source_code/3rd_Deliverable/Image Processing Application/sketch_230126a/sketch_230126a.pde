import TUIO.*;
TuioProcessing tuioClient;



float scale_factor = 1;
PFont font;
PImage img;

int imagewidth, imageheight; 
float zoom = 100;
boolean loadImage= false ;
float green=255;
float bright=255;
boolean verbose = true; 
boolean callback = true; 

void setup()
{

  size(900, 900);
  img = loadImage("alien.jpg"); 



  if (!callback) {
    frameRate(60);
    loop();
  } else noLoop(); 

  font = createFont("Arial", 20);
  tuioClient  = new TuioProcessing(this);
  imagewidth = img.width;
  imageheight = img.height;
}


void draw()
{
  background(255);
  textFont(font, 18*scale_factor);


  ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
  for (int i=0; i<tuioObjectList.size(); i++) {
    TuioObject tobj = tuioObjectList.get(i);


    if (tobj.getSymbolID()==0)
    {
      translate(tobj.getScreenX(width), tobj.getScreenY(height));
      imageMode(CENTER);
      image(img, 0, 0, imagewidth, imageheight);
    }



    if (loadImage)
    {
      if (tobj.getSymbolID()==1)
      {


        translate(tobj.getScreenX(width), tobj.getScreenY(height));
        rotate(tobj.getAngle());
      }
      
       if (tobj.getSymbolID()==2)
      {
        
        zoom =constrain(zoom +tobj.getRotationSpeed()*3, 10, 150 );
        imagewidth = int(img.width* zoom/70); 
        imageheight = int(img.height*zoom/70);
      }

      if (tobj.getSymbolID()==3)
      {
        
        green =map(tobj.getAngle(), 0, 6.2, 255, 0 );
        tint(255 , green , 255);
      }
        if (tobj.getSymbolID()==4)
      {
        
        bright =map(tobj.getAngle(), 0, 6.2, 255, 0 );
        tint(255,150);
        
    
      }
      
    }
  }
}

void addTuioObject(TuioObject tobj) {
  if (verbose) println("add obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
  if (tobj.getSymbolID()==0)
  {
    loadImage= true;
  }
}

void updateTuioObject (TuioObject tobj) {
  if (verbose) println("set obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
    +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

void removeTuioObject(TuioObject tobj) {
  if (verbose) println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
  if (tobj.getSymbolID()==0)
  {
    loadImage= false;
  }
  if (tobj.getSymbolID()==1)
  { 
     rotate(tobj.getAngle());
  }
  if (tobj.getSymbolID()==2)
  {
    imagewidth = img.width/2;
    imageheight = img.height/2;
  }
  if (tobj.getSymbolID()==3)
  {
    green = 255;  
    tint(255, green, 255);
  }
   if (tobj.getSymbolID()==4){
   
   bright = 255;
   tint(255, green, 255);
   }
  
}

void addTuioCursor(TuioCursor tcur) {
  if (verbose) println("add cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
}

void updateTuioCursor (TuioCursor tcur) {
  if (verbose) println("set cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
    +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
}

void removeTuioCursor(TuioCursor tcur) {
  if (verbose) println("del cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
}

void addTuioBlob(TuioBlob tblb) {
  if (verbose) println("add blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea());
}



void updateTuioBlob (TuioBlob tblb) {
  if (verbose) println("set blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea()
    +" "+tblb.getMotionSpeed()+" "+tblb.getRotationSpeed()+" "+tblb.getMotionAccel()+" "+tblb.getRotationAccel());
}

void removeTuioBlob(TuioBlob tblb) {
  if (verbose) println("del blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+")");
}

void refresh(TuioTime frameTime) {
  if (verbose) println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  if (callback) redraw();
}
