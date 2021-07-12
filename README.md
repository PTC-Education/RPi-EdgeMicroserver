<h1 align="center">RPi-EdgeMicroserver</h1>
<p align="center">Repository for Lua Script Resource templates and examples for usage with Python3</p> 


### Table of Contents  
* [Creating Custom Properties](#properties)  
* [Creating Custom Services](#services)
* [Creating Properties for ValueStreams](#valuestreams)
* [Interfacing with Custom Python Scripts](#pythonLua)
* [Downloading Files from File Repositories](#fileDownload)


### Example Use Cases
* [3D Printer EMS Control Hub](https://github.com/PTC-Education/RPi-EdgeMicroserver/tree/main/3D%20Printer%20Control%20Hub)

This repository is broken down into LSR (Lua Script Resource) templates for configuring a Raspberry Pi RemoteThing. Below is a screenshot from the Thingworx Developer Portal tutorial outlining the complete communication structure from the Raspberry Pi to the Thingworx server.


<p align="center">
  <img src="https://github.com/PTC-Education/RPi-EdgeMicroserver/blob/main/3D-Printer-Control-Hub/images/pi_ems_connections.png" />
</p>

---
## High Level Communication Structure:

When you start the EMS (Edge MicroServer) on the Raspberry Pi, you are creating your own RemoteThing that is registered
with your Thingworx instance. This connection over the AlwaysOn protocol will allow users to utlize their GPIO and custom code remote through Thingworx services and properties. The below image is a diagram displaying the connection flow showing the bi-directional communication.

![alt text](https://github.com/PTC-Education/RaspberryPi-EMS-Lua-Python/blob/main/rpi_alwaysOn_thngwrx.png)

---
<a name="properties"/>

## Creating Custom Properties

This section of the repository outlines the process behind defining custom properties in the Lua Script Resource. It also outlines getting and setting values from properties.

```lua
-- Base structure for declaring new properties
properties.[propertyName]={baseType="[propertyType]", pushType="propertyPushType", value="propertyDefaultValue"

-- Example property creation
properties.cpu_temperature={baseType="NUMBER", pushType="ALWAYS", value=0}

-- Writing to a custom property
properties.[propertyName].value = s

-- Reading in current property value into variable
customPropValue = properties.[propertyName].value
```

<a name="services"/>

## Creating Custom Services

This section of the repository outlines the process behind defining custom services in the Lua Script Resource. It also outlines writing service functions in order to utilize custom service inputs. Click [here](https://github.com/PTC-Education/RaspberryPi-EMS-Lua-Python/tree/main/Creating%20Custom%20Services) to get started writing custom properties.

```lua
-- Base structure for defining new services
serviceDefinitions.[serviceName](
  input { name="[inputName]", baseType="[inputType]", description="[inputDescription]" },
  output { baseType="[outputType]", description="[outputDescription]" },
  description { "[serviceDescription]" }
)

-- Base structure for implementing service callback functions
services.[serviceName] = function(me, headers, query, data)
    *** define the function actions within
   return 200, true 
end

-- How to reference service inputs inside callback functions
local serviceInput = data.inputName
```

<a name="pythonLua"/>

## Interfacing with Python Scripts using Services and Properties
This section of the repository outlines interfacing with external Python3 scripts using custom properties and services.

```lua
-- Use the io library to run the python script
local inputCmd = io.popen("python3 /path/to/file.py")

-- Read in the std:output from the command prompt
local s = inputCmd::read(*a)

```

<a name="fileDownload"/>

## Downloading Files from File Repositories to RPi EMS
This section covers a high level overview of downloading files using the REST API. Using the FileRepositoryDownloader we can specify the repository and path to the file. By funneling the response of our api call, we can use file i/o to write our downloaded data to a file on our local machine. If you would like to see a more robust example [click here](https://github.com/PTC-Education/RPi-EdgeMicroserver/blob/main/3D%20Printer%20Control%20Hub/downloadFile.py)

```python
 # Request URL Parameters
 host = os.getenv('THINGWORX_HOST')
 path = "/Thingworx/FileRepositoryDownloader"
 repositoryQuery = "?download-repository="
 fileQuery = "&download-path=/"
 
  # Concatenate Request URL
  url = host + path + repositoryQuery + fileRepository + fileQuery + fileName

  try:
      r = requests.request("GET", url, headers = headers, allow_redirects=True)
      if (save):
          file = open(fileName, "w")
          file.write(r.text)
          file.close()
      return True
  except:
      return False
```

<a name="valuestreams"/>

## Valuestream Properties
Creating a property that logs its timestamp as well as value for input into a valuestream

```lua

-- Function that queries a python script for current printer bed and extruder temps

function queryHardware()
    
    -- Call the Python script
    local tempCmd = io.popen("/usr/bin/python $HOME/RPi-EdgeMicroserver/3D-Printer-Control-Hub/scripts/tempStatus.py")
    local s = tempCmd:read("*a")
    
    -- Parse out the temperature value from the std output string
    local d = string.match(s,"BedTemp=(%d+\.%d+)");
    
    -- Assign the value and time to the property for correct logging 
    properties.bed_temperature.value = d
    properties.bed_temperature.time = data.time;
    
end
```

---
