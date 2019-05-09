#!/usr/bin/env bash
cd /opt/btc-usdt
cp btc.conf /data/bitcoin/regtest_btc_insight_api/bitcoin.conf

pm2 start ./start-btc.sh --name=btc-rpc
pm2 start ./start-usdt.sh --name=usdt-rpc
pm2 start ./start-insight-api.sh --name=btc-insight-api

# wallet import and send btc
sleep 10
./recharge-btc.sh

# generate block every 5 seconds
sleep 5
pm2 start ./generate-block.sh --name=generate-block

# create usdt token
sleep 5
./create-usdt.sh

# send usdt demo
sleep 5
./create-usdt-tx.sh

tail -f /dev/null