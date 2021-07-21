import os
import sys
from exportPartStudio import exportPartStudio
from uploadFile import uploadFileToOctoprint

''' sliceSTL(str):

    Input: url, Onshape Part Studio url of interest

'''
def sliceSTL(url:str)->None:
    
    # Export Part Studio to STL
    exportPartStudio(url)

    # Generate gcode on the EMS
    command = "slic3r-prusa3d --no-gui --load /home/pi/RPi-EdgeMicroserver/3D-Printer-Control-Hub/config/config.ini /home/pi/microserver/export.stl"
    
    # Suppress the output in order to not break the EMSSS
    suppress = " >/dev/null 2>&1"

    # Run the gcode generation and 
    os.system(command + suppress)
    
    # Read GCODE into s variable and send to Octoprint
    s=""
    with open('/home/pi/microserver/export.gcode') as f: s = f.read()
    
    uploadFileToOctoprint("export.gcode", s)         

# Read in the url on the command line and call slice stl
url = sys.argv[1]
sliceSTL(url)
