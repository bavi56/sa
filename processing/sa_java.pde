import processing.serial.*;

Serial sa;

Digital ch1;
Digital ch2;
Digital ch3;
Digital ch4;

GrafPlny a1;
GrafPlny a2;
GrafPlny a3;

Tlacitko tl_analog;
Tlacitko tl_digital;

int pozadi = 210;
int vyska_tlac = 20;
int vyska_kanalu = 0;
int vyska_analog = 0;
int space = 2;
boolean digital = false;

int kanalu = 4;
char data;
long[] millis_last = {0,0,0,0};
int[] interval = {20,200,200,200};

long millis_last_analog = 0;
int interval_analog = 100;
int[] proudmA = {0,0,0};
String data_analog;

color cervena = color(230,0,0);
color zelena = color(0,230,0);
color modra = color(0,0,230);
color zluta = color(230,230,0);

void setup() {
  size(1200,600);
  frameRate(120);
  printArray(Serial.list());
  if(digital) {
    surface.setTitle("Digitální režim");
  }
  else {
    surface.setTitle("Analogový režim");
  }
  
  sa = new Serial(this, Serial.list()[4], 115200);
  
  vyska_kanalu = ((height-vyska_tlac)/kanalu)-kanalu*space;
  vyska_analog = ((height-vyska_tlac)/3)-3*space;
  
  ch1 = new Digital(space,space,width-(2*space),vyska_kanalu,modra);
  ch2 = new Digital(space,vyska_kanalu+2*space,width-(2*space),vyska_kanalu,zelena);
  ch3 = new Digital(space,2*vyska_kanalu+3*space,width-(2*space),vyska_kanalu,cervena);
  ch4 = new Digital(space,3*vyska_kanalu+4*space,width-(2*space),vyska_kanalu,zluta);
  
  a1 = new GrafPlny(space,space,width-(2*space),vyska_analog,modra,0,5);
  a2 = new GrafPlny(space,vyska_analog+2*space,width-(2*space),vyska_analog,zelena,0,5);
  a3 = new GrafPlny(space,2*vyska_analog+3*space,width-(2*space),vyska_analog,cervena,0,5);
  
  tl_analog = new Tlacitko(space,height-vyska_tlac-5,100,vyska_tlac,"Analog >>");
  tl_digital = new Tlacitko(100,height-vyska_tlac-5,100,vyska_tlac,"Digital >>");
  
}

void draw() {
  
  if(digital) { //digitalni rezim
      
    //prijem dat
    if(sa.available() >0) {
      data = sa.readChar();
    }
    
    for(int i = 0; i < kanalu; i++) {
      if(millis() - millis_last[i] > interval[i]) {
        switch(i) {
          case 0:
            ch1.kresli(boolean(data >> i & 1));
            break;
          case 1:
            ch2.kresli(boolean(data >> i & 1));
            break;
          case 2:
            ch3.kresli(boolean(data >> i & 1));
            break;
          case 3:
            ch4.kresli(boolean(data >> i & 1));
            break;
        }
        //aktualozace casoveho razitka
        millis_last[i] = millis();
      }
    }
    
  }
  else { //analogovy rezim
  
    //prijem dat
    if(sa.available() >0) {
      data_analog = sa.readStringUntil(10);
      if(data_analog != null) {
        proudmA = int(split(data_analog,';'));
        //printArray(proudmA);
      }
    }
    //kresleni grafu
    if(millis() - millis_last_analog > interval_analog) {
      a1.kresli(float(proudmA[0])/1000);
      a2.kresli(float(proudmA[1])/1000);
      a3.kresli(float(proudmA[2])/1000);
      millis_last_analog = millis();
    }
    
  }
  tl_digital.kresli();
  tl_analog.kresli();
}

void mousePressed() {
  if(tl_analog.zakryto()) {
    sa.write("A\n");
    digital = false;
    tl_digital.povoleni(true);
    tl_analog.povoleni(false);
    surface.setTitle("Analogový režim");
  }
  if(tl_digital.zakryto()) {
    sa.write("D\n");
    digital = true;
    tl_analog.povoleni(true);
    tl_digital.povoleni(false);
    surface.setTitle("Digitální režim");
  }
}

void mouseReleased() {
  tl_analog.uvolnit();
  tl_digital.uvolnit();
  background(pozadi);
}