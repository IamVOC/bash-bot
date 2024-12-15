#!/bin/bash

function echo_handler {
	MESSAGE=$1
	CHAT_ID=$(echo "${MESSAGE}" | jq -r '.message.chat.id')
	TEXT=$(echo "${MESSAGE}" | jq -r '.message.text')
	DATA="{\"chat_id\": \"${CHAT_ID}\", \"text\": \"${TEXT}\"}"
	curl --header "Content-Type: application/json" \
		 --request POST \
		 --data "${DATA}" \
				"https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" &> /dev/null
}
