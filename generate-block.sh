#!/usr/bin/env bash
while true ; 
do 
bitcoin-cli -rpcuser=btcrpc -rpcpassword=123456 -rpcport=8431 -regtest generate 1 & sleep 5; 
done
