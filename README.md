# REALITY SNI Scanner - Prebuilt Installer

This repository provides prebuilt Linux binaries of [spgsroot/RealiTLScanner-rs](https://github.com/spgsroot/RealiTLScanner-rs), built by GitHub Actions so VPS machines do not need to compile Rust locally.

## One-line install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/xiaofujie369/-REALITY-/main/install.sh)
```

Supported architectures:

- Linux amd64 / x86_64
- Linux arm64 / aarch64

After installation:

```bash
realitlscanner --help
```

## Example

Scan a small, explicitly selected target range:

```bash
realitlscanner --addr 1.2.3.0/24 --thread 20 --timeout 5 --reality-sni --domains-only --out sni.csv
```

Upstream warns that large scans from a VPS can trigger provider abuse/risk controls. Prefer small target sets or known domain lists.

## Updating binaries

The workflow builds from the current upstream source and publishes a rolling `latest` release. It can also be started manually from GitHub Actions.
