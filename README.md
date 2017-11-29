# wireless-switch
Wifi-enabled relay that can be controlled with UDP packets.

## Hardware requirements
Required components:
 * Weemos D1 mini ![Image of Weemos D1 Mini](https://wiki.wemos.cc/_media/products:d1:d1_mini_v2.3.0_1_16x9.jpg "Image of Weemos D1 Mini") from https://www.wemos.cc/
 * A Relay Shield for the Weemos D1 mini ![Image of Weemos D1 Mini Rlay Shield](https://wiki.wemos.cc/_media/products:d1_mini_shields:relay_v1.0.0_1.jpg "Image of Weemos D1 Mini Reley Shield") from https://www.wemos.cc/
 * 2 pieces of 8x1 Pin headers with 0.1'' pitch.
 * Modified power cable for the device that you want to switch. The power line has to be split in two and fitted into the Relay's screw terminals.
 * To run the finished wireless switch, you need a power supply. 5V DC coming out of a micro USB B device plug will work.

 To solder the pieces together you need solder wire with flux and a solder iron.

 To upload the firmware to the microcontroller you need
 * A USB cable with a micro B device plug
 * A computer running some flavor of Linux

To use the switch, you will need some WLAN capable device that can send UDP datagrams over the network. A computer with a wireless network interface will do.

## Setting up the Hardware
Solder the Weemos D1 mini and its Relay Shield
together using the two 8x1 pin headers. Make sure to connect the respective contacts with the same labels on both devices.

## Software
I use the NodeMCU Lua software to program the ESP8266 microcontroller on the Weemos D1 mini. You can retrieve the necessary firmware from https://nodemcu-build.com/. This is a service for building custom combinations of the available firmware modules. For this project, the modules
* file
* GPIO
* net
* node
* timer
* UART
* WiFi

are required.
To upload the firmware to the board, you can use the NodeMCU-pyflasher https://github.com/marcelstoer/nodemcu-pyflasher.
To upload the lua files ap.lua and init.lua to the board, you can use the Esplorer tool https://esp8266.ru/esplorer/#download. Be sure to select 115200 Baud rate in both tools.
Also make sure to change the wireless password to your liking in file ap.lua before uploading the file to the Weemos D1 mini.

## Usage
Reset the Weemos D1 mini. On your computer, search for the wireless network "MyWirelessSwitch" (if you have not changed the SSID) and connect to it using the password. Because the Weemos D1 mini does not provide DHCP in this setup, you will have to manually select a static IP for this network connection. Give your computer the IP 192.168.4.2. Do not fill out DNS and Gateway, this network does not have these.

Open a terminal, and change the state of the relay with the commands

`echo -n on | nc -u -w 1 192.168.4.1 47728`

`echo -n off | nc -u -w 1 192.168.4.1 47728`

## Using multiple Switches
If you have multiple switches, having a separate access point for every switch is overkill. You can modify the source code to connect switches to an existing wireless network as clients, and assign a different IP address to each switch controller.
