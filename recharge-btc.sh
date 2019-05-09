#!/usr/bin/env bash
AUTH="-rpcuser=btcrpc -rpcpassword=123456 -rpcport=8431 -regtest"
bitcoin-cli $AUTH listaccounts
bitcoin-cli $AUTH generate 110

bitcoin-cli $AUTH importprivkey "cVVGgzVgcc5S3owCskoneK8R1BNGkBveiEcGDaxu8RRDvFcaQaSG" "Account1" false
bitcoin-cli $AUTH importprivkey "cRGkipHiYFRSAgdY9NjUT7egHTuNXoKYWQea3kWVbkSJAs4VDi8r" "Account2" false
bitcoin-cli $AUTH importprivkey "cTc8XCQZuSt5E1LArqCxyaXhn1cQkvcBMAGQ159raPSQTuBpHWdi" "Account3" false
bitcoin-cli $AUTH importprivkey "cQ9JwsoYHC2Md41uDbczDVpsuWAeYjDDrDiGbCBZ4stZhZvLZWj8" "Account4" false
bitcoin-cli $AUTH importprivkey "cQrY4VypAuemJtHmNNJLyx1SNjY7mpfkdQEJpccpLSvan5YoMAkM" "Account5" true

bitcoin-cli $AUTH generate 1

bitcoin-cli $AUTH setaccount "mnJQyeDFmGjNoxyxKQC6MMFdpx77rYV3Bo" "Account1"
bitcoin-cli $AUTH setaccount "mzdF3oEx8mKrpGb5rVnTE7MhQfL8N8oSnW" "Account2"
bitcoin-cli $AUTH setaccount "mtdVMhiWWmegkkBhzYDrz84yfgofPNLNmb" "Account3"
bitcoin-cli $AUTH setaccount "mqNnZTyFxhB6EzF1iDEAp9enrT84fwd1X5" "Account4"
bitcoin-cli $AUTH setaccount "mnk2URqujBqMEfhALMby1WZHoBRauW37Kg" "Account5"

bitcoin-cli $AUTH sendmany "" '{"mnJQyeDFmGjNoxyxKQC6MMFdpx77rYV3Bo":123.12345,"mzdF3oEx8mKrpGb5rVnTE7MhQfL8N8oSnW":25.4112}'
bitcoin-cli $AUTH sendmany "" '{"mtdVMhiWWmegkkBhzYDrz84yfgofPNLNmb":62.4322,"mqNnZTyFxhB6EzF1iDEAp9enrT84fwd1X5":31.2345}'
bitcoin-cli $AUTH sendmany "" '{"mnk2URqujBqMEfhALMby1WZHoBRauW37Kg":1}'

bitcoin-cli $AUTH $AUTH generate 3

bitcoin-cli $AUTH sendmany "Account2" '{"mnJQyeDFmGjNoxyxKQC6MMFdpx77rYV3Bo":1.1337,"mqNnZTyFxhB6EzF1iDEAp9enrT84fwd1X5":4.123, "mzdF3oEx8mKrpGb5rVnTE7MhQfL8N8oSnW":6.324}'
bitcoin-cli $AUTH sendmany "Account3" '{"mqNnZTyFxhB6EzF1iDEAp9enrT84fwd1X5":2.1337,"mzdF3oEx8mKrpGb5rVnTE7MhQfL8N8oSnW":6.123, "mtdVMhiWWmegkkBhzYDrz84yfgofPNLNmb": 7.34}'
bitcoin-cli $AUTH sendmany "Account4" '{"mnJQyeDFmGjNoxyxKQC6MMFdpx77rYV3Bo":7.1337}'

bitcoin-cli $AUTH $AUTH generate 1

bitcoin-cli $AUTH listaccounts
