#!/bin/env fish

set -l domain "kpi.eu.auth0.com"
set -l clientId "JIvCO5c2IBHlAe2patn6l6q5H35qxti0"
set -l clientSecret "ZRF8Op0tWM36p1_hxXTU-B0K_Gq_-eAVtlrQpY24CasYiDmcXBhNS6IJMNcz1EgB"
set -l audience "https://kpi.eu.auth0.com/api/v2/"

set -l url "https://$domain/oauth/token"
set -l data "audience=$audience&grant_type=client_credentials&client_id=$clientId&client_secret=$clientSecret"

echo $url
echo $data

curl --request POST \
  --url "$url" \
  --header 'content-type: application/x-www-form-urlencoded' \
  --data "$data"



