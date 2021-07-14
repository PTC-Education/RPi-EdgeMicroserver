echo "Copying configuration and template files to the EMS..."

cp config/config.lua ~/microserver/etc

cp config/config.json ~/microserver/etc

cp template/PiTemplate.lua ~/microserver/etc/custom/templates

echo "Copy complete! Please verify that the files are located in ~/microserver/etc and ~/microserver/etc/custom/templates"
