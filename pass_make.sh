#!/bin/bash
source .env

PASSWORK_TOKEN="${TOKEN10}"
masterHash=$PASSWORK_TOKEN
sftp_pass=$(echo -n "$2" | base64)   > /dev/null
db_pass=$(echo -n "$3" | base64)   > /dev/null
value=$(echo -n "tb$1" | base64)   > /dev/null
if [[ $1 -lt 10 ]]; then # Меньше 10
    QUERY="{\"name\":\"!$name\",\"login\":\"$login\",\"cryptedPassword\":\"$sftp_pass\",\"vaultId\":\"$SeifID_back\",
    \"folderId\":\"$FolderID_back\",\"url\":\"$url\",\"custom\":[{\"name\":\"0JTQvtC/0L7Qu9C90LjRgtC10LvRjNC90YvQuSDQu9C+0LPQuNC9IDE=\",
    \"value\":\"$value\",\"type\":\"dGV4dA==\"},{\"name\":\"0JTQvtC/0L7Qu9C90LjRgtC10LvRjNC90YvQuSDQv9Cw0YDQvtC70YwgMQ==\",\"value\":\"$db_pass\",
    \"type\":\"cGFzc3dvcmQ=\"}],\"description\":\"$descrt\",\"masterHash\":\"$masterHash\",\"colors\":[12]}"
else
    QUERY="{\"name\":\"$name\",\"login\":\"$login\",\"cryptedPassword\":\"$sftp_pass\",\"vaultId\":\"$SeifID_back\",
    \"folderId\":\"$FolderID_back\",\"url\":\"$url\",\"custom\":[{\"name\":\"0JTQvtC/0L7Qu9C90LjRgtC10LvRjNC90YvQuSDQu9C+0LPQuNC9IDE=\",
    \"value\":\"$value\",\"type\":\"dGV4dA==\"},{\"name\":\"0JTQvtC/0L7Qu9C90LjRgtC10LvRjNC90YvQuSDQv9Cw0YDQvtC70YwgMQ==\",\"value\":\"$db_pass\",
    \"type\":\"cGFzc3dvcmQ=\"}],\"description\":\"$descr\",\"masterHash\":\"$masterHash\"}"
fi

PASS_make=$(curl -s -X POST "${HOST}/passwords" \
 -H "Accept: application/json" \
 -H "Passwork-Auth: ${PASSWORK_TOKEN}" \
 -H "Content-Type: application/json" \
 -d "${QUERY}")

echo -n "---Создание- Status: "
PASS_stat=$(echo "$PASS_make" | jq -r '.status')
echo "$PASS_stat"
PASS_ID=$(echo "$PASS_make" | jq -r '.data.id')
if [[ $PASS_stat == "success" ]]; then
    echo "---Ссылка в Passwork:" | tee -a /server/$DOMAIN.ru/tb$1.txt
    echo "https://passwork.$DOMAIN.ru/#!/p/$PASS_ID" | tee -a /server/$DOMAIN.ru/tb$1.txt
fi

