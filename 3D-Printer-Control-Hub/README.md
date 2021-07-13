<h1 align="center">3D Printer Control Hub</h1>
<p align="center">Setup guide for creating a Raspberry Pi EMS Printer Control Hub leveraging Octoprint</p> 


### Table of Contents  
* [Installing Raspbian](#raspbian)
* [Cloning the Repository](#printerControl)
* [Setting up API Keys](#keys)
* [Installing EMS](#ems)
* [Generating Credential Environment Variables](#credentials)
* [Running the Edge MicroServer](#run) 
---
Following this guide on a fresh install of Raspbian will allow the user to connect their Octoprint instance to Thingworx using a RemoteThing. From there we can build mashups to securey monitor
our printer's information from anywhere without worrying about port forwarding. 

---


<a name="raspbian"/>

<details close>
<summary>Installing Raspbian</summary>
<br>
Instead of hosting a precompiled image, we are going to go through the steps to build your own custom image on the Raspberry Pi.

You will need to download the Raspberry Pi Imager and flash the 32-Bit Raspbian OS onto a new SD card. After downloading the Raspberry Pi imager and selecting the correct os, you will see the below image. Click **Write** when ready.
<br>

<p align="center">
  <img width="460" height="300" src="https://github.com/PTC-Education/RPi-EdgeMicroserver/blob/main/3D-Printer-Control-Hub/images/raspbian-32bit.png" />
</p>

After flashing the SD card, boot the Raspberry Pi while connected to a monitor so that you are able to access the graphical user interface. Remember the default login on fresh Raspberry Pi images is **username/password: pi/raspberry**. 
<br>

From here connect to your WiFi network and ensure that ssh is enabled on your new image by typing 

```bash
sudo raspi-config
```

Select Interface Options > SSH > Yes to enable ssh on your system

</details>  

<a name="python3" />


<details close>
  <summary>Setting Python3 as Default Interpreter</summary>
  <br>
The core of this printer control application is built off of a series of python3 scripts that are called via callback functions in our predefined services. In order for the EMS to accurately call these scripts we must ensure that the Raspberry Pi is setup to call python3 on default. 
    
In order to do this we will make use of a script made by Adafruit [linked here](https://learn.adafruit.com/circuitpython-on-raspberrypi-linux/installing-circuitpython-on-raspberry-pi)
     
The below commands will install the libraries for adafruit sensors and also set the default to python3. Answer yes to the prompts and wait for the process to complete
    
```bash
cd ~
sudo pip3 install --upgrade adafruit-python-shell
wget https://raw.githubusercontent.com/adafruit/Raspberry-Pi-Installer-Scripts/master/raspi-blinka.py
sudo python3 raspi-blinka.py
```

Once completed move on to the next step in the tutorial.
    
</details>




<a name="printerControl" />

<details close> 
<summary>Cloning the Repository</summary>
<br>

In order to make sure that the EMS and custom python scripts can find each other we will place all of our files in the root directory. Now we are going to clone with repository into our root folder using the below bash commands.
```bash
# Move to your root directory
cd 

# Clone this repository to your root directory. 
git clone "https://github.com/PTC-Education/RPi-EdgeMicroserver.git"
```

When cloning the repository you may have to enter your Github credentials, enter your username and password in order to authenticate the download command. Once completed, you can traverse to the **3D-Printer-Control-Hub** subfolder and investigate the folder structure. 

```bash 
cd RPi-EdgeMicroserver/3D-Printer-Control-Hub/

ls

# --- output folders ---

# - template - stores the PiTemplate.lua for the Remote Thing

# - scripts - stores all of the Python scripts driving the EMS connection

# - images - assets for the readme documentation

----------------------
```
</details>





<a name="keys" /> 

<details close>
  <summary>Setting up Keys</summary>
  
Now that the repository has been downloaded we need to load our app keys into a keys.txt so that they will be accessible to the EMS when it is monitoring our printer instance. Included in the 3D-Printer-Control-Hub is a bash script, setup.sh, that should be run with the below command:

```bash
bash setup.sh
```

By running this script you will be prompted to enter your Thingworx, Onshape, and Octoprint credentials. These credentials will be persistently stored in the security folder of this repository in keys.txt

Before moving on to the next steps lets make sure that we accurately wrote out the api keys to the keys.txt file. In a new terminal window enter the below commands to view and verify the generated keys.txt file.

```bash
cd
  
sudo nano RPi-EdgeMicroserver/3D-Printer-Control-Hub/security/keys.txt
```
Once our api keys have been verified we can move on to install the Edge Microserver

</details>





<a name="ems"/>

<details close>
## Installing EMS
For the first package, you can download the Edge MicroServer from the [Edge MicroServer Download](https://developer.thingworx.com/resources/guides/thingworx-raspberry-pi-quickstart) link. The download is hosted within the Thingworx Developer Portal, so you will need to make an account and find the download link inside. 

This tutorial is a great walk through on how to setup your EMS, so we will follow through the tutorial, but pause occasionally to make a few steps easier.

On step 2 download the EMS .zip file and drag from the Downloads folder to the root folder one level up. 

From here you can continue and unzip folder, feel free to remove the downloaded zip file with

```bash 
rm MED-61060-CD-054_SP9_Microserver-Linux-arm-hwfpu-openssl-5-4-6-1154.zip
```

### Step 4. Configuring the EMS

  In this step you are tasked to create a config.json file. A template config file has been place in this repository so you wil jsut have to edit the Thinworx Host and App Key information.
  
  ```bash
  -- Move to the config folder 
  cd RPi-EdgeMicroserver/3D-Printer-Control-Hub/config/
  
  -- Copy the config.json file to the microserver configuration subfolder
  cp config.json ~/microserver/etc
  ```
  
 Open the config.json file and enter your information. Once completed you can progress to Step 5 of the tutorial. 
 
### Step 5. Configuring Lua Script Resource

```bash
-- Move to the config folder 
  cd RPi-EdgeMicroserver/3D-Printer-Control-Hub/config/
  
  -- Copy the config.lua file to the microserver configuration subfolder
  cp config.lua ~/microserver/etc
```

### Step 7. Configure Template File

```bash
  -- Move to the config folder 
  cd RPi-EdgeMicroserver/3D-Printer-Control-Hub/template/
  
  -- Copy the config.lua file to the microserver configuration subfolder
  cp PiTemplate.lua ~/microserver/etc/custom/templates
```
  
---

After completing the move to the root folder continue with the Thingworx Developer Portal until you get to step 4 in configuring your EMS. 

In order to streamline the process 

3. Now that you have the EMS downloaded we need to load our app keys and Thingworx host information into our environment variables so that they will be accessible to all python scripts. Included in this repository is a bash script, setup.sh, that will be run as 

```bash
source setup.sh
```

By running this script you will be prompted to enter your Thingworx, Onshape, and Octoprint credentials. These credentials will be persistently stored in your environment variables, but you will need to close out of your current terminal window for changes to take effect. 
---
  
</details>



<a name="properties"/>
