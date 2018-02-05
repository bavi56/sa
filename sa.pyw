#!/usr/bin/python3

"""

GUI rozhrani pro servisni analyzator.
Blind Pew 2017 <blind.pew96@gmal.com>
GNU GPL v3

"""

import sys
import serial
from serial.tools import list_ports
from tkinter import Tk, Canvas, Frame, Menu
import pygraf

APPNAME = "Servisní analyzátor - "
DPORT = '/dev/ttyUSB0' #defaultni port
BRATE= 115200 #rychlost komunikace - nemenit!

class MenuBar(Menu):
    """vytvoreni menu"""
    
    def __init__(self, parent):
        Menu.__init__(self, parent)
        
        #menu pro zmenu rychlosti obnoveni
        profilMenu = Menu(self)
        self.add_cascade(label="Profil", menu=profilMenu)
        profilMenu.add_command(label="CH1 : kolečko, CH2-CH4 : Foto", command=lambda: parent.setdelay((10,200,200,200)))
        profilMenu.add_command(label="CH1-CH4 : Foto - rychlé", command=lambda: parent.setdelay((200,200,200,200)))
        profilMenu.add_command(label="CH1-CH4 : Foto - pomalé", command=lambda: parent.setdelay((400,400,400,400)))
        profilMenu.add_command(label="Vlastní1 ---", command=lambda: parent.setdelay((400,400,400,400)))
        profilMenu.add_command(label="Vlastní2 ---", command=lambda: parent.setdelay((400,400,400,400)))
        profilMenu.add_separator()
        profilMenu.add_command(label="Exit", command=lambda: sys.exit(0))
        
        #menu pro vyber portu
        portMenu = Menu(self)
        self.add_cascade(label="Port", menu=portMenu)
        portMenu.add_command(label="Default: "+DPORT, command=lambda: parent.startcom(DPORT))
        portMenu.add_separator()
        for p in parent.ports:
            portMenu.add_command(label=p, command=lambda: parent.startcom(p))
        
        
class Sa(Frame):
    """hlavni program"""
        
    def setdelay(self, tms):
        """zmeni rychlost obnovovani grafu"""
        for i in range(len(tms)):
            self.grafy[i].delay = (tms[i])
        
    def lsport(self):
        """vytvori seznam dostupnych portu"""
        try:
            self.ports.append(list(list_ports.comports())[0][0])
        except IndexError:
            print("Prazdny seznam portu. Je analyzator pripojen?", file=sys.stderr)
    
    def startcom(self, port=None):
        """pripoji ser port"""
        if not port:
            try: #defaultni pripojeni
                self.ser = serial.Serial(DPORT, BRATE, timeout=0)
            except serial.SerialException:
                self.ser = serial.Serial()
                self.ser.baudrate = BRATE
                self.ser.timeout = 0
        else: #pozdejsi pripojeni
            try:
                self.ser.port = port
                self.ser.open()
            except serial.SerialException:
                print("Nelze otevřít: {0}".format(port), file=sys.stderr)
        if self.ser.is_open:
            self.parent.title(APPNAME + self.ser.port)
    
    def measure(self):
        """cteni dat"""
        if self.ser.is_open: #cti data jen kdyz je port otevren
            try:
                self.data = pygraf.Utils.byte2bool(int(ord(self.ser.read())))
                for i in range(len(self.grafy)):
                    self.grafy[i].buff(self.data[i])
            except:
                pass
        else:
            self.parent.title(APPNAME + "odpojen")
        self.after(1,self.measure)
    
    def __init__(self, parent):
        Frame.__init__(self, parent)
        self.ports = []
        self.lsport()
        self.parent = parent
        menubar = MenuBar(self)
        self.parent.config(menu=menubar)
        self.startcom()
        self.data = []
        self.platno = Canvas(self.parent,width=1004,height=412, background='black')
        self.grafy = (pygraf.DigitalGraf(self.platno, 2,2,1000,100, 'blue',200,'CH1'),
                        pygraf.DigitalGraf(self.platno,2,104,1000,100,'green',200,'CH2'),
                        pygraf.DigitalGraf(self.platno,2,206,1000,100,'red',200,'CH3'),
                        pygraf.DigitalGraf(self.platno,2,308,1000,100,'yellow',200,'CH4'))
        self.platno.pack()
        for graf in self.grafy:
            graf.run()
        self.measure()

root = Tk()
root.resizable(False, False)
root.title(APPNAME)
app = Sa(root)
app.mainloop()
