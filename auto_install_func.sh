#!/bin/bash

# **************************************
# Initial developement setup for Linux *
# **************************************

# ---------------------------------------------------------------------
# Name             : Linux Auto-install 
# Description      : Bash script for Linux Initial setup - developement env
# Created By       : Nenad Samardzic
# License          : GNU GENERAL PUBLIC LICENSE Version 3,
# Date:            : September 2018
# Powered          : Bash
# ---------------------------------------------------------------------

# To Make this script executable chmod +x <script_name>.
# To use the script type: ./<script_name>.
# Example: ./my_apps.sh

# ---------------------------------------------------------------------





# "----------------------------------------------------------------"
# "-------------------------  Variables  --------------------------"
# "----------------------------------------------------------------"

# Username of the user that is performing the installation
LINUX_USER=ime

# Target folder name (path) to which you want your tar.gz type of apps to be installed/unpacked
# This script assumes that this location is within "HOME" folder
INSTALL_LOCATION=~/Applications

# Defines which package manager/install command/switches for the package installation
INSTALL_COMMAND='apt-get install -y'

# Defines which package manager/install command/switches for the package installation
LOG_FILE_NAME=Install_log.txt



# *********************************************************************************
# This conditional checks if theres existing INSTALL_LOCATION folder, and if not it creates it
# Also, folder is chown to home user privilages - user is defined in LINUX_USER variable

if [ ! -d "$INSTALL_LOCATION" ];
then
	mkdir -p $INSTALL_LOCATION
fi

chown $LINUX_USER $INSTALL_LOCATION

# *********************************************************************************








# Updating Repositories
update_repositories()
{
	echo -e "\n\n######################  Updating Repositories  #####################"
	echo -e "####################################################################\n"
	sudo apt-get update
}


# Upgrade to latest package lists
upgrade_packages()
{
	echo -e "\n\n######################  Packages Upgrade  #####################"
	echo -e "###############################################################\n"
	sudo apt-get -y upgrade
}


# Installation cleanup
installation_cleanup()
{
	echo -e "\n\n######################  Installation cleanup  #####################"
	echo -e "#####################################################################\n"
	sudo apt-get -y autoclean
	sudo apt-get -y clean
	sudo apt-get -y autoremove
	sudo apt-get -y install -f
	sudo apt-get update --fix-missing
}













# "-----------------  Installing Essential tools  -----------------"

# Installing build-essential
build_essentials_install()
{
	echo -e "\n\n######################  Installing build-essential  #####################"
	echo -e "#########################################################################\n"
	sudo $INSTALL_COMMAND build-essential
	echo  "\n\n************************* Build-essential Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s build-essential | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME

	echo -e "\n\n######################  Installing software-properties-common  #####################"
	echo -e "####################################################################################\n"
	sudo $INSTALL_COMMAND software-properties-common
	echo  "\n\n************************* Software-properties-common Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s software-properties-common | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME

	echo -e "\n\n######################  Installing python-software-properties  #####################"
	echo -e "####################################################################################\n"
	sudo $INSTALL_COMMAND python-software-properties
	echo  "\n\n************************* Python-software-properties Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s python-software-properties | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}

# Installing General Compression tools
compression_tools_install()
{
	echo -e "\n\n######################  Installing General Compression tools #####################"
	echo -e "##################################################################################\n"
	sudo $INSTALL_COMMAND p7zip-rar p7zip-full unace unrar zip unzip sharutils rar uudeview mpack arj cabextract file-roller
}


# Installing GIT
git_install()
{
	echo -e "\n\n######################  Installing GIT  ######################"
	echo -e "##############################################################\n"
	sudo $INSTALL_COMMAND git
	echo  "\n\n************************* Git Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s git | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}



# Installing curl
curl_install()
{
	echo -e "\n\n######################  Installing Curl  ######################"
	echo -e "###############################################################\n"
	sudo $INSTALL_COMMAND curl
	echo  "\n\n************************* Curl Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s curl | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Lynx
lynx_install()
{
	echo -e "\n\n######################  Installing Lynx #####################"
	echo -e "#############################################################\n"
	sudo $INSTALL_COMMAND lynx
	echo  "\n\n************************* Lynx Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s lynx | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}



# Installing python-pip
pip_install()
{
	echo -e "\n\n######################  Installing python-pip  #####################"
	echo -e "####################################################################\n"
	sudo $INSTALL_COMMAND python-pip
	
	echo  "\n\n************************* PIP Install status *************************" >> $LOG_FILE_NAME
	pip -V >> $LOG_FILE_NAME
}


# Installing python-pip3
pip3_install()
{
	echo -e "\n\n######################  Installing python3-pip  #####################"
	echo -e "#####################################################################\n"
	sudo $INSTALL_COMMAND python3-pip
	echo  "\n\n************************* PIP3 Install status *************************" >> $LOG_FILE_NAME
	pip3 -V >> $LOG_FILE_NAME
}


# Installing openssl components
openssl_install()
{
	echo -e "\n\n######################  Installing openssh-server & openssh-client  #####################"
	echo -e "#########################################################################################\n"
	sudo $INSTALL_COMMAND openssh-server openssh-client
	echo  "\n\n************************* Openssh Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s openssh-server | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
	sudo dpkg -s openssh-client | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME

	echo -e "\n\n######################  Installing openssl  #####################"
	echo -e "#################################################################\n"
	sudo $INSTALL_COMMAND openssl
	sudo $INSTALL_COMMAND zlib1g zlib1g-dev libpcre3 libpcre3-dev libssl-dev
	echo  "\n\n************************* Openssl Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s openssl | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}



# Installing yarn
yarn_install()
{
	echo -e "\n\n########################  Installing yarn  ##########################"
	echo -e "#####################################################################\n"

	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
	update_repositories

	sudo $INSTALL_COMMAND yarn
	echo  "\n\n************************* Yarn Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s yarn | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}








# "-------------------  Installing Oracle JAVA  -------------------"

java_install()
{
	echo -e "\n\n######################  JAVA PPA  #####################\n"
	sudo add-apt-repository -y ppa:webupd8team/java	
	update_repositories

	echo -e "\n\n######################  Installing Oracle Java  #####################"
	echo -e "#####################################################################\n"
	sudo $INSTALL_COMMAND oracle-java8-installer

	echo -e "\n\n######################  Installing Java Set-default #####################"
	echo -e "#########################################################################\n"
	sudo $INSTALL_COMMAND oracle-java8-set-default

	echo  "\n\n************************* JAVA Install status *************************" >> $LOG_FILE_NAME
	java -version >> $LOG_FILE_NAME
	which java >> $LOG_FILE_NAME
}







# "----------------  Installing Multimedia tools  -----------------"

# Installing ubuntu-restricted-extras
ubuntu_restricted_extras_install()
{
	echo -e "\n\n######################  Installing ubuntu-restricted-extras  #####################"
	echo -e "##################################################################################\n"
	sudo $INSTALL_COMMAND ubuntu-restricted-extras
	echo  "\n\n************************* ubuntu-restricted-extras Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s ubuntu-restricted-extras | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Microsoft core fonts
msttcorefonts_install()
{
	echo -e "\n\n######################  Installing Microsoft core fonts  #####################"
	echo -e "##############################################################################\n"
	sudo $INSTALL_COMMAND msttcorefonts
}


# Installing flashplugin-installer
flashplugin_install()
{
	echo -e "\n\n######################  Installing flashplugin-installer  #####################"
	echo -e "###############################################################################\n"
	sudo $INSTALL_COMMAND flashplugin-installer
	echo  "\n\n************************* flashplugin-installer Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s flashplugin-installer | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing DVD libdvdread4
libdvd_install()
{
	echo -e "\n\n######################  Installing DVD libdvdread4  #####################"
	echo -e "#########################################################################\n"
	sudo $INSTALL_COMMAND libdvdcss2 libdvdread4 libdvdnav4
	sudo /usr/share/doc/libdvdread4/install-css.sh
	echo  "\n\n************************* libdvdcss2 Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s libdvdcss2 | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing VLC Player
vlc_install()
{
	echo -e "\n\n######################  Installing VLC Player  #####################"
	echo -e "####################################################################\n"
	sudo $INSTALL_COMMAND vlc
	echo  "\n\n************************* vlc Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s vlc | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing SMPlayer
smplayer_install()
{
	echo -e "\n\n######################  Installing SMPlayer  #####################"
	echo -e "##################################################################\n"
	sudo $INSTALL_COMMAND smplayer
	echo  "\n\n************************* smplayer Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s smplayer | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Audacious
audacious_install()
{
	echo -e "\n\n#####################  Installing Audacious  #####################"
	echo -e "##################################################################\n"
	sudo $INSTALL_COMMAND audacious
	sudo $INSTALL_COMMAND audacious-plugins
	echo  "\n\n************************* audacious Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s audacious | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Audacity
audacity_install()
{
	echo -e "\n\n######################  Installing Audacity  #####################"
	echo -e "##################################################################\n"
	sudo $INSTALL_COMMAND audacity
	sudo $INSTALL_COMMAND audacity-data
	echo  "\n\n************************* audacity Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s audacity | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}










# "---------------=---  Installing MQTT Tools  --------------------"

# Installing MQTT Tools
mqtt_install()
{
	echo -e "\n\n----------------------------------------------------------------"
	echo -e "-------------------  Installing MQTT Tools  --------------------"
	echo -e "----------------------------------------------------------------"
	echo -e "\n\n######################  Installing mosquitto & mosquitto-clients  #####################"
	echo -e "#######################################################################################\n"
	sudo $INSTALL_COMMAND mosquitto mosquitto-clients
	echo  "\n\n************************* mosquitto Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s mosquitto | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}

# Installing paho-mqtt
paho_mqtt_install()
{
	echo -e "\n\n######################  Installing paho-mqtt  #####################"
	echo -e "###################################################################\n"
	sudo -H pip install paho-mqtt
	echo  "\n\n************************* paho-mqtt Install status *************************" >> $LOG_FILE_NAME
	sudo pip show paho-mqtt >> $LOG_FILE_NAME
}












# "------------------  Installing HTTPS Addons  -------------------"

# Install Packages to allow apt to use a repository over HTTPS
apt_https_install()
{
	echo -e "\n\n######################  Installing apt-transport-https #####################"
	echo -e "############################################################################\n"
	sudo $INSTALL_COMMAND apt-transport-https
	echo  "\n\n************************* apt-transport-https Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s apt-transport-https | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}

# Installing ca-certificates
ca_certificates_install()
{
	echo -e "\n\n######################  Installing ca-certificates #####################"
	echo -e "########################################################################\n"
	sudo $INSTALL_COMMAND ca-certificates
	echo  "\n\n************************* ca-certificates Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s ca-certificates | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}









# "------------------  Installing Tools & Soft  -------------------"

# Installing dconf
dconf_editor_install()
{
	echo -e "\n\n######################  Installing dconf #####################"
	echo -e "##############################################################\n"
	sudo $INSTALL_COMMAND dconf-cli dconf-editor
	echo  "\n\n************************* dconf-editor Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s dconf-editor | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing KeePassX
keepassx_install()
{
	echo -e "\n\n######################  Installing KeePassX #####################"
	echo -e "#################################################################\n"
	sudo $INSTALL_COMMAND keepassx
	echo  "\n\n************************* keepassx Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s keepassx | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing DropBox
dropbox_install()
{
	echo -e "\n\n######################  Installing DropBox #####################"
	echo -e "################################################################\n"
	sudo $INSTALL_COMMAND dropbox
	echo  "\n\n************************* dropbox Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s dropbox | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Krusader with krename
krusader_install()
{
	echo -e "\n\n######################  Installing Krusader #####################"
	echo -e "#################################################################\n"
	sudo $INSTALL_COMMAND krusader
	sudo $INSTALL_COMMAND krename
	echo  "\n\n************************* krusader Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s krusader | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
	sudo dpkg -s krename | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Midnight Commander Editor
midnightCommander_install()
{
	echo -e "\n\n######################  Installing MC Editor #####################"
	echo -e "##################################################################\n"
	sudo $INSTALL_COMMAND mc
	echo  "\n\n************************* Midnight Commander Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s mc | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Gparted with dependencies
gparted_install()
{
	echo -e "\n\n######################  Installing Gparted with dependencies #####################"
	echo -e "##################################################################################\n"
	sudo $INSTALL_COMMAND gparted
	sudo $INSTALL_COMMAND udftools
	sudo $INSTALL_COMMAND reiser4progs
	sudo $INSTALL_COMMAND hfsutils
	sudo $INSTALL_COMMAND f2fs-tools
	sudo $INSTALL_COMMAND f2fs-tools
	sudo $INSTALL_COMMAND nilfs-tools
	sudo $INSTALL_COMMAND exfat-utils exfat-fuse
	echo  "\n\n************************* gparted Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s gparted | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing HardInfo
hardinfo_install()
{
	echo -e "\n\n######################  Installing HardInfo #####################"
	echo -e "#################################################################\n"
	sudo $INSTALL_COMMAND hardinfo
	echo  "\n\n************************* hardinfo Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s hardinfo | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing ScreenFetch
screenFetch_install()
{
	echo -e "\n\n######################  Installing ScreenFetch #####################"
	echo -e "####################################################################\n"
	sudo $INSTALL_COMMAND screenfetch
	echo  "\n\n************************* screenfetch Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s screenfetch | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Shutter
shutter_install()
{
	echo -e "\n\n######################  Installing Shutter #####################"
	echo -e "################################################################\n"
	sudo $INSTALL_COMMAND shutter
	echo  "\n\n************************* shutter Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s shutter | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing SreenRuller
sreenRuller_install()
{
	echo -e "\n\n######################  Installing SreenRuller #####################"
	echo -e "####################################################################\n"
	sudo $INSTALL_COMMAND screenruler
	echo  "\n\n************************* screenruler Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s screenruler | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Konsole terminal
konsole_install()
{
	echo -e "\n\n######################  Installing Konsole #####################"
	echo -e "################################################################\n"
	sudo $INSTALL_COMMAND konsole
	echo  "\n\n************************* konsole Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s konsole | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Terminator terminal
terminator_install()
{
	echo -e "\n\n######################  Installing Terminator #####################"
	echo -e "###################################################################\n"
	sudo $INSTALL_COMMAND terminator
	echo  "\n\n************************* terminator Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s terminator | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing indicator-weather
indicator_weather_install()
{
	echo -e "\n\n######################  Weather Indicator via PPA  #####################\n"
	sudo add-apt-repository -y ppa:kasra-mp/ubuntu-indicator-weather
	update_repositories

	echo -e "\n\n######################  Installing indicator-weather #####################"
	echo -e "##########################################################################\n"
	sudo $INSTALL_COMMAND indicator-weather
	echo  "\n\n************************* weather-indicator Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s indicator-weather | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing indicator-cpufre
indicator_cpufre_install()
{
	echo -e "\n\n######################  Installing indicator-cpufreq #####################"
	echo -e "##########################################################################\n"
	sudo $INSTALL_COMMAND indicator-cpufreq
	echo  "\n\n************************* CPUfreq-indicator Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s indicator-cpufreq | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Install Samba share
samba_install()
{
	echo -e "\n\n######################  Installing Samba #####################"
	echo -e "##############################################################\n"
	sudo $INSTALL_COMMAND samba samba-common python-dnspython
	echo  "\n\n************************* ____ Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s ___ | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME

	echo  "\n\n************************* Samba Install status *************************" >> $LOG_FILE_NAME
	whereis samba >> $LOG_FILE_NAME
	
}


libreoffice_install()
{
	echo -e "\n\n######################  LibreOffice PPA  #####################\n"
	sudo add-apt-repository -y ppa:libreoffice/ppa
	update_repositories
}

# Installing synapse
synapse_install()
{
	echo -e "\n\n###########################  Installing synapse ##########################"
	echo -e "##########################################################################\n"
	sudo $INSTALL_COMMAND synapse
	echo  "\n\n************************* synapse Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s synapse | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Snap package manager 
snap_install()
{
	echo -e "\n\n######################  Installing SNAP #####################"
	echo -e "#############################################################\n"
	sudo $INSTALL_COMMAND snapd
	
	echo -e "\n\n######################  Adding Snap PATH to bashrc  #####################"
	echo -e "#########################################################################\n"
	echo -e 'export PATH="$PATH:/snap/bin"' >> ~/.bashrc

	echo  "\n\n************************* Snap Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s snapd | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}



# Installing SpeedCrunch
speedcrunch_install()
{
	echo -e "\n\n#########################  Installing SpeedCrunch ########################"
	echo -e "##########################################################################\n"
	sudo $INSTALL_COMMAND speedcrunch
	echo  "\n\n************************* speedcrunch Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s speedcrunch | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}









# "-----------------  Installing Editors & IDEs  ------------------"

# Installing Geany editor
geany_install()
{
	echo -e "\n\n######################  Installing Geany editor #####################"
	echo -e "#####################################################################\n"
	sudo $INSTALL_COMMAND geany
	echo  "\n\n************************* Geany Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s geany | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Visual Code editor
visualCode_install()
{
	echo -e "\n\n######################  Installing Visual Code editor #####################"
	echo -e "###########################################################################\n"
	echo -e "-----------------  VS Curl Download  ------------------"
	# curl -L "https://go.microsoft.com/fwlink/?LinkID=760868" > vscode_package.deb

	echo -e "-----------------  VS wget Download  ------------------"
	wget -r -l1 --no-parent --no-directories -e robots=off '*amd64.deb' https://go.microsoft.com/fwlink/?LinkID=760868
	mv index.html* vscode_package.deb

	sudo dpkg -i vscode_package.deb
	rm vscode_package.deb

	echo  "\n\n************************* Visual Code Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s code | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing ATOM Editor
atom_install()
{
	echo -e "\n\n######################  Atom PPA  #####################\n"
	sudo add-apt-repository -y ppa:webupd8team/atom
	update_repositories

	echo -e "\n\n######################  Installing ATOM Editor #####################"
	echo -e "####################################################################\n"
	sudo $INSTALL_COMMAND atom
	echo  "\n\n************************* Atom Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s atom | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}

# Installing Brackets editor
brackets_install()
{
	echo -e "\n\n######################  Brackets PPA  #####################\n"
	sudo add-apt-repository -y ppa:webupd8team/brackets
	update_repositories

	echo -e "\n\n######################  Installing Brackets editor #####################"
	echo -e "########################################################################\n"
	sudo $INSTALL_COMMAND brackets
	echo  "\n\n************************* Brackets Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s brackets | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Midnight Commander Editor
sublime_install()
{
	echo -e "\n\n#################  Installing Sublime-text Editor ################"
	echo -e "##################################################################\n"
	sudo $INSTALL_COMMAND sublime-text
	echo  "\n\n************************* Sublime-text Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s sublime-text | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME 
}









# "-----------------  Installing DataBase Toosl  ------------------"

# Installing mysql-server
mysql_server_install()
{
	echo -e "\n\n######################  Installing mysql-server #####################"
	echo -e "#####################################################################\n"
	sudo $INSTALL_COMMAND mysql-server
	echo  "\n\n************************* mysql-server Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s mysql-server | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing mysql-workbench
mysq_workbench_install()
{
	echo -e "\n\n######################  Installing mysql-workbench #####################"
	echo -e "########################################################################\n"
	sudo $INSTALL_COMMAND mysql-workbench
	echo  "\n\n************************* mysql-workbench Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s mysql-workbench | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}







# "---------------  Installing Developement Tools  ----------------"

# Installing MELD compare
meld_install()
{
	echo -e "\n\n######################  Installing MELD compare #####################"
	echo -e "#####################################################################\n"
	sudo $INSTALL_COMMAND meld
	echo  "\n\n************************* meld Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s meld | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Zeal - offline documentation viewer
zeal_install()
{
	echo -e "\n\n#########################  Installing zeal ##########################"
	echo -e "#####################################################################\n"
	sudo $INSTALL_COMMAND zeal
	echo  "\n\n************************* zeal Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s zeal | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}

remarkable_install()
{
	echo  "\n\n###################  Installing Remarkable ###################"
	echo  "##############################################################\n"
	echo  "\n\n----------------------  Generating Remarkable Download link  --------------------------"
	REMARKABLE_LINK=$(lynx --dump https://remarkableapp.github.io/linux/download.html | grep all.deb | sed 's/^.*http/http/')
	echo $REMARKABLE_LINK

	echo -e "\n\n----------------------  Downloading Remarkable  --------------------------"
	wget $REMARKABLE_LINK -O remarkable.deb

	echo -e "\n\n----------------------  Installing Remarkable package  --------------------------"
	sudo dpkg -i remarkable.deb
	rm remarkable.deb
	echo  "\n\n************************* Remarkable Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s remarkable | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}

retext_install()
{
	echo -e "\n\n#########################  Retext Markdown ##########################"
	echo -e "#####################################################################\n"
	sudo $INSTALL_COMMAND retext
	echo  "\n\n************************* retext Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s retext | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME





# "------------  Installing Docker & Docker Compose  --------------"

# Installing docker-ce docker-compose
docker_install()
{
	echo -e "\n\n######################  DOCKER apt repo  #####################\n"
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
	update_repositories

	echo -e "\n\n######################  Removing previous Docker Instllations  #####################"
	echo -e "####################################################################################\n"
	sudo apt-get remove docker docker-engine docker.io

	echo -e "\n\n######################  Installing docker-ce docker-compose  #####################"
	echo -e "##################################################################################\n"
	sudo $INSTALL_COMMAND docker-ce docker-compose
	echo  "\n\n************************* Docker Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s docker-ce | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
	sudo dpkg -s docker-compose | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}







# "----------------------  Installing IDEs  -----------------------"

# Installing POSTMAN
postman_install()
{
	echo -e "----------------------  Installing POSTMAN  -----------------------"
	echo -e "\n\n######################  Downloading POSTMAN #####################\n"
	wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz


	echo -e "\n\n######################  Extracting POSTMAN #####################\n"
	sudo tar -xzf postman.tar.gz -C $INSTALL_LOCATION/
	sudo chown -R $LINUX_USER:$LINUX_USER $INSTALL_LOCATION/Post*

	sudo ln -s $INSTALL_LOCATION/Postman/Postman /usr/bin/postman
	rm postman.tar.gz

	echo  "\n\n************************* Postman Install status *************************" >> $LOG_FILE_NAME
	cat $INSTALL_LOCATION/Postman/app/version >> $LOG_FILE_NAME
	
}


# Installing Android Studio
android_install()
{
	echo -e "\n\n--------------------------------------------------------------------------"
	echo -e "----------------------  Installing Android Studio  -----------------------"
	echo -e "--------------------------------------------------------------------------"

	echo -e "\n\n######################  Generating Android Studio Download link #####################\n"
	ANDROID_STUDIO_LINK=$(lynx --dump https://developer.android.com/studio/#downloads | grep -w linux.zip | grep https://dl.google.com | sed 's/^.*http/http/')
	echo -e $ANDROID_STUDIO_LINK

	echo -e "\n\n######################  Downloading Android Studio #####################\n"
	wget $ANDROID_STUDIO_LINK -O android_studio.zip

	echo -e "\n\n######################  Extracting Android Studio #####################\n"
	unzip android_studio.zip -d "$INSTALL_LOCATION/"
	sudo chown -R $LINUX_USER:$LINUX_USER $INSTALL_LOCATION/android*
	rm android_studio.zip

	echo  "\n\n************************* Android Studio Install status *************************" >> $LOG_FILE_NAME
	echo -e $ANDROID_STUDIO_LINK >> $LOG_FILE_NAME
	cat $INSTALL_LOCATION/android-studio/build.txt >> $LOG_FILE_NAME
	
}


# NODE.js setup
node_install()
{
	# NODE.js setup
	echo -e "\n\n----------------------------------------------------------------"
	echo -e "-----------------------  NODE.js setup  ------------------------"
	echo -e "----------------------------------------------------------------"

	echo -e "\n\n----------------------  Downloading NODE.js  --------------------------"
	wget -r -l1 --no-parent --no-directories -e robots=off -A '*linux-x64.tar.gz' https://nodejs.org/download/release/latest/

	echo -e "\n\n----------------------  Extracting NODE.js to INSTALL_LOCATION  --------------------------"
	sudo tar -xzf *linux-x64.tar.gz -C $INSTALL_LOCATION/

	echo -e "\n\n----------------------  Renaming to NODE_INSTALL --------------------------"
	mv $INSTALL_LOCATION/node-* $INSTALL_LOCATION/node_install

	echo -e "\n\n----------------------  Chown Directory & Deleting NODEjs Download --------------------------"
	sudo chown -R $LINUX_USER:$LINUX_USER $INSTALL_LOCATION/node*
	rm *linux-x64.tar.gz

	echo -e "\n\n----------------------  Adding NODEjs PATH to bashrc --------------------------"
	echo -e 'export PATH="$PATH:~/Applications/node_install/bin"' >> ~/.bashrc #edit this location per your folder settilgs

	echo -e "\n\n----------------------  Creating NODEjs lnk --------------------------"
	sudo sudo ln -s $INSTALL_LOCATION/node_install/bin/node /usr/bin/nodejs
	sudo sudo ln -s $INSTALL_LOCATION/node_install/bin/node /usr/bin/node

	echo  "\n\n************************* Node Install status *************************" >> $LOG_FILE_NAME
	node -v >> $LOG_FILE_NAME
	nodejs -v >> $LOG_FILE_NAME
	npm -v >> $LOG_FILE_NAME
}


# Installing Arduino
arduino_install()
{
	echo -e "\n\n######################  Installing Arduino #####################"
	echo -e "#####################################################################\n"
	sudo $INSTALL_COMMAND arduino-core
	sudo $INSTALL_COMMAND librxtx-java libjna-java

	echo  "\n\n----------------------  Generating Arduino Download link  --------------------------"
	ARDUINO_LINK=$(lynx --dump https://www.arduino.cc/en/Main/Software | grep linux64.tar.xz | sed 's/^.*http/http/')
	echo $ARDUINO_LINK

	echo -e "\n\n----------------------  Downloading Arduino  --------------------------"
	wget $ARDUINO_LINK -O arduino.tar.xz

	echo -e "\n\n----------------------  Extracting Arduino to INSTALL_LOCATION  --------------------------"
	
	sudo adduser $LINUX_USER dialout
}








# "--------------------  Installing Browsers  ---------------------"

# Installing CHROMIUM
chromium_install()
{
	echo -e "\n\n######################  Installing CHROMIUM #####################"
	echo -e "#################################################################\n"
	sudo $INSTALL_COMMAND chromium-browser

	echo  "\n\n************************* chromium-browser Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s chromium-browser | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing OPERA
opera_install()
{
	echo -e "\n\n######################  Installing OPERA #####################"
	echo -e "##############################################################\n"
	sudo $INSTALL_COMMAND opera

	echo  "\n\n************************* opera Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s opera | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing CHROME
chrome_install()
{
	echo -e "\n\n######################  Installing CHROME #####################"
	echo -e "###############################################################\n"
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome-stable_current_amd64.deb
	rm google-chrome-stable_current_amd64.deb

	echo  "\n\n************************* google chrome Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s google-chrome-stable | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}









# "--------------------  Installing Skype, Viber, Slack  ---------------------"

# Installing Skype
skype_install()
{
	echo -e "\n\n#######################  Installing Skype #####################"
	echo -e "###############################################################\n"
	wget https://go.skype.com/skypeforlinux-64.deb -O skype_amd64.deb
	sudo dpkg -i skype_amd64.deb
	rm skype_amd64.deb

	echo  "\n\n************************* Skype Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s skypeforlinux | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Slack 
slack_install()
{
	echo -e "\n\n###################### Installing Slack #####################"
	echo -e "#############################################################\n"

	echo -e "\n\n----------------------  Generating Slack Download link  --------------------------"
	SLACK_LINK=$(lynx --dump https://slack.com/downloads/instructions/ubuntu | grep amd64.deb | sed 's/^.*http/http/')
	echo -e $SLACK_LINK

	echo -e "\n\n----------------------  Downloading Slack  --------------------------"
	wget $SLACK_LINK -O slack_amd64.deb

	echo -e "\n\n----------------------  Installing Slack package  --------------------------"
	sudo dpkg -i slack_amd64.deb
	rm slack_amd64.deb

	echo  "\n\n************************* Slack Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s slack | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Viber
viber_install()
{
	echo -e "\n\n######################  Installing Viber #####################"
	echo -e "##############################################################\n"
	echo -e "\n\n----------------------  Generating Viber Download link  --------------------------"
	VIBER_LINK=$(lynx --dump https://www.viber.com/download/ | grep viber.deb | sed 's/^.*http/http/')
	echo -e $VIBER_LINK
	echo -e "\n\n----------------------  Downloading Viber  --------------------------"
	wget $VIBER_LINK -O viber.deb

	echo -e "\n\n----------------------  Installing Viber package  --------------------------"
	sudo dpkg -i viber.deb
	rm viber.deb
	echo  "\n\n************************* viber Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s viber | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}








# "----------------------  VirtualBox setup  ----------------------"

# Installing VirtualBox & Extension Pack
virtualbox_install()
{
	echo -e "\n\n######################  Generating VirtualBox Download link #####################\n"
	VIRTUALBOX_LINK=$(lynx --dump https://www.virtualbox.org/wiki/Linux_Downloads | grep -w bionic_amd64.deb | sed 's/^.*http/http/')
	echo -e $VIRTUALBOX_LINK

	echo -e "\n\n###############  Generating VirtualBox Extension Pack Download link ###################\n"
	VIRTUALBOX_EXTENSION_LINK=$(lynx --dump https://www.virtualbox.org/wiki/Downloads | grep -w vbox-extpack | sed 's/^.*http/http/')
	echo -e $VIRTUALBOX_EXTENSION_LINK

	echo -e "\n\n####################  Downloading VirtualBox & Extension Pack #####################\n"
	wget $VIRTUALBOX_LINK -O VirtualBox.deb
	wget $VIRTUALBOX_EXTENSION_LINK -O Oracle_VM_VirtualBox_Extension_Pack.vbox-extpack

	echo -e "\n\n####################  Installing VirtualBox & Extension Pack #####################\n"
	sudo dpkg -i VirtualBox.deb
	rm VirtualBox.deb

	echo  "\n\n************************* VirtualBox Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s virtualbox | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}








# "---------------------  YOUTUBE_DL setup  -----------------------"

# Installing YOUTUBE_DL
youtube_dl_install()
{
	echo -e "\n\n######################  YOUTUBE_DL preconditions #####################\n"
	sudo $INSTALL_COMMAND ffmpeg rtmpdump
	mkdir $INSTALL_LOCATION/youtube_downloader

	echo -e "\n\n######################  Downloading YOUTUBE_DL #####################\n"
	sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O $INSTALL_LOCATION/youtube_downloader/youtube-dl
	sudo chmod 755 $INSTALL_LOCATION/youtube_downloader/youtube-dl
	sudo chown -R $LINUX_USER:$LINUX_USER $INSTALL_LOCATION/youtube_downloader
	cd $INSTALL_LOCATION/youtube_downloader

	echo  "\n\n************************* YOUTUBE_DL Install status *************************" >> $LOG_FILE_NAME
	$INSTALL_LOCATION/youtube_downloader/youtube-dl --version >> $LOG_FILE_NAME
}






# "------------------------  CLI tools  ---------------------------"

# CLI tools install
cli_tools_install()
{
	echo -e "\n\n######################  CLI tools install #####################"
	echo -e "##############################################################\n"
	sudo $INSTALL_COMMAND dstat
	sudo $INSTALL_COMMAND vnstat
	sudo $INSTALL_COMMAND htop
	sudo $INSTALL_COMMAND mycli
	echo  "\n\n************************* CLI tools Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s dstat | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
	sudo dpkg -s vnstat | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
	sudo dpkg -s htop | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
	sudo dpkg -s mycli | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}






# "------------------------  ZSH and Oh-My-Zsh Install ---------------------------"

# CLI tools install
zsh_install()
{
	echo -e "\n\n################  ZSH and Oh-My-Zsh Install ##################"
	echo -e "##############################################################\n"

	sudo $INSTALL_COMMAND zsh git-core
	sudo $INSTALL_COMMAND zsh-syntax-highlighting
	sudo $INSTALL_COMMAND zsh-theme-powerlevel9k
	sudo $INSTALL_COMMAND powerline fonts-powerline

	zsh --version
	which zsh
	whereis zsh

	sudo usermod -s /usr/bin/zsh $(whoami)

	wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
	echo "source /usr/share/powerlevel9k/powerlevel9k.zsh-theme" >> ~/.zshrc
	echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

	echo  "\n\n************************* ZSH Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s zsh | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
	zsh --version >> $LOG_FILE_NAME
	which zsh >> $LOG_FILE_NAME
	whereis zsh >> $LOG_FILE_NAME
}



# "------------------------  QT5 Install  ---------------------------"

# QT5 install
qt5_install()
{
	echo -e "\n\n########################  QT5 install ########################"
	echo -e "##############################################################\n"
	sudo $INSTALL_COMMAND python3-pyqt5.qtwebkit
	sudo $INSTALL_COMMAND mesa-common-dev
	sudo $INSTALL_COMMAND libglu1-mesa-dev
	sudo $INSTALL_COMMAND libfontconfig1

	sudo pip install PyQt5

	echo  "\n\n************************* ____ Install status *************************" >> $LOG_FILE_NAME
	pip show PyQt5 >> $LOG_FILE_NAME




# ToDo
# ===========
# Team Viewer
# pyCharm
# IntelliJ IDEA
# Arduino complete


























echo -e "\n\n----------------------------------------------------------------"
echo -e "-------------------  Updating Repositories  --------------------"
echo -e "----------------------------------------------------------------"
update_repositories



echo -e "\n\n----------------------------------------------------------------"
echo -e "----------------------  Packages Upgrade  ----------------------"
echo -e "----------------------------------------------------------------"
update_repositories




echo -e "\n\n----------------------------------------------------------------"
echo -e "--------------------  Installation cleanup  --------------------"
echo -e "----------------------------------------------------------------"
installation_cleanup




echo -e "\n\n----------------------------------------------------------------"
echo -e "-----------------  Installing Essential tools  -----------------"
echo -e "----------------------------------------------------------------"
build_essentials_install
compression_tools_install
git_install
curl_install
lynx_install
yarn_install




echo -e "\n\n----------------------------------------------------------------"
echo -e "-------------------  Installing Oracle JAVA  -------------------"
echo -e "----------------------------------------------------------------"
java_install




echo -e "\n\n----------------------------------------------------------------"
echo -e "--------------  Installing Microsoft core fonts  ---------------"
echo -e "----------------------------------------------------------------"
msttcorefonts_install




echo -e "\n\n----------------------------------------------------------------"
echo -e "----------------  Installing Multimedia tools  -----------------"
echo -e "----------------------------------------------------------------"
ubuntu_restricted_extras_install
flashplugin_install
libdvd_install
vlc_install
smplayer_install
audacious_install
audacity_install



echo -e "\n\n----------------------------------------------------------------"
echo -e "---------------=---  Installing MQTT Tools  --------------------"
echo -e "----------------------------------------------------------------"
mqtt_install
paho_mqtt_install




echo -e "\n\n----------------------------------------------------------------"
echo -e "------------------  Installing HTTPS Addons  -------------------"
echo -e "----------------------------------------------------------------"
apt_https_install
ca_certificates_install





echo -e "\n\n----------------------------------------------------------------"
echo -e "------------------  Installing Tools & Soft  -------------------"
echo -e "----------------------------------------------------------------"
dconf_editor_install
keepassx_install
dropbox_install
krusader_install
midnightCommander_install
gparted_install
hardinfo_install
screenFetch_install
shutter_install
sreenRuller_install
konsole_install
terminator_install
indicator_weather_install
indicator_cpufre_install

samba_install
libreoffice_install
synapse_install
snap_install
speedcrunch_install

pip_install
pip3_install
openssl_install




# Install Editors
echo -e "\n\n----------------------------------------------------------------"
echo -e "-----------------  Installing Editors & IDEs  ------------------"
echo -e "----------------------------------------------------------------"
geany_install
visualCode_install
atom_install
brackets_install
sublime_install






echo -e "\n\n----------------------------------------------------------------"
echo -e "--------------------  Installation cleanup  --------------------"
echo -e "----------------------------------------------------------------"
installation_cleanup






echo -e "\n\n----------------------------------------------------------------"
echo -e "-----------------  Installing DataBase Toosl  ------------------"
echo -e "----------------------------------------------------------------"
mysql_server_install
mysq_workbench_install





echo -e "\n\n----------------------------------------------------------------"
echo -e "------------  Installing Docker & Docker Compose  --------------"
echo -e "----------------------------------------------------------------"
docker_install





echo -e "\n\n----------------------------------------------------------------"
echo -e "--------------------  Installing Browsers  ---------------------"
echo -e "----------------------------------------------------------------"
chromium_install
opera_install
chrome_install






echo -e "\n\n---------------------------------------------------------------------------"
echo -e "--------------------  Installing Skype, Viber, Slack  ---------------------"
echo -e "---------------------------------------------------------------------------"
skype_install
slack_install
viber_install






echo -e "\n\n----------------------------------------------------------------"
echo -e "---------------------  YOUTUBE_DL setup  -----------------------"
echo -e "----------------------------------------------------------------"
youtube_dl_install





echo -e "\n\n----------------------------------------------------------------"
echo -e "----------------------  VirtualBox setup  ----------------------"
echo -e "----------------------------------------------------------------"
virtualbox_install






# Postman
echo -e "\n\n----------------------------------------------------------------"
echo -e "----------------------  Installing IDEs  -----------------------"
echo -e "----------------------------------------------------------------\n\n"
postman_install
android_install
node_install
arduino_install



echo -e "\n\n----------------------------------------------------------------"
echo -e "------------------------  CLI tools  ---------------------------"
echo -e "----------------------------------------------------------------"
cli_tools_install
zsh_install


echo -e "\n\n----------------------------------------------------------------"
echo -e "---------------  Additional Developement Tools  ----------------"
echo -e "----------------------------------------------------------------"
meld_install
zeal_install
qt5_install
remarkable_install
retext_install


echo -e "\n\n----------------------------------------------------------------"
echo -e "--------------------  Installation cleanup  --------------------"
echo -e "----------------------------------------------------------------"
installation_cleanup






echo -e "\n\n----------------------------------------------------------------"
echo -e "-------------------  Installation FINISHED  --------------------"
echo -e "----------------------------------------------------------------\n\n"