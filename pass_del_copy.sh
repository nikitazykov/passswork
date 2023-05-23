#!/bin/bash
source .env

PASS_ID=""
PASS_ID_env=""

bash ./pass_search.sh $1
source .env
eval "PASS_ID=\$PASS_ID_${login}" 
PASS_ID_env="PASS_ID_${login}"
while [[ ! $PASS_ID == "" ]]; do
    bash ./pass_search.sh $1   > /dev/null
    source .env
    PASS_ID_env="PASS_ID_${login}"
    eval "PASS_ID=\$PASS_ID_${login}"
    if [[ ! $PASS_ID == "" ]]; then
        bash ./pass_del.sh $1   > /dev/null
    fi
    PASS_ID_env=""
done