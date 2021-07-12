import requests
import os
import time
import sys

def getOctopiKey() -> str:
    keys = []
    with open('/home/pi/RPi-EdgeMicroserver/3D-Printer-Control-Hub/security/keys.txt') as f:
        keys = f.readlines()
    f.close()
    return keys[0]

'''
getTemps():

    Request for the current bed and extruder temperature of the 3D printer

'''
def getTemps() -> bool: 

    # URL Componnents
    base = "http://octopi.local"
    url = "/api/printer"

    key = getOctopiKey()

    # Defining the headers 
    headers = {
        'X-Api-Key': key.strip('\n'),
        'Content-Type': "application/json"
        }
    # Defining request parameters
    params = {}
    try:
        response = requests.request("GET",
                                    base+url,
                                    params=params,
                                    headers=headers)
        prntrStatus = response.json()
        bedTemp = prntrStatus['temperature']['bed']['actual']
        extrTemp = prntrStatus['temperature']['tool0']['actual']
        print('BedTemp={0:0.1f} ExtrTemp={1:0.1f}'.format(bedTemp,extrTemp))
        return True
    except:
        #print('Request Failed');
        extrTemp = 0
        bedTemp = 0
        print('BedTemp={0:0.1f} ExtrTemp={1:0.1f}'.format(bedTemp,extrTemp))
        return False


getTemps()

