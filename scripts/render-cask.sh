#!/usr/bin/env bash
# Render Casks/peasant.rb from templates/peasant.rb.tmpl and the checksums of
# one final Peasant release.
#
# The render is fail-closed: every expected archive must appear exactly once in
# checksums.txt with a 64-hex digest, every template placeholder must appear
# exactly once, and no placeholder may survive the substitution. A release with
# a missing or unexpected asset never reaches the tap.
set -euo pipefail

usage() {
  echo "usage: $0 VERSION CHECKSUMS TEMPLATE OUTPUT" >&2
  exit 2
}

if [ "$#" -ne 4 ]; then
  usage
fi

version=$1
checksums=$2
template=$3
output=$4

if ! [[ $version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "error: version '$version' is not a final semantic version; release candidates never reach the tap" >&2
  exit 1
fi

for file in "$checksums" "$template"; do
  if [ ! -s "$file" ]; then
    echo "error: '$file' is missing or empty" >&2
    exit 1
  fi
done

# digest_for prints the one digest recorded for an asset name.
digest_for() {
  local asset=$1
  local -a hits
  mapfile -t hits < <(awk -v asset="$asset" '$2 == asset { print $1 }' "$checksums")
  if [ "${#hits[@]}" -ne 1 ]; then
    echo "error: checksums.txt records ${#hits[@]} digests for '$asset', want exactly 1" >&2
    exit 1
  fi
  if ! [[ ${hits[0]} =~ ^[0-9a-f]{64}$ ]]; then
    echo "error: digest for '$asset' is not 64 lowercase hex characters: '${hits[0]}'" >&2
    exit 1
  fi
  printf '%s' "${hits[0]}"
}

darwin_arm64=$(digest_for "peasant_${version}_darwin_arm64.tar.gz")
darwin_amd64=$(digest_for "peasant_${version}_darwin_amd64.tar.gz")
linux_arm64=$(digest_for "peasant_${version}_linux_arm64.tar.gz")
linux_amd64=$(digest_for "peasant_${version}_linux_amd64.tar.gz")

for placeholder in VERSION SHA256_DARWIN_ARM64 SHA256_DARWIN_AMD64 SHA256_LINUX_ARM64 SHA256_LINUX_AMD64; do
  count=$(grep -c "{{${placeholder}}}" "$template" || true)
  if [ "$count" -ne 1 ]; then
    echo "error: template placeholder {{${placeholder}}} appears ${count} times, want exactly 1" >&2
    exit 1
  fi
done

sed \
  -e "s|{{VERSION}}|${version}|g" \
  -e "s|{{SHA256_DARWIN_ARM64}}|${darwin_arm64}|g" \
  -e "s|{{SHA256_DARWIN_AMD64}}|${darwin_amd64}|g" \
  -e "s|{{SHA256_LINUX_ARM64}}|${linux_arm64}|g" \
  -e "s|{{SHA256_LINUX_AMD64}}|${linux_amd64}|g" \
  "$template" > "$output"

if grep -q '{{' "$output"; then
  echo "error: an unsubstituted placeholder remains in the rendered cask" >&2
  exit 1
fi
