#!/usr/bin/env bash

[ -z "$SCRIPT_ROOT" ] && echo "Need to set SCRIPT_ROOT" && exit 1;

if [ "$#" -ne 3 ]; then
  echo "Usage:   $0" '$base $cert_pem_file $cert_password' >&2
  echo "Example: $0" 'https://linkeddatahub.com/atomgraph/app/admin/ ../../../../certs/martynas.localhost.pem Password' >&2
  echo "Note: special characters such as $ need to be escaped in passwords!" >&2
  exit 1
fi

base="$1"
cert_pem_file="$(realpath -s $2)"
cert_password="$3"

pushd . && cd "$SCRIPT_ROOT"/admin 

./clear-ontology.sh \
-f "$cert_pem_file" \
-p "$cert_password" \
-b "$base" \
--ontology "${base}ns#"

popd
