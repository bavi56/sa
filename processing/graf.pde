//Plny graf
class GrafPlny {
  int lmin,lmax,dilku,inc_d,t_size;
  float xpos,ypos,xsize,ysize;
  float[] level;
  color bck,frg,ink;
  boolean auto;
  
  //konstruktor
  GrafPlny(float x_p, float y_p, float x_s,float y_s, color barva,int nula, int maximum) { //vytvori novy graf
    xpos = x_p;  //souradnice noveho grafu
    ypos = y_p;
    xsize = x_s;  //velikost noveho grafu
    ysize = y_s;
    level = new float[int(xsize)]; //vytvori pole o delce sire grafu
    dilku = 15;  //kolik dilku chci mit na stupnici
    inc_d = 1;
    bck = 250;  //barva pozadi
    frg = 0;    //barva popredi
    ink = barva;  //barva grafu
    t_size = 10;  //velikost pisma
    auto = false;
    if(maximum > 0) {
      lmin = nula;
      lmax = maximum;
    }
    else {
      auto = true;
    }
    
  }
  
  void kresli(float l) {
    textAlign(LEFT, BASELINE);
    strokeWeight(1);
    noStroke();
    fill(bck);
    rect(xpos,ypos,xsize,ysize);
    
    if(auto) {
      //urceni min-max hodnoty pro graf
      if(l < lmin) lmin = round(l);
      if(l > lmax) lmax = round(l);
    }
    //posunuti pole o jednu hodnotu zpet (vytvori misto pro novou hodnotu)
    for (int i = 1; i < level.length; i++) {
      level[i-1] = level[i];
    }
    level[level.length-1] = l; //na posledni mmisto prida novou hodnotu
    
    //vykresli cely graf
    for (int i = 0; i < level.length; i++) {
      float yg = map(level[i],lmin,lmax,ypos+ysize,ypos);
      stroke(ink);
      line(i+xpos,ypos+ysize,i+xpos,yg);
    }
    //vykresli stupnici
    fill(bck);
    stroke(frg);
    rect(xpos,ypos,50,ysize);
    stroke(frg);
    if(lmax > dilku) {
      inc_d = lmax/dilku;
    }
    else {
      inc_d = 1;
    }
    for (int i = lmin; i < lmax; i +=inc_d) {
      float ydilek = map(i,lmin,lmax,ypos+ysize,ypos);
      line(xpos+30,ydilek,xpos+50,ydilek);
      for (float x = xpos+50; x < xpos+xsize; x +=5) {
        point(x,ydilek);
      }
      fill(frg);
      textSize(t_size);
      text(floor(i),xpos+5,ydilek-1);
      
    }
    
    //zobrazeni aktualni hodnoty
    fill(bck);
    stroke(ink);
    rect(xpos+xsize-130,ypos+5,120,40);
    fill(frg);
    textSize(30);
    text(l,xpos+xsize-130,ypos+35);
    
    noFill();
    stroke(frg);
    //ram
    rect(xpos,ypos,xsize,ysize);
    
  }
}




//cara
class Graf {
  int lmin,lmax,dilku,inc_d,t_size;
  float xpos,ypos,xsize,ysize;
  float[] level;
  color bck,frg,ink;
  boolean auto;
  
  //konstruktor
  Graf(float x_p, float y_p, float x_s,float y_s, color barva,int nula, int maximum) { //vytvori novy graf
    xpos = x_p;  //souradnice noveho grafu
    ypos = y_p;
    xsize = x_s;  //velikost noveho grafu
    ysize = y_s;
    level = new float[int(xsize)]; //vytvori pole o delce sire grafu
    dilku = 15;  //kolik dilku chci mit na stupnici
    inc_d = 1;
    bck = 250;  //barva pozadi
    frg = 0;    //barva popredi
    ink = barva;  //barva grafu
    t_size = 10;  //velikost pisma
    auto = false;
    if(maximum > 0) {
      lmin = nula;
      lmax = maximum;
    }
    else {
      auto = true;
    }
    
  }
  
  void kresli(float l) {
    textAlign(LEFT, BASELINE);
    strokeWeight(1);
    noStroke();
    fill(bck);
    rect(xpos,ypos,xsize,ysize);
    
    if(auto) {
      //urceni min-max hodnoty pro graf
      if(l < lmin) lmin = round(l);
      if(l > lmax) lmax = round(l);
    }
    //posunuti pole o jednu hodnotu zpet (vytvori misto pro novou hodnotu)
    for (int i = 1; i < level.length; i++) {
      level[i-1] = level[i];
    }
    level[level.length-1] = l; //na posledni mmisto prida novou hodnotu
    float xg_p = 0;
    float yg_p = 0;
    //vykresli cely graf
    for (int i = 0; i < level.length; i++) {
      float xg = map(i, 0, level.length,xpos,xsize);
      float yg = map(level[i],lmin,lmax,ypos+ysize,ypos);
      if((xg_p == 0) && (yg_p == 0)) {
        xg_p = xg;
        yg_p = yg;
      }
      stroke(ink);
      line(xg_p,yg_p,xg,yg);
      xg_p = xg;
      yg_p = yg;
    }
    //vykresli stupnici
    fill(bck);
    stroke(frg);
    rect(xpos,ypos,50,ysize);
    stroke(frg);
    if(lmax > dilku) {
      inc_d = lmax/dilku;
    }
    else {
      inc_d = 1;
    }
    for (int i = lmin; i < lmax; i +=inc_d) {
      float ydilek = map(i,lmin,lmax,ypos+ysize,ypos);
      line(xpos+30,ydilek,xpos+50,ydilek);
      for (float x = xpos+50; x < xpos+xsize; x +=5) {
        point(x,ydilek);
      }
      fill(frg);
      textSize(t_size);
      text(floor(i),xpos+5,ydilek-1);
    }
    
    //zobrazeni aktualni hodnoty
    fill(bck);
    stroke(ink);
    rect(xpos+xsize-130,ypos+5,120,40);
    fill(frg);
    textSize(30);
    text(l,xpos+xsize-130,ypos+35);
    
    
    noFill();
    stroke(frg);
    rect(xpos,ypos,xsize,ysize);
    
  }
}





//vrati vysku grafu
float vyska_y(boolean stav, float sirka, float offset) {
  
  if(stav) {
    return (sirka/2)+offset;
  }
  else {
    return (sirka/1.1)+offset;
  }
}

class Digital {
  long ts_up, ts_dw;
  float xpos,ypos,xsize,ysize;
  boolean[] level;
  color bck,frg,ink;
  String msg;
  
  //kostruktor
  Digital(float x_p, float y_p, float x_s,float y_s, color barva) { //vytvori novy graf
    xpos = x_p;  //souradnice noveho grafu
    ypos = y_p;
    xsize = x_s;  //velikost noveho grafu
    ysize = y_s;
    level = new boolean[int(xsize)/5]; //vytvori pole o delce sire grafu/5
    //level = new boolean[500];
    bck = 250;  //barva pozadi
    frg = 0;    //barva popredi
    ink = barva;  //barva grafu
    msg = "ms";
    
  }
  void kresli(boolean l) {
    textAlign(LEFT, BASELINE);
    strokeWeight(1);
    noStroke();
    fill(bck);
    rect(xpos,ypos,xsize,ysize);
    
    for (int i = 1; i<level.length; i++) {
      level[i-1] = level[i];
    }
    
    //mereni doby
    if(!level[level.length-2] && l) {
      ts_up = millis();
    }
    if(level[level.length-2] && !l) {
      ts_dw = millis();
      msg = str(int(ts_dw - ts_up))+"ms";
    }
    level[level.length-1] = l; //prida posledni
    
    float xg = 0;
    float yg = 0;
    float xg_p = 0;
    float yg_p = 0;
    
    boolean zmena = false;
    //nakresleni grafu
    for (int i = 1; i < level.length; i++) {
      if(zmena) {
        xg_p = map(i-2, 0, level.length, xpos, xsize);
        zmena = false;
      }
      else {
        xg_p = map(i-1, 0, level.length, xpos, xsize);
      }
      xg = map(i, 0, level.length, xpos, xsize);
      
      //vyska
      yg_p = vyska_y(level[i-1],ysize,ypos);
      yg = vyska_y(level[i],ysize,ypos);
      
      stroke(ink);
      if(level[i-1] != level[i]) {
        xg = xg_p;
        zmena = true;
      }
      line(xg_p,yg_p,xg,yg);
    }
    
    //zobrazeni casu ms
    fill(bck);
    stroke(ink);
    rect(xpos+xsize-140,ypos+5,130,40);
    fill(frg);
    textSize(30);
    text(msg,xpos+xsize-140,ypos+35);
    
    
    noFill();
    stroke(frg);
    rect(xpos,ypos,xsize,ysize);
  }
}