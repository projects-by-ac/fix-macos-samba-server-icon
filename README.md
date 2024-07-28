# fix-macos-samba-server-icon

This bash script is designed to run **on Ubuntu-Server 22.04/24.04 with Samba-Service installed and Samba-Shares configured**

***
<img width="114" align="left" alt="ubuntu-server-crt" src="https://github.com/user-attachments/assets/278f3d39-be6f-4d0f-aef3-01a1b235b210"> 

**BEFORE:**

If you want to access your Ubuntu Server (SMB-shares) from an Apple device 
running macOS and you click on “Network” in the Locations section of the macOS Finder sidebar, 
you may notice an unattractive CRT monitor icon displayed as your Ubuntu Server. 
In some cases, your Ubuntu Server might not be displayed at all.

<img width="114" align="left" alt="ubuntu-server-fix" src="https://github.com/user-attachments/assets/1959f04e-842e-42b1-a300-4357f0d817ad">

**AFTER:**

This script will address this issue "not a bug" by installing Avahi (essentially Apple’s Bonjour) 
allowing you to log in by hostname and browse shares in macOS Finder.
Additionally, this script will create a new smb.service configuration file 
in */etc/avahi/services/* directory in order to assign the correct server icon for macOS.
***
**Install guide:** run script as root + input username as $1 parameter
    
  - **example:**
> *sudo ./fix-macos-smb-icon.sh test1*

![samba-fix](https://github.com/user-attachments/assets/38995ad7-e94f-4c70-add2-5f7df9c7313f)

**This script will:**
- update + upgrade packages
- install avahi service
- create & configure smb.service file
- autoremove leftover packages
- change ownership & permissions smb.service file
  
   - *in case you want to change icon in the future*
- ask to reboot system
  
   - *highly recommended*

**This appears to be the sole solution to this problem thus far...**

 - For more in-depth information about this issue, please refer to the following articles:

   - *https://www.vathorstweb.nl/2022/04/25/samba-bonjour-with-avahi/*
  
   - *https://forums.macrumors.com/threads/wrong-connected-server-icon.2343790/*
