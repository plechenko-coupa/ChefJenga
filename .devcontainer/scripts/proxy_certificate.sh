#!/usr/bin/env bash
# Feature: proxy-certificate
# Installs the corporate proxy root CA certificate if an intercepting proxy is detected.
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

TEST_URL="${TEST_URL:-example.com}"
CERT_PATH='/usr/local/share/ca-certificates/proxy_root.crt'

if [[ "$(id -u)" -ne 0 ]]; then
  echo 'This script must be run as root.'
  exit 1
fi

if [[ -f "$CERT_PATH" ]]; then
  echo "Proxy root certificate already exists at '$CERT_PATH'. Skipping."
  exit 0
fi

curl_exit=0
curl -sS "https://$TEST_URL/" >/dev/null 2>&1 || curl_exit=$?

if [[ $curl_exit -eq 0 ]]; then
  echo "Connected to $TEST_URL without certificate errors. No proxy cert needed."
  exit 0
elif [[ $curl_exit -ne 60 ]]; then
  echo "Could not connect to $TEST_URL (curl exit $curl_exit). Check network and retry."
  exit 1
fi

echo "SSL error detected — fetching proxy root certificate from $TEST_URL:443 ..."
certs="$(echo | openssl s_client -showcerts -connect "${TEST_URL}:443" 2>/dev/null \
  | awk '/-----BEGIN CERTIFICATE-----/,/-----END CERTIFICATE-----/')"

TMP_PREFIX='/tmp/proxy_cert_'
echo "$certs" | csplit -z -s -f "$TMP_PREFIX" -b '%02d.crt' - '/-----BEGIN CERTIFICATE-----/' '{*}'

for cert in "${TMP_PREFIX}"*.crt; do
  issuer="$(openssl x509 -in "$cert" -noout -issuer 2>/dev/null | sed 's/^issuer=//')"
  subject="$(openssl x509 -in "$cert" -noout -subject 2>/dev/null | sed 's/^subject=//')"
  if [[ "$issuer" == "$subject" ]]; then
    echo "Found root CA: $subject — installing to $CERT_PATH"
    mv "$cert" "$CERT_PATH"
    update-ca-certificates
    break
  fi
done

rm -f "${TMP_PREFIX}"*.crt

if curl -sS "https://$TEST_URL/" >/dev/null 2>&1; then
  echo "Certificate installed successfully."
else
  echo "Still failing after cert install — check proxy configuration."
  exit 1
fi
