## Interfacing with Python

The Lua Script Resource interfaces with Python by utilizing the io.popen() function. io.popen() works by running whatever command you pass in as a functional argument on the commandline. With the ability to run commandline arguments from Lua, we are able to directly call our custom Python scripts that we wish to interface with Thingworx.

```
local sampleCmd = io.popen('/usr/bin/python helloWorld.py')

local s = sampleCmd:read("*a")
s = string.match(s, "sample=(%d+\,%d+)")
```

Adding to a variable
