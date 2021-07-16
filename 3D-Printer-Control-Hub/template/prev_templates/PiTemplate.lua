module ("templates.PiTemplate", thingworx.template.extend)


-- Defining the custom Control Hub properties

-- Bed_Temperature of the 3D printer
properties.bed_temperature={baseType="NUMBER", pushType="ALWAYS", value=0}
-- Extruder Temperature of the 3D printer 
properties.extr_temperature={baseType="NUMBER", pushType="ALWAYS", value=0}
-- Live Camera feed from the 3D printer
properties.remote_photo={baseType="IMAGE", pushType="ALWAYS", value =0}



--[[ 
GetSystemProperties(): 
	GetSystemProperties service defintion
	Output - Boolean, if True, 200 
			  else False, 400
--]]
serviceDefinitions.GetSystemProperties(
    output { baseType="BOOLEAN", description="" },
    description { "Updates Properties for PrinterControlThing" }
)


--[[ 
PreheatBed():
	PreheatBed service definition
        Input  - temperature, NUMBER, value of the target bed temperature
        Output - Boolean, if True, 200 
                          else False, 400
--]]
serviceDefinitions.PreheatBed(
   input { name="temperature", baseType="NUMBER", description="target bed temperature" },
   output { baseType="BOOLEAN", description="" },
   description { "Preheat the Bed" }
)


--[[ 
PreheatExtruder():
        PreheatExtruder service defintion
        Input  - temperature, NUMBER, value of the target extruder temperature
        Output - Boolean, if True, 200 
                          else False, 400
--]]
serviceDefinitions.PreheatExtruder(
   input { name="temperature", baseType="NUMBER", description="target extruder temperature" },
   output { baseType="BOOLEAN", description="" },
   description { "Preheat the Extruder" }
)



--[[ 
JogPrinthead():
        JogPrinthead service definition
        Input  - distance, NUMBER, the distance to jog the printhead
                 axis, STRING, the axis to be jogged
        Output - Boolean, if True, 200 
                          else False, 400
--]]
serviceDefinitions.JogPrinthead(
   input { name="distance", baseType="NUMBER", description="distance to jog printhead" },
   input { name="axis", baseType="STRING", description="axis to be jogged" },
   output { baseType="BOOLEAN", description="" },
   description { "Service that jogs the printhead" }
)



--[[ 
CancelPrint():
        CancelPrint service definition
        Output - Boolean, if True, 200 
                          else False, 400
--]]
serviceDefinitions.CancelPrint(
  output { baseType="BOOLEAN", description="" },
  description { "Cancel the print" }
)



--[[ 
uploadFile():
	uploadFile service definition

	Input  - filename, STRING, filename in file repository
                 repository, STRING, name of a Thingworx File Repository
	Output - Boolean, if True, 200 
			  else False, 400
--]]
serviceDefinitions.UploadFile(
    input {name="filename", baseType="STRING", description="filename in File Repository"},
    input {name="store", baseType="STRING", description="repository name in Thingworx Server"},
    output {baseType="BOOLEAN", description=""},
    description {"Add custom gcode to text box and it will send to your 3D printer"} 
)



--[[
downloadSTL():
       downloadSTL service defintiion

       Input  - onshapeURL, STRING, url of onshape part for download and export
       Output - Boolean, if True, 200 
			 else False, 400

--]]
--[[
serviceDefinitions.downloadSTL(
    input {name="onshapeURL", baseType="STRING", description="Onshape Part Studio url"},
    output {baseType="BOOLEAN", description=""},
    description {"Input an onshape url and it will be sliced locally on the EMS and uploaded to the Octoprint instance for printing"}
)
--]]


--[[
------------------------------------------ CALLBACK FUNCTIONS ------------------------------------------------
--]]


--[[
CALLBACK -- downloadSTL():

	Grabs the url input from Thingworx and forms the string in order to call the exportSTL.py script
--]]
--[[
services.downloadSTL = function(me, headers, query, data)
    local rootPaths = "/usr/bin/python $HOME/RPi-EdgeMicroserver/3D-Printer-Control-Hub/scripts/testingSTL.py \""
    local url = data.onshapeURL
    local uploadCmd = io.popen(rootPaths .. url .. "\"")
    return 200, true
end
--]]



--[[
CALLBACK -- uploadFile():

	Grabs the url input from Thingworx and forms the string in order to call the exportSTL.py script
--]]
services.UploadFile = function(me, headers, query, data)
    local rootPath = "/usr/bin/python /home/pi/RPi-EdgeMicroserver/3D-Printer-Control-Hub/scripts/downloadFile.py \""   
    local filename = data.filename .. "\" \""
    local repository = data.store .. "\""
    local uploadCmd = io.popen(rootPath .. filename .. repository)
    return 200, true
end


--[[
CALLBACK -- GetSystemProperties():
	Uses the Query Hardware function to update the Control Hub Remote Properties
--]]
services.GetSystemProperties = function(me, headers, query, data)
    queryHardware()
    return 200, true
end


--[[ 
CALLBACK -- preheatBed():
	Calls the preheatBed.py script to preheat to the specified temperature
--]]
services.PreheatBed = function(me, headers, query, data)
   local rootPath = "/usr/bin/python /home/pi/RPi-EdgeMicroserver/3D-Printer-Control-Hub/scripts/preheatBed.py \""
   local temperature = data.temperature
   local uploadCmd = io.popen(rootPath .. temperature .. "\"")
   return 200, true 
end



--[[ 
CALLBACK -- preheatExtruder():
	Calls the preheatExtruder.py script to preheat to the specified temeprature
--]]
services.PreheatExtruder = function(me, headers, query, data)
   local rootPath = "/usr/bin/python /home/pi/RPi-EdgeMicroserver/3D-Printer-Control-Hub/scripts/preheatExtruder.py \""
   local temperature = data.temperature
   local uploadCmd = io.popen(rootPath .. temperature .. "\"")
   return 200, true
end


--[[ 
CALLBACK -- JogPrinthead():
	Calls the jogPrinthead.py script to jog the printhead on the 3D printer
--]]
services.JogPrinthead = function(me, headers, query, data)
   local rootPath = "/usr/bin/python /home/pi/RPi-EdgeMicroserver/3D-Printer-Control-Hub/scripts/jogPrinthead.py \""
   local distance = data.distance
   local axis = data.axis
   local uploadCmd = io.popen(rootPath .. distance .. "\" \"" .. axis .. "\"")
   return 200, true
end


--[[
CALLBACK -- CancelPrint():
	Calls the cancelPrint.py script to cancel the print on the Octopi
--]]
services.CancelPrint = function(me, headers, query, data)
   local rootPath = "/usr/bin/python /home/pi/RPi-EdgeMicroserver/3D-Printer-Control-Hub/scripts/cancelPrint.py"
   local uploadCmd = io.popen(rootPath)
   return 200, true
end


--[[
HELPER FUNCTION -- queryHardware()
--]]
function queryHardware()

    local tempCmd = io.popen("/usr/bin/python /home/pi/RPi-EdgeMicroserver/3D-Printer-Control-Hub/scripts/getTemps.py")
    local s = tempCmd:read("*a")
    
    local d = string.match(s,"BedTemp=(%d+\.%d+)");
    properties.bed_temperature.value = d
    properties.bed_temperature.time = data.time;
   
    s = string.match(s,"ExtrTemp=(%d+\.%d+)");
    properties.extr_temperature.value = s
    properties.extr_temperature.time = data.time;
    
    local photoCmd = io.popen("/usr/bin/python /home/pi/RPi-EdgeMicroserver/3D-Printer-Control-Hub/scripts/takePhoto.py")
    s = photoCmd:read("*a")
    properties.remote_photo.value = s

end



-- Task Declarations
tasks.refreshProperties = function(me)
    log.trace("[PiTemplate]","~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ In tasks.refreshProperties~~~~~~~~~~~~~ ")
    queryHardware()
end
