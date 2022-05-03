#!/bin/bash
check_distro() {
	distro_name=$(cat /etc/*elease | grep -w NAME | awk -F '=' '{print $2}')
	echo -e "\033[0;33mLinux distribution name: $distro_name ... \033[0m"
}
install_pack_ubuntu() {
	dpkg -l nmap 1> /dev/null
        if [[ "$?" != "0" ]]; then
                echo -e "\033[0;33mnmap is NOT installed ... \033[0m"
                sudo apt update
                sudo apt -y install nmap
        else
                echo -e "\033[0;32mnmap Is Installed ... \033[0m"
        fi
}
install_pack_centos() {
        rpm -qa | grep -i nmap 1> /dev/null
        if [[ "$?" != "0" ]]; then
                echo -e "\033[0;31mnmap is NOT installed ... \033[0m"
                sudo yum -y install nmap
        else
                echo -e "\033[0;32mnmap Is Installed ... \033[0m"
        fi
}

get_IP() {
        read -p "Please Enter the Destination IP/Host:(ex:127.0.0.1) " IP_DEST
        get_port=$(nmap -sT -p- $IP_DEST | grep -wo ^[0-9]*)
        list_port=( $(echo $get_port) )
        echo -e "Port\tDestination\t"
        echo -e "--------------------------------------------------------------------------"
        for i in ${list_port[@]}
        do
                echo -e "$i\t$IP_DEST"
        done

}


check_distro
if [ $(echo $distro_name | grep -i ubuntu) ]; then
	install_pack_ubuntu
elif [ $(echo $distro_name | grep -i centos) ]; then
	install_pack_centos
else
	echo -e "\033[0;32mLinux distribution name is NOT CENTOS or UBUNTU ... \033[0m"
fi

get_IP
