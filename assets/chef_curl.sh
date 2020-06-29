#!/usr/bin/env bash

_chomp () {
  # helper function to remove newlines
  awk '{printf "%s", $0}'
}

chef_api_request() {
  # This is the meat-and-potatoes, or rice-and-vegetables, your preference really.

  local method path body timestamp chef_server_url client_name hashed_body hashed_path
  local canonical_request headers auth_headers

  chef_server_url="https://ndnd/organizations/test1"
  if echo $chef_server_url | grep -q "/organizations/" ; then
    endpoint=/organizations/${chef_server_url#*/organizations/}${2%%\?*}
  else
    endpoint=${2%%\?*}
  fi
  path=${chef_server_url}$2
  client_name="dbm"
  method=$1
  body=$3

  hashed_path=$(echo -n "$endpoint" | openssl dgst -sha1 -binary | openssl enc -base64)
  hashed_body=$(echo -n "$body" | openssl dgst -sha1 -binary | openssl enc -base64)
  timestamp=$(date -u "+%Y-%m-%dT%H:%M:%SZ")

  canonical_request="Method:$method\nHashed Path:$hashed_path\nX-Ops-Content-Hash:$hashed_body\nX-Ops-Timestamp:$timestamp\nX-Ops-UserId:$client_name"
  headers="-H X-Ops-Timestamp:$timestamp \
    -H X-Ops-Userid:$client_name \
    -H X-Chef-Version:0.10.4 \
    -H Accept:application/json \
    -H X-Ops-Content-Hash:$hashed_body \
    -H X-Ops-Sign:version=1.0"

  auth_headers=$(printf "$canonical_request" | openssl rsautl -sign -inkey "dbm.pem" | openssl enc -base64 | _chomp |  awk '{ll=int(length/60);i=0; \
    while (i<=ll) {printf " -H X-Ops-Authorization-%s:%s", i+1, substr($0,i*60+1,60);i=i+1}}')

  case $method in
    GET)
      curl_command="curl -k $headers $auth_headers $path"
      echo $curl_command
      $curl_command
      ;;
    *)
      echo "Unknown Method. I only know: GET" >&2
      return 1
      ;;
    esac
  }

 chef_api_request "$@"
