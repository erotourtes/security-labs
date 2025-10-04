#!/bin/env fish

function get_token
  if test -f ./cache.txt.ignore
    cat ./cache.txt.ignore
    return
  end

  set -l data "audience=$audience&grant_type=client_credentials&client_id=$clientId&client_secret=$clientSecret"
  set -l url "https://$domain/oauth/token"

  # echo $url
  # echo $data

  set -l response (curl --request POST \
    --url "$url" \
    --header 'content-type: application/x-www-form-urlencoded' \
    --data "$data")

  echo $response > cache.txt.ignore
  echo $response
end

echo "Getting token..."

set -l token_reponse (get_token)

set access_token (echo $token_reponse | jq -r ".access_token")
echo "Got access_token" $access_token


function create_user
  set -l id $argv[1]

  curl -L -g "$audience"users \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    -H "Authorization: Bearer $access_token" \
    -H 'Accept: application/json' \
    --data-urlencode "email=student$id@securitylabstestkpi.ua" \
    --data-urlencode "name=Student $id" \
    --data-urlencode "password=!VeryStrongPassword12345!" \
    --data-urlencode "connection=$connectionDb"
end

echo "Creating user..."
create_user 1
