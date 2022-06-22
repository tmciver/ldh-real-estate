#!/usr/bin/env bash
[ -z "$SCRIPT_ROOT" ] && echo "Need to set SCRIPT_ROOT" && exit 1;

if [ "$#" -ne 3 ]; then
  echo "Usage:   $0" '$base $cert_pem_file $cert_password' >&2
  echo "Example: $0" 'https://linkeddatahub.com/atomgraph/app/ ../../../certs/martynas.localhost.pem Password' >&2
  echo "Note: special characters such as $ need to be escaped in passwords!" >&2
  exit 1
fi

base="$1"
cert_pem_file=$(realpath -s "$2")
cert_password="$3"

pwd=$(realpath -s $PWD)

pushd . && cd "$SCRIPT_ROOT"

./create-container.sh \
-b "$base" \
-f "$cert_pem_file" \
-p "$cert_password" \
--title "Houses" \
--slug "houses" \
--parent "$base" \
--proxy "$base"



select_addresses_doc=$(./create-select.sh \
  -b "$base" \
  -f "$cert_pem_file" \
  -p "$cert_password" \
  --proxy "$proxy" \
  --title "Select addresses" \
  --slug select-addresses \
  --query-file "$pwd/queries/select-addresses.rq"
)

select_addresses_ntriples=$(./get-document.sh \
  -f "$cert_pem_file" \
  -p "$cert_password" \
  --proxy "$proxy" \
  --accept 'application/n-triples' \
  "$select_addresses_doc"
)

select_addresses=$(echo "$select_addresses_ntriples" | sed -rn "s/<${select_addresses_doc//\//\\/}> <http:\/\/xmlns.com\/foaf\/0.1\/primaryTopic> <(.*)> \./\1/p" | head -1)

address_container=$(./create-container.sh \
  -b "$base" \
  -f "$cert_pem_file" \
  -p "$cert_password" \
  --proxy "$proxy" \
  --title "Addresses" \
  --slug "addresses" \
  --parent "$base"
)

./remove-content.sh \
  -f "$cert_pem_file" \
  -p "$cert_password" \
  --proxy "$proxy" \
  "$address_container"

./append-content.sh \
  -f "$cert_pem_file" \
  -p "$cert_password" \
  --proxy "$proxy" \
  --value "$select_addresses" \
  --mode "https://w3id.org/atomgraph/client#GridMode" \
  "$address_container"

popd
