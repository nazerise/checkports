#!/bin/bash
install_pack() {
        dpkg -l nmap 1> /dev/null
        if [[ "$?" != "0" ]]; then
                echo -e "\033[0;33mNetcat is NOT installed ... \033[0m"
                sudo apt update
                sudo apt install nmap
        else
                echo -e "\033[0;32mNetcat Is Installed ... \033[0m"
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

install_pack
get_IP
