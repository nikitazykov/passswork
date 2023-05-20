#!/bin/bash
source .env

PASSWORK_TOKEN="${TOKEN10}"
eval "PASS_ID=\$PASS_ID_${login}"

PASS_info=$(curl -s -X GET "${HOST}/passwords/${PASS_ID}" \
 -H "Accept: application/json" \
 -H "Passwork-Auth: ${PASSWORK_TOKEN}")

echo -n "---Инфо----- Status: "
echo "$PASS_info" | jq -r '.status'
echo "------------------"
URL=$(echo "$PASS_info" | jq -r '.data.url')
echo "Площадка #$1 готова - $URL"
DESCR=$(echo "$PASS_info" | jq -r '.data.description')
echo "${DESCR%%\\n*}"
SFTP_login=$(echo "$PASS_info" | jq -r '.data.login')
echo "Логин для sftp: $SFTP_login"
SFTP_pass=$(echo "$PASS_info" | jq -r '.data.cryptedPassword')
echo "Пароль для sftp: $(echo ${SFTP_pass} | base64 --decode)"
DB_login=$(echo "$PASS_info" | jq -r '.data.custom[] | select(.type == "dGV4dA==").value')
echo "${DESCR#*\\n} DB: $(echo ${DB_login} | base64 --decode)"
echo "Логин для DB: $(echo ${DB_login} | base64 --decode)"
DB_pass=$(echo "$PASS_info" | jq -r '.data.custom[] | select(.type == "cGFzc3dvcmQ=").value')
echo "Пароль для DB: $(echo ${DB_pass} | base64 --decode)"