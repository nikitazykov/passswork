#!/bin/bash
source .env

PASSWORK_TOKEN="${APIKEY}"

AUTH_login=$(curl -s -X POST "${HOST}/auth/login/${PASSWORK_TOKEN}" \
 -H "Accept: application/json")

echo -n "---Вход----- Status: "
echo "$AUTH_login" | jq -r '.status'
TOKEN=$(echo "$AUTH_login" | jq -r '.data.token')
echo "TOKEN10=\"$TOKEN\"" >> /server/passwork/.env