#!/usr/bin/env bash

######
# Now the type of our all tx is simple send, so we just make a simple send below.
####
AUTH="-rpcuser=btcrpc -rpcpassword=123456 -rpcport=8432"
# -e: when the return of command is unequal 0, shell will be exited.
set -e

######################## Prepare Transaction
# this command is depend on issue-new-coin.sh, where owner address store
sender_address="mnk2URqujBqMEfhALMby1WZHoBRauW37Kg"
sender_private_key="cQrY4VypAuemJtHmNNJLyx1SNjY7mpfkdQEJpccpLSvan5YoMAkM"

receiver_address="mkUYRLVegHRTUL39PU6vVz2KQxn246EmWj"

# new coin property id, it depends.
property_id=3

# dust value it is suggested to be 546, it will be sent to target address
dust_value=0.00000546

# unspent bitcoin amount
bitcoin_amount=0.1

# change bitcoin amount
change_amount=0.099

# prepare tx bitcoin fee for new coin tx
pre_transaction=`omnicore-cli $AUTH sendtoaddress $sender_address $bitcoin_amount`

# will transfer new coin amount, set it by yourself
amount=3

# generate omni layer payload for new coin tx
payload=`omnicore-cli $AUTH omni_createpayload_simplesend $property_id $amount` 

# add tx input -> vin
transaction_input=`omnicore-cli $AUTH omni_createrawtx_input "" $pre_transaction 0`

# add dust tx output for receiver address, this must go before payload tx output
transaction_output1=`omnicore-cli $AUTH omni_createrawtx_reference $transaction_input $receiver_address $dust_value`

# add payload tx output
transaction_output2=`omnicore-cli $AUTH omni_createrawtx_opreturn $transaction_output1 $payload`

# add change tx output, this is omnicore_raw_transaction
transaction_output3=`omnicore-cli $AUTH omni_createrawtx_reference $transaction_output2 $sender_address $change_amount`

######################## Sign Transaction
signed_transaction=`omnicore-cli $AUTH signrawtransaction $transaction_output3 '[]' "[\"$sender_private_key\"]" | grep -e '"hex": "[^"]*"' | awk -F '"' '{print $4}'`

######################## Broadcast Transaction
transaction_hex=`omnicore-cli $AUTH sendrawtransaction $signed_transaction true`
echo "Transaction hex: "$transaction_hex

echo "All done."
