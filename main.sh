#!/usr/bin/env bash
bitcoin-cli -conf=/opt/btc-usdt/btc.conf stop
omnicore-cli -conf=/opt/btc-usdt/usdt.conf stop
pm2 delete btc-rpc usdt-rpc btc-insight-api generate-block

rm -rf /root/.bitcoin/bitcoin.conf
rm -rf /data/bitcoin/regtest_btc/*
rm -rf /data/bitcoin/regtest_omni/*
rm -rf /data/bitcoin/regtest_btc_insight_api/*

cd /opt/btc-usdt
cp bitcoin.conf /data/bitcoin/regtest_btc_insight_api/bitcoin.conf

pm2 start ./start-btc.sh --name=btc-rpc
pm2 start ./start-usdt.sh --name=usdt-rpc
pm2 start ./start-insight-api.sh --name=btc-insight-api

sleep 10
./recharge-btc.sh

sleep 5
pm2 start ./start-generate-block.sh --name=generate-block

sleep 5
./recharge-usdt.sh

sleep 5
./create-usdt-tx.sh
