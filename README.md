# Fix Samba Share Server Icon on macOS Finder

### Overview
This bash script is designed to run **on Ubuntu-Server 22.04/24.04 with Samba-Service installed and Samba-Shares configured** and resolves the issue of Samba share connections appearing as old CRT monitor icons in macOS Finder. It provides a straightforward solution to ensure proper icon representation for Samba share connections when accessed from macOS.


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

![samba-fix](https://github.com/user-attachments/assets/38995ad7-e94f-4c70-add2-5f7df9c7313f)

### Features
- **Package Update and Upgrade**: The script begins by updating and upgrading the system packages to ensure all software is up-to-date.
- **Avahi Service Installation**: Installs the Avahi service, which is essential for network discovery and service advertisement.
- **Avahi SMB Service Configuration**: Creates and configures a new `smb.service` file in the `/etc/avahi/services/` directory. This configuration assigns the correct icon to the Ubuntu server when viewed in macOS Finder.
- **Ownership and Permissions Adjustment**: Changes the ownership and permissions of the `smb.service` file to allow future modifications, ensuring flexibility in changing the icon if needed.

### Requirements
- Ubuntu Server 22.04/24.04
- Bash
- Run script as root
- Input username as $1 parameter

### Usage
Clone the repository:
   ```bash
   git clone https://github.com/projects-by-ac/fix-macos-samba-server-icon.git
```
   
Navigate to the script directory:
   ```bash
   cd fix-macos-samba-server-icon
```
   
Make the script executable:
   ```bash
   sudo chmod +x fix-macos-smb-icon.sh
```

Run the script with username as $1 parameter:  

*(example running script with 'test1' as username)*  

   ```bash
   sudo ./fix-macos-smb-icon.sh test1
```

### Info

**This appears to be the sole solution to this problem thus far...**

 - For more in-depth information about this issue, please refer to the following articles:

   - *https://www.vathorstweb.nl/2022/04/25/samba-bonjour-with-avahi/*
  
   - *https://forums.macrumors.com/threads/wrong-connected-server-icon.2343790/*
