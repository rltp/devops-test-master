#!/bin/sh
while sleep 2; 
do 
  u=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13; echo '')
  curl -X POST \
  --header "Content-Type:application/json" \
  -d '{"name":"'"$u"'", "username": "'"$u"'", "email": "'"$u"'@gmail.com"}' \
  http://api-service-cluster/users/
  echo "> User $u created"
done