import requests
import asyncio
import json
import sys
import os


def getOctopiKey() -> str:
    keys = []
    with open('/home/pi/RPi-EdgeMicroserver/3D-Printer-Control-Hub/security/keys.txt') as f:
        keys = f.readlines()
    f.close()
    return keys[0]

def jogPrinthead(dist:int, axis:int) -> bool:

    key = getOctopiKey()
    
    base = 'http://octopi.local'
    url = '/api/printer/printhead'

    headers = {
        'X-Api-Key': key.strip('\n'),
        'Content-Type': 'application/json',
        'accept': 'application/json'
        }

    payload = {"command": "jog",
                str(axis): float(dist)
               }

    params = {}
    
    try:
        response = requests.request("POST", base+url, params=params, headers=headers, data=json.dumps(payload))
        return True
    except:
        pass
        return False


dist = sys.argv[1]
axis = sys.argv[2]


jogPrinthead(dist, axis)