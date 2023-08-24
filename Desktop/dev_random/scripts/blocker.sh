#!/bin/bash
filename=$1
echo Start
echo "resetting blocked adress"
iptables -F INPUT 
iptables -F OUTPUT 

while read p; do 
    timeout 1 iptables -A INPUT -s $p -j DROP
    timeout 1 iptables -A OUTPUT -d $p -j REJECT
    echo "blocked $p"
  done < "$filename"

