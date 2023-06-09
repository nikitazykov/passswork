#!/bin/bash
source .env

PASSWORK_TOKEN="${TOKEN10}"
if (( 0 < $1 && $1 < 10 )); then # 0 < X < 10
    QUERY="{\"query\":\"!$login\",\"vaultId\":\"$SeifID_back\",\"colors\":[12]}"
elif (( 9 < $1 && $1 < 100 )); then  # 9 < X < 100
    QUERY="{\"query\":\"$login\",\"vaultId\":\"$SeifID_back\"}"
fi
PASS_search=$(curl -s -X POST "${HOST}/passwords/search" \
 -H "Accept: application/json" \
 -H "Passwork-Auth: ${PASSWORK_TOKEN}" \
 -H "Content-Type: application/json" \
 -d "${QUERY}")

echo -n "---Поиск---- Status: "
echo "$PASS_search" | jq -r '.status'
PASS_ID=$(echo "$PASS_search" | jq -r '.data[].id')
sed -i "/^PASS_ID_$login/d" /server/passwork/.env
if (( ${#PASS_ID} > 24 )); then
    PASS_ID="${PASS_ID:0:24}"
    echo "Найдено несколко ключей с таким именем, выбран первый"
fi
echo "PASS_ID_$login=\"$PASS_ID\"" >> /server/passwork/.env