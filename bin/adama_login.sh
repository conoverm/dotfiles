#!/usr/bin/env bash


# Adama login. Paste return session into session_id query param

function adama_login() {
# adama_login SERVER_NAME (t1qa1, t1qa2, t1qa3)
# ?api_base=https%3A%2F%2Ft1qa2.mediamath.com%2Fapi%2Fv2.0%2F&session_id=[copy and paste to here]
# $1 = server you want to log in to

if [  -z "$1" ]
then
	SERVER="t1qa2"
else
	SERVER=$1
fi

echo "username: " >&2
read USER
echo "password: " >&2
read -s PASSW

echo "logging in via $SERVER"
/usr/bin/curl "https://${SERVER}.mediamath.com/api/v2.0/login" -d "user=${USER}&password=${PASSW}&api_key=[api key]"

}

adama_login
