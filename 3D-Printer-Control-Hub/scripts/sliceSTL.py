import os
import sys
from exportPartStudio import exportPartStudio
from uploadFile import uploadFileToOctoprint

def sliceSTL(url:str)->None:

    exportPartStudio(url)

    command = "slic3r-prusa3d --no-gui --load /home/pi/RPi-EdgeMicroserver/3D-Printer-Control-Hub/config/config.ini /home/pi/microserver/export.stl"
    
    suppress = " >/dev/null 2>&1"

    os.system(command + suppress)
    
    s=""
    with open('/home/pi/microserver/export.gcode') as f: s = f.read()
    
    uploadFileToOctoprint("export.gcode", s)         
             
url = sys.argv[1]
sliceSTL(url)
