#!/bin/bash

source ./.env
. ./src/handler.sh

OFFSET=0

while true; do
  URL="https://api.telegram.org/bot${BOT_TOKEN}/getUpdates?offset=${OFFSET}"
  RESPONSE=$(curl -s ${URL}) > /dev/null

  UPDATES=$(echo "${RESPONSE}" | jq -r '.result')

  if [[ -n "${UPDATES}" ]]; then
	while read MESSAGE
	do
		echo_handler "$MESSAGE"
	done < <(echo "$UPDATES" | jq -c '.[]')
	LAST_UPDATE_ID=$(echo "${UPDATES}" | jq -r '.[].update_id' | tail -n 1)
    OFFSET=$((LAST_UPDATE_ID + 1))
  fi

  sleep 1
done

