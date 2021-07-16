from onshape_client.client import Client
from onshape_client.onshape_url import OnshapeElement
import sys

def exportPartStudio(url:str)-> None:
    config_file = '/home/pi/.onshape_client_config.yaml'
    client = Client( keys_file=config_file )

    #url = "https://cad.onshape.com/documents/ab636694e7107e95a5b902bd/w/095959b0a9aae0eb62d7b6e0/e/84d7bfdff9470a0f2fe4e42c"

    element = OnshapeElement(url)
    
    response = client.part_studios_api.export_stl1(element.did, 'w', element.wvmid, element.eid, _preload_content=False, units='millimeter')

    with open( '{}.stl'.format('export'), 'wb') as file:
        file.write(response.data)
    file.close()


#url = "https://cad.onshape.com/documents/ab636694e7107e95a5b902bd/w/095959b0a9aae0eb62d7b6e0/e/84d7bfdff9470a0f2fe4e42c"

#url = sys.argv[1]
#exportPartStudio(url)