#!/bin/bash
source .env

PASSWORK_TOKEN="${TOKEN10}"
eval "PASS_ID=\$PASS_ID_${login}"

PASS_del=$(curl -s -X DELETE "${HOST}/passwords/${PASS_ID}" \
 -H "Accept: application/json" \
 -H "Passwork-Auth: ${PASSWORK_TOKEN}")
DEL_PASS_ID="/^PASS_ID_${login}/d"

echo -n "---Удаление- Status: "
echo "$PASS_del" | jq -r '.status'
sed -i "$DEL_PASS_ID" /server/passwork/.env
