#!/bin/bash
source .env

PASSWORK_TOKEN="${TOKEN10}"
# QUERY="{\"query\":\"tb$1\",\"vaultId\":\"$SeifID\",\"colors\":[12]}"

# PASS_change=$(curl -s -X POST "${HOST}/passwords/search" \
#  -H "Accept: application/json" \
#  -H "Passwork-Auth: ${PASSWORK_TOKEN}" \
#  -H "Content-Type: application/json" \
#  -d "${QUERY}")

echo -n "----Изменение- Status: "
echo "$PASS_change" | jq -r '.status'
echo "$PASS_change" | jq -r 
# PASS_ID=$(echo "$PASS_change" | jq -r '.data[].id')
# sed -i "/^PASS_ID_tb$1/d" /server/passwork/.env
# echo "PASS_ID_tb$1=\"$PASS_ID\"" >> /server/passwork/.env
# echo "-------------"