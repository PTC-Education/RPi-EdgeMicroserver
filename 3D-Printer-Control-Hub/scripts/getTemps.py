import requests
import os

'''
getTemps():

    Request for the current bed and extruder temperature of the 3D printer

'''
def getTemps() -> bool: 

    # URL Componnents
    base = "http://octopi.local"
    url = "/api/printer"
    
    # Defining the headers 
    headers = {
        'X-Api-Key': os.getenv("OCTOPI_KEY"),
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
        print('Request Failed');
        return False
