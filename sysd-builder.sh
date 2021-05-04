#!/bin/sh

# Validating existance of sample.service
if [ ! -f sample.service ] ; then
    echo "You need 'sample.service' in order to run this script"
    if command -v curl &> /dev/null || command -v wget &> /dev/null
    then
        wget https://raw.githubusercontent.com/sepehr-gh/systemd-builder/main/sample.service 2>/dev/null || curl -O  https://raw.githubusercontent.com/sepehr-gh/systemd-builder/main/sample.service
        echo "downloaded 'sample.service' to current directory"
    else
        exit
    fi
fi


echo "Enter service name (english alphabet and numbers, no spaces or anything): "
read service_name 
if [ -z "$service_name" ]
then
    echo "service name is required."
    exit
fi 


echo "Enter service description: "
read description


echo "Enter command: "
read command
valid="-1"
while [ "$valid" = '-1' ]
do
    if [ -z "$command" ];
    then
        echo "Invalid command. Can't be empty. Enter command again: ";
        read command
    else
        valid="1"
    fi
done

echo "Enter arguments: "
read arguments
if [ ! -z "$arguments" ]
then
    arguments="$arguments"
fi    

echo "Enter user (default: root): "
read user

if [ -z "$user" ]
then
    user='root'
fi 



# Make file
rm $service_name.service 2> /dev/null || echo > /dev/null
cp sample.service $service_name.service 

sed -i -e "s/var_description/$description/g" $service_name.service
sed -i -e "s~var_command~$command~g" $service_name.service
sed -i -e "s~var_arguments~$arguments~g" $service_name.service
sed -i -e "s/var_user/$user/g" $service_name.service

echo "Enter any key and press enter to install in sudo mode. (are you not a sudoer/root?)"
read is_sudo
if [ -z "$is_sudo" ]
then
    sudo mv $service_name.service /etc/systemd/system
    sudo systemctl enable $service_name
else
    mv $service_name.service /etc/systemd/system
    systemctl enable $service_name
fi


echo "Done! Service is now enabled. You can control it with 'service $service_name start|stop|reload'"
