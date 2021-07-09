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

---
<a name="raspbian"/>

## Installing Raspbian
Instead of hosting a precompiled image, we are going to go through the steps to build your own custom image on the Raspberry Pi.

You will need to download the Raspberry Pi Imager and flash the 32-Bit Raspbian OS onto a new SD card. After downloading the Raspberry Pi imager and selecting the correct os, you will see the below image. Click **Write** when ready.
<br>

<p align="center">
  <img width="460" height="300" src="https://github.com/PTC-Education/RPi-EdgeMicroserver/blob/main/3D-Printer-Control-Hub/images/raspbian-32bit.png" />
</p>

After flashing your sd card, boot up your Raspberry Pi on a monitor so that you are able to access the graphical user interface. Remember the default login on fresh Raspberry Pi images is **username/password: pi/raspberry**. From here connect to your WiFi network in order to start downloading the EMS and git repository. 

In order to make sure that the EMS and custom python scripts can find each other we will place all of our files in the root directory. Now we are going to clone with repository into our root folder using the below bash commands.

Cd to your root folder 
```bash
# Move to your root directory
cd 

# Clone this repository to your root directory. 
git clone "repository-url"
```
---

<a name="ems"/>

## Installing EMS
For the first package, you can download the Edge MicroServer from the [Edge MicroServer Download](https://developer.thingworx.com/resources/guides/thingworx-raspberry-pi-quickstart) link. The download is hosted within the Thingworx Developer Portal, so you will need to make an account and find the download link inside. 

This tutorial is a great walk through on how to setup your EMS, so we will follow through the tutorial, but pause occasionally to make a few steps easier.

At this point you should follow the steps 1 and 2 to get setup with the EMS into your Downloads folder. 

```bash

# Move to the downloads folder, if you are already not..
cd ~/Downloads

# Move the microserver to your root folder
mv microserver ~
```

After completing the move to the root folder continue with the Thingworx Developer Portal until you get to step 4 in configuring your EMS. 

In order to streamline the process 

3. Now that you have the EMS downloaded we need to load our app keys and Thingworx host information into our environment variables so that they will be accessible to all python scripts. Included in this repository is a bash script, setup.sh, that will be run as 

```bash
source setup.sh
```

By running this script you will be prompted to enter your Thingworx, Onshape, and Octoprint credentials. These credentials will be persistently stored in your environment variables, but you will need to close out of your current terminal window for changes to take effect. 

---
<a name="properties"/>
