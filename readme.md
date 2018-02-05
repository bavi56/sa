# Servisní analyzátor s arduino Nano

* 8x 24V digitalni vstup
* 3x analogový vstup pro SCT013

## Firmware

[arduino Nano](./sa.ino)

Odkomentovat pro čitelný výpis do serial monitoru:
```c++
#define DEBUG
```

Seznam součástek [zde](./eagle/partlist.txt).

![](./img/schema.png?raw=true "Schéma")

![](./img/deska.png?raw=true "Deska")

![](./img/sa2.png?raw=true "Strana soucastek")

![](./img/sa3.png?raw=true "Strana spoju")

![](./img/sa.png?raw=true "Sestaveno")


## Zobrazení

* ### processing [zde](./processing/sa_java.pde)

![](./img/sa_java_scr.png?raw=true "Processing")

* ### python [zde](./sa.pyw) (potřeba stáhnout modul [pygraf](../../pygraf/pygraf.py) a mít nainstalovaný tkinter)

![](./img/sa_scr.png?raw=true "SaPy")
