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
cancelPrint():
    Calls the Octoprint API from the EMS and
    is used to interface with custom Thingworx
    services
'''
def cancelPrint() -> bool:
    
    key = getOctopiKey()

    # URL Componnents
    base = "http://octopi.local"
    url = "/api/job"

    # Defining the headers 
    headers = {
        'X-Api-Key': key.strip('\n'),
        'Content-Type': "application/json"
        }

    # Defining the payload
    payload = {
      "command": "cancel"
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
cancelPrint()
