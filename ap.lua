-- This file creates a Wireless Access point, waits for UDP packets
-- and controls a relay.

-- Wireless access point configuration
cfg={}
cfg.ssid="MyWirelessSwitch"
cfg.pwd="Choose a password wisely."

-- The password is the only thing that prevents unauthorized control
-- of your switch.  Choose a good password!

-- Set up the access point
wifi.setmode(wifi.SOFTAP)
wifi.ap.config(cfg)

-- print out the access point config. Default IP is 192.168.4.1
print(wifi.ap.getip())
print(wifi.ap.getmac())

-- The Weemos D1 mini Relay is controlled through Pin D1
pin=1

-- Choose a UDP port where switch control packets are received.
port=47728

-- Setup the Relay pin for writing
gpio.mode(pin, gpio.OUTPUT)

-- Initialize to the desired default value.  The switch is initially
-- set to "off".
gpio.write(pin, gpio.LOW)

-- set up the UDP server socket
srv=net.createServer(net.UDP)

-- Register callback to execute when a packet is received.
srv:on("receive", function(srv, p)
   -- debugging message
   print("Command Received")

   -- if the message is "on", then turn on the relay, else off
   if p=="on" then gpio.write(pin, gpio.HIGH) else gpio.write(pin, gpio.LOW) end
   end)
   
-- begin to wait for packets.
srv:listen(port)
