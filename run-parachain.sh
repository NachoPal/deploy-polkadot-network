#!/bin/bash

###############################################################################
### Run Parachain #############################################################
###############################################################################

echo "Parachain start up"

./bin/polkadot-v0.9.43/polkadot-parachain build-spec\
  --disable-default-bootnode\
  --chain=statemine-local > ./resources/asset-hub-kusama-spec.json

./bin/polkadot-v0.9.43/polkadot-parachain build-spec\
  --chain ./resources/asset-hub-kusama-spec.json\
  --raw\
  --disable-default-bootnode > ./resources/asset-hub-kusama-spec-raw.json

./bin/polkadot-v0.9.43/polkadot-parachain export-genesis-state --chain ./resources/asset-hub-kusama-spec-raw.json > ./resources/asset-hub-kusama-head-data
./bin/polkadot-v0.9.43/polkadot-parachain export-genesis-wasm --chain ./resources/asset-hub-kusama-spec-raw.json > ./resources/asset-hub-kusama-wasm

# RUST_LOG=
# export RUST_LOG

# Collator 1
./bin/polkadot-v1.1.0/polkadot-parachain\
  --alice\
  --collator\
  --force-authoring\
  -ltrace\
  --tmp\
  --port 40335\
  --rpc-port 9988\
  --execution=wasm\
  --chain=resources/asset-hub-kusama-spec-raw.json\
  --\
  --execution=wasm\
  --chain=resources/kusama-relay-local-raw.json\
  --rpc-port 9946\
  --port 30337 &> ./logs/parachain-collator-alice.log&

# Collator 2
./bin/polkadot-v1.1.0/polkadot-parachain\
  --bob\
  --collator\
  --force-authoring\
  -ltrace\
  --tmp\
  --port 40336\
  --rpc-port 9999\
  --execution=wasm\
  --chain=resources/asset-hub-kusama-spec-raw.json\
  --\
  --execution=wasm\
  --chain=resources/kusama-relay-local-raw.json\
  --rpc-port 9947\
  --port 30338 &> ./logs/parachain-collator-bob.log&
