# BITS-WRT-Packages — custom opkg feed

Self-hosted opkg feed for BITS OpenWrt packages, published via GitHub Pages.

**Feed URL:** `https://banten-it-solutions.github.io/BITS-WRT-Packages`

## Packages (always latest release)

| Package | Source repo |
|---|---|
| `bitsnetworksbot` | BITS-Networks-Bot (daemon) |
| `luci-app-bitsnetworksbot` | BITS-Networks-Bot (LuCI UI) |
| `luci-app-tailscale` | BITS-Tailscale (LuCI UI) |

## Use on router

### 1. Add signing key (required — feed is signed)

Key fingerprint: `6d859947af7c14f1`. File name **must** match the fingerprint.

```sh
cat > /etc/opkg/keys/6d859947af7c14f1 <<'EOF'
untrusted comment: BITS-WRT-Packages opkg feed
RWRthZlHr3wU8aiswz3YKdkmk5h3ySyBdxjXjsm/m2ZmUf8ir37yXasf
EOF
chmod 644 /etc/opkg/keys/6d859947af7c14f1
```

### 2. Add feed + install

```sh
echo "src/gz bits https://banten-it-solutions.github.io/BITS-WRT-Packages" > /etc/opkg/customfeeds.conf
opkg update
opkg install bitsnetworksbot luci-app-bitsnetworksbot luci-app-tailscale
```

`opkg update` must print `Signature check passed` for the `bits` feed.

## How it updates

`.github/workflows/publish.yml` runs daily (03:23 UTC) + on manual trigger:
downloads latest `.ipk` from both repos' GitHub Releases, builds
`Packages`/`Packages.gz` via `mkindex.sh`, signs `Packages` (usign/signify),
deploys `feed/` to the `gh-pages` branch.

Signing key stored as GitHub secret `FEED_SIGN_BLOB` (seed only, no comment header).
Public key committed here: `key/6d859947af7c14f1.pub`.