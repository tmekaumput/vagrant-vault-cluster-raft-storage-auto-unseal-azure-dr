#!/bin/bash

SHARED_DIR=${1}

export VAULT_TOKEN=$(sudo cat ${SHARED_DIR}/root_token-vault)

# Enable primary cluster
vault write -f sys/replication/dr/primary/enable

# Setup activation token
vault write sys/replication/dr/primary/secondary-token id=$(uuidgen) -format=json | jq -r '.wrap_info.token' | sudo tee ${SHARED_DIR}/../activation-token.txt >/dev/null


