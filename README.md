# RaspberryPi-EMS-Lua-Python
Repository for Lua Script Resource templates and examples for usage with Python3. 

This repository is broken down into LSR (Lua Script Resource) templates for configuring a Raspberry Pi RemoteThing.

## Creating Custom Properties

In order to setup custom properties in your PiTemplate.lua file, you will need to follow the definition convention.
Below the definition is outlined, and this will be placed at the top of your template file.
```
properties.[propertyName]={baseType="[propertyType]", pushType="propertyPushType", value="propertyDefaultValue"
```
#### 1. propertyName
Name of your custom property on Thingworx

#### 2. propertyType
Type of your custom property. Examples of possible types: NUMBER, STRING, IMAGE. A full reference of possible types can be found on [support.ptc.com](https://support.ptc.com/help/thingworx/platform/r9/en/index.html#page/ThingWorx%2FHelp%2FComposer%2FThings%2FThingProperties%2FThingProperties.html%23) under the Property Base Type section.

#### 3. propertyPushType
Push Type of your custom property. Examples of possible types: ALWAYS, NEVER. A full reference of possible types can be found on [support.ptc.com](https://support.ptc.com/help/thingworx/platform/r9/en/index.html#page/ThingWorx%2FHelp%2FComposer%2FThings%2FThingProperties%2FThingProperties.html%23) under the Property Push Type section.

#### 4. propertyDefaultValue
Default value of your custom property. The type of this value is dependent on the propertyType, but will default to the 0 state if not supplied in the template file.

### Example Custom Property Declaration

Say we are creating a custom property that monitors the cpu_temperaure of your RaspberryPi. When creating a RemoteThing with this custom property, we must break down the information we need.

For this case we will define our parameters:
```
propertyName = cpu_temperature
propertyType = NUMBER
propertyPushType = ALWAYS
propertyDefaultValue = 0
```
Plugging our parameters into the base declaration,

```
properties.cpu_temperature={baseType="NUMBER", pushType="ALWAYS", value=0}
```
You have just defined your first custom property!
