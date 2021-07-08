<h1 align="center">RPi-EdgeMicroserver</h1>
<p align="center">Repository for Lua Script Resource templates and examples for usage with Python3</p> 


### Table of Contents  
* [Creating Custom Properties](#properties)  
* [Creating Custom Services](#services)
* [Interfacing with Custom Python Scripts](#pythonLua)
* [Downloading Files from File Repositories](#fileDownload)



This repository is broken down into LSR (Lua Script Resource) templates for configuring a Raspberry Pi RemoteThing.

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



---
