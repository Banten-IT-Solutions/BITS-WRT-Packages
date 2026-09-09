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

```sh
echo "src/gz bits https://banten-it-solutions.github.io/BITS-WRT-Packages" > /etc/opkg/customfeeds.conf
opkg update
opkg install bitsnetworksbot luci-app-bitsnetworksbot luci-app-tailscale
```

## How it updates

`.github/workflows/publish.yml` runs daily (03:23 UTC) + on manual trigger:
downloads latest `.ipk` from both repos' GitHub Releases, builds
`Packages`/`Packages.gz` via `mkindex.sh`, deploys `feed/` to the `gh-pages` branch.
