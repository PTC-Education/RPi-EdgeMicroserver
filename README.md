<h1 align="center">RaspberryPi-EMS-Lua-Python</h1>
<p align="center">Repository for Lua Script Resource templates and examples for usage with Python3</p> 


### Table of Contents  
* [Creating Custom Properties](#properties)  
* [Creating Custom Services](#properties)
* [Interfacing with Custom Python Scripts](#properties)
<a name="properties"/>


This repository is broken down into LSR (Lua Script Resource) templates for configuring a Raspberry Pi RemoteThing.

---
## High Level Communication Structure:

When you start the EMS (Edge MicroServer) on the Raspberry Pi, you are creating your own RemoteThing that is registered
with your Thingworx instance. This connection over the AlwaysOn protocol will allow users to utlize their GPIO and custom code remote through Thingworx services and properties. The below image is a diagram displaying the connection flow showing the bi-directional communication.

![alt text](https://github.com/PTC-Education/RaspberryPi-EMS-Lua-Python/blob/main/rpi_alwaysOn_thngwrx.png)

---

## Creating Custom Properties

This section of the repository outlines the process behind defining custom properties in the Lua Script Resource. It also outlines getting and setting values from properties. Click [here](https://github.com/PTC-Education/RaspberryPi-EMS-Lua-Python/tree/main/Creating%20Custom%20Properties) to get started writing custom properties.

```lua
-- Base Structure for declaring new properties
properties.[propertyName]={baseType="[propertyType]", pushType="propertyPushType", value="propertyDefaultValue"

-- Example property creation
properties.cpu_temperature={baseType="NUMBER", pushType="ALWAYS", value=0}

-- Writing to a custom property
properties.[propertyName].value = s

-- Reading in current property value into variable
customPropValue = properties.[propertyName].value
```


## Creating Custom Services

This section of the repository outlines the process behind defining custom services in the Lua Script Resource. It also outlines writing service functions in order to utilize custom service inputs. Click [here](https://github.com/PTC-Education/RaspberryPi-EMS-Lua-Python/tree/main/Creating%20Custom%20Services) to get started writing custom properties.

## Interfacing with Python Scripts using Services and Properties
This section of the repository outlines interfacing with external Python3 scripts using custom properties and services. Click [here](https://github.com/PTC-Education/RaspberryPi-EMS-Lua-Python/tree/main/Interfacing%20with%20Python) to learn more about incorporating Python scripts into your services and properties.

---
