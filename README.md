# Simple HomePod USB / UART Adapter 
This is a forked / modified repo of el1ng's and tihmstar's homepod adapters. I've modified them to fit different test probes, since the E2 probes tend to poke holes. 

Also included is my table stand. This can be used as a base to sit your homepod on when upside-down, to prevent scratches on the plastic top. It can also be used to protect the dongle when homepod is placed upright, to support USB Airplay (since the adapter will stick out the bottom and not let the HomePod sit flat on a table)

I sell both of these if you don't want to try making them yourself: https://nicsfix.com/shop

## You Will Need
* 4x M2x6 screws; to screw the adapter plate to the bottom of the homepod. You can tape it down if it is secure. The point is a SECURE connection. The screws that hold the circular plastic frame on top of the logic board work perfectly if you have any spares.
* Pogo pins / test probes (P75-B1 or P75-E2)
* USB cable to solder to test probes
* If using UART, spare wire to solder to UART test probes, and a USB to **1.8v** UART serial adapter.


# Making It
I hosted a livestream making some adapters if you want some visual reference, not really a guide: https://www.youtube.com/watch?v=fxdIzLTcSnA

Download the .stl file depending on which probes you can get / have, load it into your preferred slicer, with the homepod side of the dongle facing up, and with support. Then print it!

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
 
For the B1 probes, to avoid melting the 2d printed plastic adapter, solder wires to the pins, _then_ insert them into the adapter. Make sure they have a good solder connection, otherwise the USB connection will be very unstable or will not work at all.

If you're using the E2 probes, you won't be able to fit the probbes in with wires attached, so you'll have to insert the pins into the adapter first, then solder the wires onto them. Minimize the amount of time you are heating the pins to avoid melting the plastic adapter


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

First-generation Apple HomePods have Airplay capability over USB. This is still Airplay, with all it's pros / cons, just over USB. 

Observations so far:
* Only seems to work on Macs
* Only seems to work if the HomePod is already set-up. Does not work on a HomePod in Setup Mode
* Does not seem to work if the HomePod was configured as a Default Output for an Apple TV
* Can play to multiple HomePods via USB (plus other Airplay 2 speakers)(using "Airfoil" by Rogue Amoeba)
* Stereo pairs (i.e. playing to a stereo pair pod via USB does not transmit to it's paired pod. Can still use Airfoil for multiple)
* USB Ethernet adapters, even powered ones, by themselves do not appear to work with the HomePod.
* Possibility of updates breaking / removing this functionality in the future...


To use, you need to make or buy a USB adapter for your pod. Whatever you end up doing to get USB access to your HomePod will most likely stick out the bottom, so you need to raise the base of the pod to prevent damage to the adapter or debug port when placing it upright on a table. 

Video Demos:
* https://twitter.com/UnbendableStraw/status/1836576917077790951
* https://twitter.com/UnbendableStraw/status/1836848399997620624
* https://youtube.com/live/Je3FnzLNufg

# Give Up?

You can buy premade adapters, stands, and docks here https://nicsfix.com/shop

