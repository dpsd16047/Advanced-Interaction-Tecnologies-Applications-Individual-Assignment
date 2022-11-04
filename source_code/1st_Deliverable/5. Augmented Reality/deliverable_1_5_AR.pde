import processing.video.*;
import jp.nyatla.nyar4psg.*;

Capture cam;
MultiMarker nya;
Movie myMovie;
void setup() {
  size(640,480,P3D);
  colorMode(RGB, 100);
  println(MultiMarker.VERSION);
  cam=new Capture(this,640,480);
  nya=new MultiMarker(this,width,height,"camera_para.dat",NyAR4PsgConfig.CONFIG_PSG);
  nya.addARMarker("patt.hiro",80);
  cam.start();
  myMovie = new Movie(this, "myvideo.mp4");
  myMovie.loop();
  myMovie.play();
}

void draw()
{
  if (cam.available() !=true) {
      return;
  }
  cam.read();
  nya.detect(cam);
  background(0);
  nya.drawBackground(cam);
  
  if((!nya.isExist(0))){
    return;
  }
  
  nya.beginTransform(0);
  scale(0.1,0.1,1);
  rotateZ(PI);
  translate(0,0,20);
  image(myMovie, -330, -160, 850, 650);
  nya.endTransform();
}

void movieEvent(Movie m) {
  m.read();
}
