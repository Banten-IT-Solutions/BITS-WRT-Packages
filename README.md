<div align="center">
  <h1>BITS WRT Packages</h1>
  <p>
    <a href="https://bits.co.id">
      <img src="https://img.shields.io/badge/Banten%20IT%20Solutions-BITS%20WRT%20Packages-00C853?style=for-the-badge&logo=openwrt&logoColor=white" alt="BITS WRT Packages" />
    </a>
  </p>
  <p>
    Self-hosted <code>opkg</code> feed for BITS OpenWrt packages &mdash; signed (usign), always-latest, served via GitHub Pages.
  </p>
  <br>
  <p>
    <img src="https://img.shields.io/badge/OpenWrt-00A1E9?style=flat&logo=openwrt&logoColor=white" alt="OpenWrt" />
    <img src="https://img.shields.io/badge/opkg-feed-3D5780?style=flat" alt="opkg feed" />
    <img src="https://img.shields.io/badge/GitHub%20Pages-222222?style=flat&logo=github&logoColor=white" alt="GitHub Pages" />
    <img src="https://img.shields.io/badge/Shell-4EAA25?style=flat&logo=gnu-bash&logoColor=white" alt="Shell" />
    <img src="https://img.shields.io/badge/license-MIT-green?style=flat" alt="MIT License" />
  </p>
</div>

---

## ✨ Features

| Feature              | Description                                                                                      |
| -------------------- | ------------------------------------------------------------------------------------------------ |
| **Always latest**    | Workflow harian + manual mengunduh `.ipk` terbaru dari tiap repo source.                       |
| **Signed (usign)**   | `Packages` ditandatangani; opkg verifikasi via `option check_signature`.                         |
| **SDK-less index**   | `mkindex.sh` baca `control.tar.gz` langsung — tak butuh OpenWrt SDK.                             |
| **Landing page**     | Halaman web statis di GitHub Pages + file feed (.ipk, `Packages`).                              |

## 📦 Packages

| Package                   | Source repo                                                     | Fungsi                       |
| ------------------------- | --------------------------------------------------------------- | ---------------------------- |
| `bitsnetworksbot`         | [BITS-Networks-Bot](https://github.com/Banten-IT-Solutions/BITS-Networks-Bot) | Telegram bot (daemon)        |
| `luci-app-bitsnetworksbot`| [BITS-Networks-Bot](https://github.com/Banten-IT-Solutions/BITS-Networks-Bot) | LuCI config page             |
| `luci-app-bitstailscale`  | [BITS-Tailscale](https://github.com/Banten-IT-Solutions/BITS-Tailscale) | LuCI app for Tailscale       |
| `luci-app-bitsfilemanager`| [BITS-FileManager](https://github.com/Banten-IT-Solutions/BITS-FileManager) | Native file manager for LuCI (no PHP, no Go) |
| `luci-theme-bits`         | [BITS-Theme](https://github.com/Banten-IT-Solutions/BITS-Theme) | BITS theme for LuCI (OpenWrt) |
| `luci-app-bitshilink`     | [BITS-HiLink](https://github.com/Banten-IT-Solutions/BITS-HiLink) | LuCI app for Huawei HiLink modem |
| `luci-app-bitsxl`         | [BITS-XL](https://github.com/Banten-IT-Solutions/BITS-XL)       | LuCI app for XL (myXL)       |

## 🛠️ Tech Stack

| Layer      | Technology                                |
| ---------- | ----------------------------------------- |
| **Hosting**| GitHub Pages (`gh-pages` branch)          |
| **Index**  | `bash` + `tar` + `sha256sum`/`md5sum`     |
| **Signing**| `usign` (signify-compatible)              |
| **CI/CD**  | GitHub Actions                            |

---

## 🚀 Use

### 1. Tambah signing key (fingerprint `6d859947af7c14f1`)

```sh
cat > /etc/opkg/keys/6d859947af7c14f1 <<'EOF'
untrusted comment: BITS-WRT-Packages opkg feed
RWRthZlHr3wU8aiswz3YKdkmk5h3ySyBdxjXjsm/m2ZmUf8ir37yXasf
EOF
chmod 644 /etc/opkg/keys/6d859947af7c14f1
```

> Nama file key **wajib** sama dengan fingerprint (opkg cari berdasarkannya).

### 2. Tambah feed + install

```sh
echo "src/gz bits https://banten-it-solutions.github.io/BITS-WRT-Packages" > /etc/opkg/customfeeds.conf
opkg update
opkg install bitsnetworksbot luci-app-bitsnetworksbot luci-app-bitstailscale luci-app-bitsfilemanager luci-theme-bits luci-app-bitshilink luci-app-bitsxl
```

`opkg update` wajib cetak `Signature check passed` untuk feed `bits`.

---

## 📁 Project Structure

```text
BITS-WRT-Packages/
├── .github/
│   └── workflows/
│       └── publish.yml       # fetch ipks + build index + sign + deploy Pages
├── landing/
│   └── index.html            # landing page (disalin ke feed saat deploy)
├── key/
│   └── 6d859947af7c14f1.pub  # public key (salin ke /etc/opkg/keys/)
├── mkindex.sh                # build Packages + Packages.gz (SDK-less)
├── README.md
└── LICENSE
```

## 🔄 Update

- `publish.yml` jalan otomatis tiap hari (03:23 UTC) + `workflow_dispatch` manual.
- Tiap release baru di source repo → trigger manual feed, index + sig di-refresh.
- Signing key tersimpan di GitHub secret `FEED_SIGN_BLOB` (seed saja, tanpa header komentar).

---

## 📄 License

Distributed under the MIT License. See `LICENSE`.

---

<div align="center">
  <strong>BITS WRT Packages</strong> Developed with ❤️ by <a href="https://bits.co.id"><strong>Banten IT Solutions</strong></a>
</div>