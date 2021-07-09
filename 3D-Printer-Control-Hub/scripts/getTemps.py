import requests
import os

def getTemps() -> bool: 

    # URL Componnents
    base = "http://octopi.local"
    url = "/api/printer"
    
        # Defining the headers 
    headers = {
        'X-Api-Key': os.getenv("OCTOPI_KEY"),
        'Content-Type': "application/json"
        }

    query ="?apikey="
    apikey = os.getenv("OCTOPI_KEY")

    reqString = base+url+query+apikey 

    try:
        r = requests.get(reqString)
        
        
        
        prntrStatus = r.json()
        bedTemp = prntrStatus['temperature']['bed']['actual']
        extrTemp = prntrStatus['temperature']['tool0']['actual']
        print('BedTemp={0:0.1f} ExtrTemp={1:0.1f}'.format(bedTemp,extrTemp))
        return True
    except:
        print('Request Failed');
        return False

    
    
     # URL Componnents
    base = "http://octopi.local"
    url = "/api/job"

    # Defining the headers 
    headers = {
        'X-Api-Key': os.getenv("OCTOPI_KEY"),
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
        response = requests.request("GET",
                                    base+url,
                                    params=params,
                                    headers=headers)
        return True
