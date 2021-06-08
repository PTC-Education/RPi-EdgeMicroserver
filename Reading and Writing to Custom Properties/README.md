## Reading and Writing to Custom Properties

In order to read and write to the custom property, the value data member must be accessed.

### Writing a Value to a Custom Property
```
properties.[propertyName].value = s
```
#### 1. propertyName
Name of your custom property on Thingworx
#### 2. s
S is the string that you wish to assign to the custom property.

### Reading a Custom Property Value into a Variable
```
customPropValue = properties.[propertyName].value
```
#### 1. propertyName
Name of your custom property on Thingworx

The customPropValue is always a string that will be sent to Thingworx.

