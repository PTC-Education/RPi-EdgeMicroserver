import requests
import os
import sys
import json

def getOctopiKey() -> str:
    keys = []
    with open('/home/pi/RPi-EdgeMicroserver/3D-Printer-Control-Hub/security/keys.txt') as f:
        keys = f.readlines()
    f.close()
    return keys[0]

'''
preheatExtruder():
    Calls the Octoprint API from the EMS and
    is used to interface with custom Thingworx
    services
'''
def preheatExtruder(temperature:int) -> bool:

    key = getOctopiKey()

    # Safety check so that the temperature is
    # not overloaded 
    if temperature > 220:
        temperature = 0


    # URL Componnents
    base = "http://octopi.local"
    url = "/api/printer/tool"

    # Defining the headers 
    headers = {
        'X-Api-Key': key.strip('\n'),
        'Content-Type': "application/json"
        }

    # Defining the payload
    payload = {
      "command": "target",
      "targets": {
          "tool0" : temperature
      }
    }

    # Defining request parameters
    params = {}

    # Calling the tool temp endpoint
    try:
        response = requests.request("POST",
                                    base+url,
                                    params=params,
                                    headers=headers,
                                    data=json.dumps(payload))
        return True
    except:
        return False
    
#-----------------------------------------------------------------

targetTemp = sys.argv[1]

preheatExtruder(int(targetTemp))
