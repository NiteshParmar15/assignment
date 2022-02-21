#!/bin/bash
file="./dumy_nginx.log"
if [ $# -eq 1 ];
then
   file=$1
fi

PS3='Please enter your choice: '
options=("user" "IP")
select opt in "${options[@]}"
do
    case $opt in
        "user")
            echo "User --- Bandwidth"
            awk ' { ip[$2]++ ; bd[$2]+=$10  } END { for ( i in bd ) { print i, bd[i] } }' $file  | sort -nrk 2 | awk -F, 'NR==1, NR==10 {print $1,$2}'
            break
            ;;
        "IP")
            echo "IP --- Bandwidths"
            awk ' { ip[$1]++ ; bd[$1]+=$10  } END { for ( i in bd ) { print i, bd[i] } }' $file  | sort -nrk 2 | awk -F, 'NR==1, NR==10 {print $1,$2}'
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done