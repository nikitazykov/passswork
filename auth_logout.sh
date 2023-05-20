#!/bin/bash
source .env

PASSWORK_TOKEN="${TOKEN10}"

AUTH_logout=$(curl -s -X POST "${HOST}/auth/logout" \
 -H "Accept: application/json" \
 -H "Passwork-Auth: ${PASSWORK_TOKEN}")

echo -n "---Выход---- Status: "
echo "$AUTH_logout" | jq -r '.status'
sed -i '/^TOKEN/d' /server/passwork/.env
