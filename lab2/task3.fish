#!/bin/env fish

set -l url "$issuerBaseUrl/authorize?response_type=code&client_id=$clientId&connection=$connectionDb&redirect_uri=$redirectUrl&state=$secret&scope=openid profile email"
echo "$url"
echo $url | xargs wl-copy


function get_token
  set -l code $argv[1]
  curl --request POST \
    --url "$issuerBaseUrl/oauth/token" \
    --header 'content-type: application/x-www-form-urlencoded' \
    --data-urlencode 'grant_type=authorization_code' \
    --data-urlencode "client_id=$clientId" \
    --data-urlencode "client_secret=$clientSecret" \
    --data-urlencode "code=$code" \
    --data-urlencode "redirect_uri=$redirectUrl"
end

set -l code "$argv[1]"
if test -z "$code"
  echo "Set code to continue"
  return
end

echo "Gettign token for code $code..."

set -l token_response (get_token $code)
echo $token_response
set -l token (echo $token_response | jq -r ".access_token" )

curl --request GET \
  --url "$issuerBaseUrl/userinfo" \
  --header "Authorization: Bearer $token"
