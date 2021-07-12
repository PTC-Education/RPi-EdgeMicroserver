import requests
import binascii
import sys
import os

from uploadFile import *

def getTwxKey() -> str:
    keys = []
    with open('/home/pi/RPi-EdgeMicroserver/3D-Printer-Control-Hub/security/keys.txt') as f:
        keys = f.readlines()
    f.close()
    return keys[1]

'''
downloadFile():
    Inputs:
        
        fileName: name of the file in the Thingworx repository
                  to be downloaded
                  
        fileRepository: name of the file repository to be
                  getting the file from.
                  
    Usage:
    
        This function connects to the Thingworx API endpoint
        to download files uploaded by the user to a custom
        project File Repository.
        
        The user will supply a repository name and file and
        the file will be downloaded locally. 
        IMPORTANT: This function works for text based files
        
         i.e. .py, .txt, .gcode files 
'''
def downloadFile(fileName:str, fileRepository:str, save:bool = False, upload:bool = False) -> bool:
    
    key = getTwxKey()
    
    # Request Headers
    headers = {
        "appKey":key.strip('\n'),
        "Content-Type":"application/json",
        "Accept":"application/json, */*"
    }
    
    # Request URL Parameters
    host = os.getenv('THINGWORX_HOST')
    path = "/Thingworx/FileRepositoryDownloader"
    repositoryQuery = "?download-repository="
    fileQuery = "&download-path=/"
    
    # Concatenate Request URL
    url = host + path + repositoryQuery + fileRepository + fileQuery + fileName
    
    try:
        r = requests.request("GET", url, headers = headers, allow_redirects=True)
        if (save):
            file = open(fileName, "w")
            file.write(r.text)
            file.close()
        if (upload):
            uploadFileToOctoprint(fileName, r.text)
        return True
    except:
        return False
    
    
# Command Line Interface for EMS

fileName = sys.argv[1]
fileRepository = sys.argv[2]
 
downloadFile(fileName, fileRepository, save = True, upload = True)
