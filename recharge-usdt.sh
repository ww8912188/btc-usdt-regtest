#!/usr/bin/env bash
AUTH="-rpcuser=btcrpc -rpcpassword=123456 -rpcport=8432"

omnicore-cli $AUTH listaccounts

address="mnk2URqujBqMEfhALMby1WZHoBRauW37Kg"
prikey="cQrY4VypAuemJtHmNNJLyx1SNjY7mpfkdQEJpccpLSvan5YoMAkM"

omnicore-cli $AUTH importprivkey $prikey "owner" true
omnicore-cli $AUTH setaccount $address "owner"

# check owner bitcoin balance
omnicore-cli $AUTH getbalance owner

# create new coin
omnicore-cli $AUTH omni_sendissuancefixed $address 1 2 0 "category" "sub category" "usdt" "usdt.com" "usdt for test" "100000"

omnicore-cli $AUTH listaccounts
omnicore-cli $AUTH omni_listproperties
