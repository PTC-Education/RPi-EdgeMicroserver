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

#### 3. outputDescription
Description of the output to the service. This description will appear as a tooltip in Thingworx once the service is live.


### Example Custom Service Declaration

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
