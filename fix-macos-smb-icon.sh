#!/bin/bash

# Description: ubuntu-server script for samba network icon fix in macOS finder
# Author: Amancio C.
# Date: 15-07-2024

## INSTALL GUIDE

    # run script with sudo privileges + username

    # EXAMPLE: sudo ./ubuntu-server.sh NewUser1
    #          ----|------------------|--------|
    #              |   script-name    |   $1   |


## SCRIPT VARIABLES


    #HIGH INTENSITY (NORMAL)
    GREEN="\e[0;92m"
    YELLOW="\e[0;93m"
    WHITE="\e[0;97m"

    #HIGH INTENSITY (BOLD)
    BGREEN="\e[1;92m"
    BYELLOW="\e[1;93m"
    BWHITE="\e[1;97m"
    
    #HIGH INTENSITY (UNDERLINE)
    UGREEN="\e[4;92m"
    UYELLOW="\e[4;93m"
    UWHITE="\e[4;97m"

    #RESET/END
    ENDCOLOR="\e[0m"

    #SHOW DATE
    Now=$(date)

    #CURRENT USERNAME
    MyUser=$1
    

## POST INSTALL WELCOME MESSAGE

echo ""
echo -e "${BYELLOW}                                                 ,_,${ENDCOLOR} 
        ${BYELLOW}https://github.com/projects-by-ac${ENDCOLOR}       ${YELLOW}(O,O)  
________________________________________________(   )__
                                                 " "
                                                    
        ╔═╗╦═╗╔═╗ ╦╔═╗╔═╗╔╦╗╔═╗  ┌┐ ┬ ┬  ╔═╗╔═╗  
        ╠═╝╠╦╝║ ║ ║║╣ ║   ║ ╚═╗  ├┴┐└┬┘  ╠═╣║      
        ╩  ╩╚═╚═╝╚╝╚═╝╚═╝ ╩ ╚═╝  └─┘ ┴   ╩ ╩╚═╝     
  (@>                                                  
__{||__________________________________________________
   ""||${ENDCOLOR}
${YELLOW}    |   Author:${ENDCOLOR} Amancio C.
${YELLOW}    |   Description:${ENDCOLOR} fix samba network icon for macOS
"
echo ""
echo -e "initializing script on ${GREEN}$Now${ENDCOLOR}"
echo ""
sleep 1
echo -e "${BYELLOW}.......................................................${ENDCOLOR}"
echo ""
echo -e "${BYELLOW}WELCOME! INSTALLING SCRIPT FOR THE FOLLOWING USER:${ENDCOLOR}"
echo ""
echo -e "${BWHITE}$1${ENDCOLOR}"
echo ""
read -p "Do you want to proceed? (Y/n)" -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi
echo ""
echo -e "${BYELLOW}script will start running in${ENDCOLOR}"
sleep 1
echo -e "${BYELLOW}3...${ENDCOLOR}"
sleep 1
echo -e "${BYELLOW}2...${ENDCOLOR}"
sleep 1
echo -e "${BYELLOW}1...${ENDCOLOR}"
sleep 1
echo ""
echo -e "${BYELLOW}*/running script${ENDCOLOR}"
echo ""
sleep 1
echo -e "${BYELLOW}.......................................................${ENDCOLOR}"

## UBUNTU AUTO-SETUP SCRIPT

#UPDATE-UPGRADE-PACKAGES
echo -e "${BYELLOW}***UPDATING PACKAGES***${ENDCOLOR}"
echo ""
apt update -qq -y & pid=$!
i=1
sp="\|/-"
while ps -p $pid > /dev/null
do
    printf "\b%c" "${sp:i++%4:1}"
    sleep 0.1
done
printf "\nDone!\n"
echo ""

echo -e "${BYELLOW}***UPGRADING PACKAGES***${ENDCOLOR}"
echo ""
apt upgrade -q -y & pid=$!
i=1
sp="\|/-"
while ps -p $pid > /dev/null
do
    printf "\b%c" "${sp:i++%4:1}"
    sleep 0.1
done
printf "\nDone!\n"
echo ""

#INSTALL-AVAHI
echo -e "${BYELLOW}***INSTALLING AVAHI***${ENDCOLOR}"
echo ""
apt install avahi-daemon avahi-utils -q -y & pid=$!
i=1
sp="\|/-"
while ps -p $pid > /dev/null
do
    printf "\b%c" "${sp:i++%4:1}"
    sleep 0.1
done
printf "\nDone!\n"
echo ""

#SETUP-CONFIGURATION-FILE
echo -e "${BYELLOW}***FIXING SMB UBUNTU-SERVER ICON FOR MACOS FINDER***${ENDCOLOR}"
echo ""
cat > /etc/avahi/services/smb.service << EOF
<?xml version="1.0" standalone='no'?>
<!DOCTYPE service-group SYSTEM "avahi-service.dtd">
<service-group>
 <name replace-wildcards="yes">%h</name>
 <service>
   <type>_smb._tcp</type>
   <port>445</port>
 </service>
 <service>
   <type>_device-info._tcp</type>
   <port>0</port>
   <txt-record>model=MacPro7,1@ECOLOR=226,226,224</txt-record>
 </service>
</service-group>
EOF
echo "Done!"
echo ""
echo -e "${BWHITE}created new configuration file:${ENDCOLOR}"
echo ""
echo -e "${YELLOW}-------------------------------${ENDCOLOR}"
echo -e "${YELLOW}/etc/avahi/services/${ENDCOLOR}${GREEN}smb.service${ENDCOLOR}"
echo -e "${YELLOW}-------------------------------${ENDCOLOR}"
echo ""

#AUTOREMOVE-PACKAGES
echo -e "${BYELLOW}***REMOVING LEFTOVER PACKAGES***${ENDCOLOR}"
echo ""
apt autoremove -q -y & pid=$!
i=1
sp="\|/-"
while ps -p $pid > /dev/null
do
    printf "\b%c" "${sp:i++%4:1}"
    sleep 0.1
done
printf "\nDone!\n"
echo ""

#CHANGE-CONFIGURATION-FILE-OWNERSHIP-PERMISSIONS
echo -e "${BYELLOW}***CHANGING OWNERSHIP & PERMISSIONS OF CONFIGURATION FILE***${ENDCOLOR}"
chown root /etc/avahi/services/smb.service
chmod 777 /etc/avahi/services/smb.service & pid=$!
i=1
sp="\|/-"
while ps -p $pid > /dev/null
do
    printf "\b%c" "${sp:i++%4:1}"
    sleep 0.1
done
printf "\nDone!\n"
echo ""
echo -e "${YELLOW}-----------------------------------${ENDCOLOR}"
echo -e "${YELLOW}set ${ENDCOLOR}${GREEN}smb.service${ENDCOLOR}${YELLOW} ownership to:  ${ENDCOLOR}${GREEN}root${ENDCOLOR}"
echo -e "${YELLOW}set ${ENDCOLOR}${GREEN}smb.service${ENDCOLOR}${YELLOW} permissions to: ${ENDCOLOR}${GREEN}777${ENDCOLOR}"
echo -e "${YELLOW}-----------------------------------${ENDCOLOR}"
echo ""

#CHANGE-CONFIGURATION-FILE-OWNERSHIP-PERMISSIONS
echo -e "${BYELLOW}***RESTARTING SAMBA SERVICES***${ENDCOLOR}"
systemctl restart smbd nmbd
echo ""
systemctl --no-pager status smbd nmbd | grep Active
echo ""

echo -e "${BYELLOW}***RESTARTING AVAHI-SERVICE***${ENDCOLOR}"
systemctl restart avahi-daemon
echo ""
systemctl --no-pager status avahi-daemon | grep Active
echo ""

## MESSAGE
echo -e "${BYELLOW}***FINISHED INSTALLING ICON FIX FOR SAMBA SERVICE IN MACOS FINDER***${ENDCOLOR}"

#REBOOT-SYSTEM
echo ""
read -p "Reboot Ubuntu-Server? (Y/n)" -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi
systemctl reboot