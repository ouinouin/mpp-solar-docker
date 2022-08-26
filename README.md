This image intends to ease the setup of the mpp-solar utility : [mpp-solar](https://github.com/jblance/mpp-solar).\
For now the image is launched with --daemon argument, since the ultimate purpose is to run continuously mpp-solar and publish via mqtt for example.\
I did a few trials to integrade the bluetooth stuff but its a complicated matter.\
Avices welcome to make bluetooth operate on a docker container.

i use it in combination with docker-compose : 
```
version: '3.3'  
services:  
    mpp-solar:  
        privileged: true  
        volumes:  
            - '/dev:/dev:rw'  
            - './mpp-solar.conf:/etc/mpp-solar.conf'  
        container_name: mpp-solar  
        image: 'mpp-solar:0.1-debian-stable'  
```
And here is an example of my mpp-solar.conf for an Axpert/voltronic/superwatt/choosewhateverrebrandednameyoulike inverter\
Note that since the serial ports numbering can be very confsing in a setup with /dev/ttyUSB0 1 2 3 4 5 and /dev/ttyACM0 1 2 3 i use the /dev/serial/by-id links. \
to know the correspondance just do a ls -las /dev/serial/by-id and you will see the symbolic link to the ttyUSBxx corresponding.\
while using the serial port as i m using on the inverter (i use the serial port with an isolated converted just in case) , you can also create a volume in the volumes secion of docker-compose.yaml :
```
# syntax is host: guest
volumes : 
     -'/dev/TTYUSB1:/dev/ttymyinverter
```
then you can refer /dev/ttymyinverter in mpp-solar.conf, like this if you fiddle with the serial port , you just have to change the docker-compose file since inside the container the serial port will always be name /dev/ttymyinverter.

```
[SETUP]
pause=10 
mqtt_broker=blacknuc.lan
mqtt_port=1883

[voltronic_mpp_qpigs]

protocol=PI30MAX
port=/dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A10KUS6Z-if00-port0 
baud=2400        
command=QPIGS
tag=TagName       
outputs=json_mqtt
porttype=serial 

[voltronic_mpp_qmod]

protocol=PI30MAX
port=/dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A10KUS6Z-if00-port0
baud=2400
command=QMOD
tag=TagName
outputs=json_mqtt
porttype=serial
```
