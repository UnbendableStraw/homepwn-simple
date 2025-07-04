# Simple HomePod USB / UART Adapter 
This is a forked / modified repo of el1ng's and tihmstar's homepod adapters. I've modified it to fit different test probes since the E2/B1 probes tend to poke holes. I reverted the shape  of the adapter back to a circle. The alignment tabs are now properly aligned and enabled. The screw holes are now properly lined up. The location of the pin holes also needed slight tweaking, and by widening the width of the pin box it makes a perfect fit!

Also included is my table stand. This can be used as a base to sit your homepod on when upside-down, to prevent scratches on the plastic top. It can also be used to protect the dongle when homepod is placed upright, to support USB Airplay (since the adapter will stick out the bottom and not let the HomePod sit flat on a table)

I sell both of these if you don't want to try making them yourself: https://nicsfix.com/shop

## You Will Need
* 4x M2x6 screws; to screw the adapter plate to the bottom of the homepod. You can tape it down if it is secure. The point is a SECURE connection. The screws that hold the circular plastic frame on top of the logic board work perfectly if you have any spares.
* Pogo pins / test probes (I recommend P75-D2 or P75-J1, I do not recommend the E2 or B1 needle probes, they will poke holes in your pads)
* USB cable to solder to test probes
* If using UART, spare wire to solder to UART test probes, and a USB to **1.8v** UART serial adapter. Recommended to use an adapter with a genuine FTDI chip, like the "DSD TECH SH-U09C5".


# Making It
I hosted a livestream making some adapters if you want some visual reference, not really a guide: https://www.youtube.com/watch?v=fxdIzLTcSnA

Download the Table_Dock_v1.1.1, load it into your preferred slicer, with the homepod side of the dongle facing up, and with support. Then print it!

As shown in the livestream, push the pins into the adapter until the tube of the pogo pin is flush with the adapter.

The pinout of the HomePod's debug port, with the pod upside down, and you looking down at the port, is as follows:

```
                AC PORT
                  ^
                  
| NC | TX | RX | CTRL | D+ | D- | GND |
| NC | NC | NC | GND  | NC | NC | NC  |
```
![pinout](debug.jpg)

For USB and restoring software, you only need four probes connected to +5v, D+, D-, GND. 

For UART, you need two more probes on the TX and RX, and one for GND. You can share the same GND from the USB line, or another marked GND pad, all the GND pads are internally connected. This is ONLY 1.8v! 3.3 or 5v can cause damage.
 
If you're using probes like the E2 probes, you won't be able to fit the probes in with wires attached, so you'll have to insert the pins into the adapter first, then solder the wires onto them. 




# Using It

You can use this adapter to restore a software bricked first generation HomePod via the restore guide: https://github.com/UnbendableStraw/homepod-restore/

You can also look at the UART console to possibly identify hardware failures preventing the software from operating. To do so;
1. Find your USB UART adapter's address with

`ls /dev/cu.*`

2. "Screen" into your adapter (probably using baud rate 115200) with this, where `tty.usbserial-1` is the adapter you got from the previous command

`screen /dev/tty.usbserial-1 115200`

Tip: You can output your UART logs to a file while still being able to see the logs as they happen. After you enter your screen command, hit control-a, then H. It will output a screenlog.0 file you can rename to .txt

# Warning

If the wrong pins on your adapter touch the wrong pads on the homepod while there is power, it can cause hardware damage. Avoid by simply disconnecting power and usb from pod before removing the adapter from pod.

# USB Airplay for A1639 Apple HomePods

First-generation Apple HomePods can be connected via USB to a Mac and function as a local "USB" Airplay 2 Speaker. This is still Airplay, with all it's pros / cons, just over USB. The HomePod / Mac appear to be creating a virtual network adapter over the USB connection. 

Observations / limitations so far:
* Only seems to work on Macs
* Only seems to work if the HomePod is already set-up. Does not work on a HomePod in Setup Mode
* Does not seem to work if the HomePod is configured as a "Default Output" for an Apple TV
* Needs at least least HomePod Version 14.0? 13.X did not work, so I assume older versions also won't work
* Can play to multiple HomePods via USB using "Airfoil" by Rogue Amoeba (plus other Airplay 2 speakers.) 
* Connecting a stereo-paired HomePod via USB will only play audio to the USB HomePod
* USB Ethernet adapters, even powered ones, by themselves do not appear to work with the HomePod.
* You can turn off all of your wireless radios and it will still work since this is all over the USB cable. 
* Your HomePod's WiFi can be completely dead and this will still work, if your HomePod is already configured.

To use, you need to make or buy a USB adapter for your pod. Whatever you end up doing to get USB access to your HomePod will most likely stick out the bottom, so you need to raise the base of the pod to prevent damage to the adapter or debug port when placing it upright on a table. I have 3d printable adapters and stands you can make or buy here: https://github.com/UnbendableStraw/homepwn-simple/

Video Demos:
* https://twitter.com/UnbendableStraw/status/1836576917077790951
* https://twitter.com/UnbendableStraw/status/1836848399997620624
* https://youtube.com/live/Je3FnzLNufg

Unknowns:
* Can we get a Mac bridge the connection to the rest of your network?
* Can we get it working on Windows / Linux? 
* Can we get _any_ ethernet adapter to work with this?
* Will updates break / remove this in the future?

# Give Up?

You can buy premade adapters, stands, and docks here https://nicsfix.com/shop

