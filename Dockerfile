FROM node:8

RUN mkdir -p /data/bitcoin/regtest_btc
RUN mkdir -p /data/bitcoin/regtest_omni
RUN mkdir -p /data/bitcoin/regtest_btc_insight_api
RUN mkdir -p /opt/btc-usdt

RUN apt update
RUN apt-get install -y libzmq3-dev build-essential net-tools vim

RUN npm install -g node-gyp
RUN npm install -g --unsafe-perm=true bitcore@latest
RUN npm install -g pm2

RUN bitcore create /opt/btc-usdt/bitcore
ADD bitcore-node.json /opt/btc-usdt/bitcore

EXPOSE 3001
EXPOSE 8431
EXPOSE 8432

WORKDIR /opt/btc-usdt
RUN wget curl -L https://github.com/OmniLayer/omnicore/releases/download/v0.3.1/omnicore-0.3.1-x86_64-linux-gnu.tar.gz \
    && tar -xzvf omnicore-0.3.1-x86_64-linux-gnu.tar.gz \
    && cp ./omnicore-0.3.1/bin/omnicore-cli /usr/local/bin/ \
    && cp ./omnicore-0.3.1/bin/omnicored /usr/local/bin/ \
    && rm -rf omnicore*

RUN bitcore install insight-api insight-ui

RUN cp ./bitcore/node_modules/bitcore-node/bin/bitcoin-0.12.1/bin/bitcoin-cli /usr/local/bin/
RUN cp ./bitcore/node_modules/bitcore-node/bin/bitcoin-0.12.1/bin/bitcoind /usr/local/bin/

ADD . /opt/btc-usdt

ENTRYPOINT ./main.sh