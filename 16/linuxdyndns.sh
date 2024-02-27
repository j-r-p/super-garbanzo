#!/bin/bash
#You can start this script at startup by adding to crontab
#@reboot sh /path/to/linuxdyndns.sh
#Example Case - host in.ter.com
#HOST=in
#DOMAIN=ter.com
#PASSWORD=1234567890abcdef1234567890abcdef
#If you want to check
#every 01 minute: INTERVAL=1
#every 15 minute: INTERVAL=15
# Define a timestamp function
timestamp() {
  date +"%T" # current time
}

HOST=@
DOMAIN=modulesnow.com
PASSWORD=c179532ca51c438392a6e833c7f85c91
INTERVAL=1
dns_ip=$(dig $DOMAIN +short) #Check the registered IP in DNS
while true
do
        timestamp
        #dns_ip=$(dig $DOMAIN +short) #Check the registered IP in DNS
        public_ip=$(dig TXT +short o-o.myaddr.l.google.com @ns1.google.com|awk -F'"' '{print $2}') #Check Public IP
        printf "public_ip=$public_ip and dns_ip=$dns_ip\n"
        if [ "$public_ip" != "$dns_ip" ]
        then
                timestamp
                printf "https://dynamicdns.park-your-domain.com/update?host=$HOST&domain=$DOMAIN&password=$PASSWORD&ip=$public_ip\n"
                curl "https://dynamicdns.park-your-domain.com/update?host=$HOST&domain=$DOMAIN&password=$PASSWORD&ip=$public_ip"
                sleep 300 #Allow the DNS server to update
                dns_ip=$(dig $DOMAIN +short) #Check the new IP and use new IP to compare to current IP
        fi
        sleep $(($INTERVAL*60))
done
