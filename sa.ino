/*Firmware pro servisni analyzator verze 1
 * 8x 24V digitalni vstup
 * 3 analogove (prevodnik proudovy transformator SCT013 www.yhdc.com (0-5A -> 0-1V))
 * Blind Pew <blind.pew96@gmail.com> 2016 GNU GPL v3
 */

//#define DEBUG
#define BRATE 115200
#define MIN_ADC 0
#define MAX_ADC 1023
#define MIN_ANALOG  0
#define MAX_ANALOG  5000
#ifdef DEBUG
  #define DELAY_DIGITAL 1000
  #define DELAY_ANALOG 1000
#else
  #define DELAY_DIGITAL 5
  #define DELAY_ANALOG  50
#endif
 
byte ovlByte = 0;
bool digital = true;  //rezim true - digitalni | false - analogovy
byte digPins[] = {5,6,7,8,9,10,11,12}; //24V vstupy 
byte anaPins[] = {A0,A1,A2};  //proudove vstupy
byte stav;  //byte 24V vstupu

void setup() {
  Serial.begin(BRATE);
  for(int i=0;i<sizeof(digPins);i++) {
    pinMode(digPins[i],INPUT_PULLUP);
  }
}

void loop() {
  if(Serial.available() > 0) {
    ovlByte = Serial.read();
    if(ovlByte == 'D') digital = true;
    if(ovlByte == 'A') digital = false;
  }
  
  if(digital) {
    for(int i=0;i<8;i++) {
      bitWrite(stav,i,!digitalRead(digPins[i]));
      #ifdef DEBUG
        Serial.print(!digitalRead(digPins[i]));
      #endif
    }
    #ifdef DEBUG    
      Serial.print("-->>");
      Serial.println(stav);
    #else
      Serial.write(stav);
    #endif
    delay(DELAY_DIGITAL);
  }
  else {
    for(int i=0;i<3;i++) {
      Serial.print(map(analogRead(i),MIN_ADC,MAX_ADC,MIN_ANALOG,MAX_ANALOG));
      Serial.print(";");
    }
    Serial.println("");
    delay(DELAY_ANALOG);
  }
}
