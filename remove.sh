#!/usr/bin/env bash
bitcoin-cli -conf=/opt/btc-usdt/btc.conf stop
omnicore-cli -conf=/opt/btc-usdt/usdt.conf stop
pm2 delete btc-rpc usdt-rpc btc-insight-api generate-block

rm -rf /data/bitcoin/regtest_btc/*
rm -rf /data/bitcoin/regtest_omni/*
rm -rf /data/bitcoin/regtest_btc_insight_api/*
