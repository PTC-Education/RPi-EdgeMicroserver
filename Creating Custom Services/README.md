## Creating Custom Services

In order to setup custom services in your PiTemplate.lua file, you will need to follow the definition convention.
Below the definition is outlined, and this will be placed at the top of your template file.
```
serviceDefinitions.[serviceName](
  input { name="[inputName]", baseType="[inputType]", description="[inputDescription]" },
  output { baseType="[outputType]", description="[outputDescription]" },
  description { "[serviceDescription]" }
)
```
#### 1. serviceName
Name of your custom service on Thingworx

#### 2. inputName
Name of your service input property on Thingworx.

#### 3. inputType
Type of your service input property. Examples of possible types: NUMBER, STRING, IMAGE. A full reference of possible types can be found on [support.ptc.com](https://support.ptc.com/help/thingworx/platform/r9/en/index.html#page/ThingWorx%2FHelp%2FComposer%2FThings%2FThingProperties%2FThingProperties.html%23) under the Property Base Type section. There can be as many inputs as you wish, just copy the input declaration and declare a unique inputName.

#### 4. inputDescription
Description of the input to the service. This description will appear as a tooltip in Thingworx once the service is live.

#### 5. outputType
Type of your service output property. Examples of possible types: NUMBER, STRING, IMAGE. A full reference of possible types can be found on [support.ptc.com](https://support.ptc.com/help/thingworx/platform/r9/en/index.html#page/ThingWorx%2FHelp%2FComposer%2FThings%2FThingProperties%2FThingProperties.html%23) under the Property Base Type section. There can be as many inputs as you wish, just copy the input declaration and declare a unique inputName.

#### 6. outputDescription
Description of the output to the service. This description will appear as a tooltip in Thingworx once the service is live.


### Example Custom Service Declaration

Say we are creating a custom service that controls the motion of a 3D printer with two inputs, axis and dist. When creating a RemoteThing with this custom service, we must break down the information we need.

For this case we will define our parameters:
```
serviceName = Jog
serviceDescription = Service that jogs 3d printer toolhead by specifying axis and distance of movement

inputName1 = axis
inputType1 = STRING
inputDescription1 = movement axis (x,y,z)

inputName2 = dist
inputType2 = NUMBER
inputDescription2 = relative jog distance (mm)

outputType = BOOLEAN
outputDescription = ""
```
Plugging our parameters into the base declaration,
```
serviceDefinitions.Jog(
  input { name="axis", baseType="STRING", description="movement axis (x,y,z)" },
  input { name="dist, baseType="NUMBER", description="relative jog distance (mm)" },
  output { baseType="NUMBER", description="" },
  description { "Service that jogs 3d printer toolhead by specifying axis and distance of movement" }
)
```
You have just defined your first custom service!

## Creating a Service Function
Once you have defined your service you need to write a function that utilizes your inputs in order to do an action. 

The skeleton structure for creating a service function is outlined below.
```
services.Jog = function(me, headers, query, data)
    *** define the function actions within
   return 200, true 
end
```
We can define and use our input parameters by calling them as part of our function's data

### Reading in Input data
```
// axis value passed into service call in Thingworx
local axis = data.axis

// dist value passed into service call in Thingworx
local dist = data.axis
```
