<h1 align="center">3D Printer Control Hub</h1>
<p align="center">Setup guide for creating a Raspberry Pi EMS Printer Control Hub leveraging Octoprint</p> 


### Table of Contents  
* [Installing Raspbian](#raspbian)
* [Installing EMS](#ems)
* [Generating Credential Environment Variables](#credentials)
* [Running the Edge MicroServer](#run) 
---
Following this guide on a fresh install of Raspbian will allow the user to connect their Octoprint instance to Thingworx using a RemoteThing. From there we can build mashups to securey monitor
our printer's information from anywhere without worrying about port forwarding. 



Instead of hosting an image, we are going to go through the steps to download a fresh image onto the Raspberry Pi. 

1. You will need to download the Raspberry Pi Imager and flash the 32-Bit Raspbian OS onto a new SD card. 
<br>

<p align="center">
  <img src="https://github.com/PTC-Education/RPi-EdgeMicroserver/blob/main/3D%20Printer%20Control%20Hub/raspbian-32bit.png" />
</p>

2. After flashing your drive, boot up your Raspberry Pi on a monitor so that you are able to access the graphical user interface. From here connect to your wifi network in order to download a few external packages

For the first package we are going to download the Edge MicroServer from the [Edge MicroServer Download](https://developer.thingworx.com/resources/guides/thingworx-raspberry-pi-quickstart) link. The download is locked within the Thingworx Developer Portal, so you will need to make an account and find the download link inside. We are going to drag this folder once downloaded into our documents on the Raspberry Pi. 

3. Now that you have the EMS downloaded we need to load our app keys and Thingworx host information into our environment variables so that they will be accessible to all python scripts. Included in this repository is a bash script, setup.sh, that will be run as 

```bash
source setup.sh
```

By running this script you will be prompted to enter your Thingworx, Onshape, and Octoprint credentials. These credentials will be persistently stored in your environment variables, but you will need to close out of your current terminal window for changes to take effect. 

---
<a name="properties"/>
