#!/bin/bash
#
filename=$1
echo "Reading from $1"
iptables-nft -F INPUT 
iptables-nft -F OUTPUT 
echo "Tables were reset"

while read p; do 
    iptables-nft -A INPUT -s $p -j DROP
    iptables-nft -A OUTPUT -d $p -j REJECT
    echo "Just blocked $p"
  done < "$filename"



