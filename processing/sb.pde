/*
 * Simple class Tlacitko
 * Blind Pew 2016 GNU GPL v3
 * blind.pew96@gmail.com
 * 
*/

class Tlacitko {
  float xpos,ypos,xsize,ysize;
  boolean stav, enable;
  String popisek;
  
  Tlacitko(float x_p, float y_p, float x_s, float y_s, String t) {
    xpos = x_p;
    ypos = y_p;
    xsize = x_s;
    ysize = y_s;
    stav = false;
    enable = true;
    popisek = t;
  }
  
  void povoleni(boolean x) {
    enable = x;
  }
  
  void uvolnit() {
    stav = false;
  }
  
  boolean zakryto() {
    if(mouseX > xpos && mouseX < xpos+xsize && mouseY > ypos && mouseY < ypos+ysize && enable) {
      stav = true;
      return true;
    }
    else {
      stav = false;
      return false;
    }
  }
 
 void kresli() {
   if(stav) {
     fill(180);
     stroke(250);
     rect(xpos,ypos,xsize,ysize);
     stroke(50);
     strokeWeight(2);
     line(xpos,ypos,xsize+xpos,ypos);
     line(xpos,ypos,xpos,ysize+ypos);
     fill(0);
     strokeWeight(1);
     textAlign(CENTER, CENTER);
     textSize(10);
     text(popisek,xpos+(xsize/2),ypos+(ysize/2));
   }
   else {
     fill(180);
     stroke(250);
     rect(xpos,ypos,xsize,ysize);
     stroke(50);
     strokeWeight(2);
     line(xpos+xsize,ypos+ysize,xsize+xpos,ypos);
     line(xpos,ypos+ysize,xpos+xsize,ypos+ysize);
     if(enable) {
       fill(0);
     }
     else {
       fill(120);
     }
     strokeWeight(1);
     textAlign(CENTER, CENTER);
     textSize(10);
     text(popisek,xpos+(xsize/2),ypos+(ysize/2));
   }
 }  
}
