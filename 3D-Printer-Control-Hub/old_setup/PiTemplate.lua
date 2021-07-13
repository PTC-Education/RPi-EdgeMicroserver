module ("templates.PiTemplate", thingworx.template.extend)

-- Defining the custom Control Hub properties

-- Bed_Temperature of the 3D printer
properties.bed_temperature={baseType="NUMBER", pushType="ALWAYS", value=0, handlers="test"}
-- Extruder Temperature of the 3D printer 
properties.extr_temperature={baseType="NUMBER", pushType="ALWAYS", value=0, handler="test"}
-- Live Camera feed from the 3D printer
properties.remote_photo={baseType="IMAGE", pushType="ALWAYS", value =0}


--[[ 
GetSystemProperties(): 
	Define the GetSystemProperties service 

	Output - Boolean, if True, 200 
			  else False, 400
--]]
serviceDefinitions.GetSystemProperties(
    output { baseType="BOOLEAN", description="" },
    description { "updates properties" }
)


--[[ 
uploadFile():
	uploadFile service definition

	Input  - filename, STRING, filename in file repository
                 repository, STRING, name of a Thingworx File Repository
	Output - Boolean, if True, 200 
			  else False, 400
--]]
serviceDefinitions.uploadFile(
    input {name="filename", baseType="STRING", description="filename in File Repository"},
    input {name="repository", baseType="STRING", description="repository name in Thingworx Server"},
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
serviceDefinitions.downloadSTL(
    input {name="onshapeURL", baseType="STRING", description="Onshape Part Studio url"},
    output {baseType="BOOLEAN", description=""},
    description {"Input an onshape url and it will be sliced locally on the EMS and uploaded to the Octoprint instance for printing"}
)



--[[
CALLBACK -- downloadSTL():

	Grabs the url input from Thingworx and forms the string in order to call the exportSTL.py script
--]]
services.downloadSTL = function(me, headers, query, data)
    local rootPaths = "/usr/bin/python $HOME/RPi-EdgeMicroserver/3D-Printer-Control-Hub/scripts/testingSTL.py \""
    local url = data.onshapeURL
    local uploadCmd = io.popen(rootPaths .. url .. "\"")
    return 200, true
end



--[[
CALLBACK -- uploadFile():

	Grabs the url input from Thingworx and forms the string in order to call the exportSTL.py script
--]]
services.uploadFile = function(me, headers, query, data)
    local rootPath = "/usr/bin/python $HOME/RPi-EdgeMicroserver/3D-Printer-Control-Hub/scripts/downloadFile.py \""   
    local filename = data.filename
    local uploadCmd = io.popen(rootPath .. filename .. "\"")
    return 200, true
end



--[[
CALLBACK -- GetSystemProperties():

	Uses the query Hardware function to update the Control Hub Remote Properties
--]]
services.GetSystemProperties = function(me, headers, query, data)
    queryHardware()
--  if properties are successfully updated, return HTTP 200 code with a true service return value
    return 200, true
end



function queryHardware()
    local tempCmd = io.popen("/usr/bin/python $HOME/RPi-EdgeMicroserver/3D-Printer-Control-Hub/scripts/tempStatus.py")
    local s = tempCmd:read("*a")
    local d = string.match(s,"BedTemp=(%d+\.%d+)");
    properties.bed_temperature.value = d
    properties.bed_temperature.time = data.time;
    s = string.match(s,"ExtrTemp=(%d+\.%d+)");
    properties.extr_temperature.value = s
    properties.extr_temperature.time = data.time;
    local photoCmd = io.popen("/usr/bin/python $HOME/RPi-EdgeMicroserver/3D-Printer-Control-Hub/scripts/takeImage.py")
    s = photoCmd:read("*a")
    properties.remote_photo.value = s
end

tasks.refreshProperties = function(me)
    log.trace("[PiTemplate]","~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ In tasks.refreshProperties~~~~~~~~~~~~~ ")
    queryHardware()
end
