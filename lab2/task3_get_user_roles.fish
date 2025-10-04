#!/bin/env fish


set -l userId $argv[1]
set -l token (cat ./cache.txt.ignore | jq -r ".access_token")

curl --request GET \
  --url "$issuerBaseUrl/api/v2/users/$userId/roles" \
  --header "Authorization: Bearer $token"
