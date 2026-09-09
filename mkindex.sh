#!/usr/bin/env bash
# Build OpenWrt Packages + Packages.gz index from *.ipk in DIR.
# No SDK needed — parses .ipk control.tar.gz directly.
# Usage: ./mkindex.sh [feed-dir]   (default: feed)
set -euo pipefail

DIR="${1:-feed}"
mkdir -p "$DIR"

OUT="$DIR/Packages"
: > "$OUT"

shopt -s nullglob
count=0
for ipk in "$DIR"/*.ipk; do
  name=$(basename "$ipk")
  tmp=$(mktemp -d)

  # .ipk outer tar.gz contains ./debian-binary + ./control.tar.gz + ./data.tar.gz
  tar xzf "$ipk" -C "$tmp" ./control.tar.gz
  tar xzf "$tmp/control.tar.gz" -C "$tmp" ./control

  # control (normalized trailing newline) + index fields
  sed -e '$a\' "$tmp/control" >> "$OUT"
  {
    printf 'Filename: %s\n' "$name"
    printf 'Size: %s\n' "$(stat -c %s "$ipk")"
    printf 'SHA256sum: %s\n' "$(sha256sum "$ipk" | awk '{print $1}')"
    printf 'MD5Sum: %s\n' "$(md5sum "$ipk" | awk '{print $1}')"
    printf '\n'
  } >> "$OUT"
  rm -rf "$tmp"
  count=$((count + 1))
done

gzip -9c "$OUT" > "$OUT.gz"
echo "feed index: $count package(s)"
ls -la "$DIR"