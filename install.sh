#!/usr/bin/env bash
set -euo pipefail

REPO="xiaofujie369/-REALITY-"
BIN="/usr/local/bin/realitlscanner"

arch="$(uname -m)"
case "$arch" in
  x86_64|amd64) asset="realitlscanner-linux-amd64" ;;
  aarch64|arm64) asset="realitlscanner-linux-arm64" ;;
  *) echo "Unsupported architecture: $arch" >&2; exit 1 ;;
esac

url="https://github.com/${REPO}/releases/download/latest/${asset}"
tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

echo "[1/3] Downloading prebuilt RealiTLScanner for $arch..."
if command -v curl >/dev/null 2>&1; then
  curl -fL --retry 3 --connect-timeout 10 "$url" -o "$tmp"
elif command -v wget >/dev/null 2>&1; then
  wget -O "$tmp" "$url"
else
  if command -v apt-get >/dev/null 2>&1; then
    apt-get update -y && apt-get install -y curl
    curl -fL --retry 3 --connect-timeout 10 "$url" -o "$tmp"
  else
    echo "curl/wget not found." >&2
    exit 1
  fi
fi

echo "[2/3] Installing to $BIN..."
install -m 0755 "$tmp" "$BIN"

echo "[3/3] Verifying..."
"$BIN" --help >/dev/null

echo
echo "Installed successfully:"
"$BIN" --version 2>/dev/null || true
echo
echo "Run:"
echo "  realitlscanner --help"
