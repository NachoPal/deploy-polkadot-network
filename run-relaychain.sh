#!/bin/bash

###############################################################################
### Run Relay Chain ###########################################################
###############################################################################

echo "Relaychain start up"

./bin/polkadot-v0.9.43/polkadot build-spec\
  --disable-default-bootnode\
  --chain=kusama-local > ./resources/kusama-relay-local.json

./bin/polkadot-v0.9.43/polkadot build-spec\
  --chain ./resources/kusama-relay-local.json\
  --raw\
  --disable-default-bootnode > ./resources/kusama-relay-local-raw.json

# RUST_LOG=
# export RUST_LOG

# start nodes
./bin/polkadot-v1.1.0/polkadot\
  --tmp\
	--chain=./resources/kusama-relay-local-raw.json\
  -ldebug\
	--alice\
	--port=30333\
	--rpc-port=9933\
	--execution=wasm\
	--rpc-cors=all\
	--unsafe-rpc-external &> ./logs/alice.log&

./bin/polkadot-v1.1.0/polkadot\
  --tmp\
	--chain=./resources/kusama-relay-local-raw.json\
	--bob\
	--port=30334\
	--rpc-port=9934\
	--execution=wasm\
	--rpc-cors=all\
	--unsafe-rpc-external &> ./logs/bob.log&

./bin/polkadot-v1.1.0/polkadot\
  --tmp\
	--chain=./resources/kusama-relay-local-raw.json\
	--charlie\
	--port=30335\
	--rpc-port=9935\
	--execution=wasm\
	--rpc-cors=all\
	--unsafe-rpc-external &> ./logs/charlie.log&

./bin/polkadot-v1.1.0/polkadot\
  --tmp\
	--chain=./resources/kusama-relay-local-raw.json\
	--dave\
	--port=30336\
	--rpc-port=9936\
	--execution=wasm\
	--rpc-cors=all\
	--unsafe-rpc-external &> ./logs/dace.log&
