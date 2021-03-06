rm /home/pi/RPi-EdgeMicroserver/3D-Printer-Control-Hub/security/keys.txt

echo "--------------------------------------------"
echo "|           Edge Microserver Setup         |"
echo "--------------------------------------------"
printf "                                        \n"
echo " Everytime this script is run your previous"
echo " API keys will be cleared from the .bashrc"
printf " and replaced with the new entrys\n\n" 

echo "-------------------------------------------"
printf " Input your keys and host url\n"
printf " to be stored in environment variables\n\n"

printf "   Enter Octoprint API Key: "
read octopi_key
printf "\n\n"
echo $octopi_key >> /home/pi/RPi-EdgeMicroserver/3D-Printer-Control-Hub/security/keys.txt

printf  "   Enter Thingworx API Key: "
read tx_key
printf "\n\n"
echo $tx_key >> /home/pi/RPi-EdgeMicroserver/3D-Printer-Control-Hub/security/keys.txt

printf  "   Enter Thingworx Host: "
read tx_host
printf "\n\n"
echo $tx_host >> /home/pi/RPi-EdgeMicroserver/3D-Printer-Control-Hub/security/keys.txt

rm /home/pi/.onshape_client_config.yaml

echo prod_api_keys: >> /home/pi/.onshape_client_config.yaml
echo "base_url: \"https://cad.onshape.com\"" >> /home/pi/.onshape_client_config.yaml


printf "   Enter Onshape Access Key: "
read onshape_access_key
printf "\n\n"

printf "   Enter Onshape Secret Key: "
read onshape_secret_key
printf "\n\n"

echo "  secret_key: \"$onshape_secret_key\"" >> /home/pi/.onshape_client_config.yaml
echo "  access_key: \"$onshape_access_key\"" >> /home/pi/.onshape_client_config.yaml
echo default_stack: prod_api_keys >> /home/pi/.onshape_client_config.yaml


echo "-------------------------------------------"
printf "\n"
printf "      All API keys have been stored!\n\n"

printf "    Close the terminal and open a new\n"
printf "   in order for changes to take effect\n\n" 

echo "-------------------------------------------"

