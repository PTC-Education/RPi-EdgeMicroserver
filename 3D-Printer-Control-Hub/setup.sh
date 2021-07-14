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

printf "   Enter Onshape Access Key: "
read onshape_access_key
printf "\n\n"
echo $onshape_access_key >> /home/pi/RPi-EdgeMicroserver/3D-Printer-Control-Hub/security/keys.txt

printf "   Enter Onshape Secret Key: "
read onshape_secret_key
printf "\n\n"
echo $onshape_secret_key >> /home/pi/RPi-EdgeMicroserver/3D-Printer-Control-Hub/security/keys.txt

echo "-------------------------------------------"
printf "\n"
printf "      All API keys have been stored!\n\n"

printf "    Close the terminal and open a new\n"
printf "   in order for changes to take effect\n\n" 

echo "-------------------------------------------"

