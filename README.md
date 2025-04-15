
# `belfi`

**`belfi`** is a lightweight tool for deploying and managing multiple proxy servers using Docker. It currently supports spinning up isolated containers for various modern proxy protocols, each running on a separate port.

## 🌐 Supported Protocols

- **Hysteria2**
- **TUIC**
- **Shadowsocks**
- **Trojan**
- **Juicity**

## 🎯 Purpose

`belfi` is built for self-hosters and sysadmins who want to deploy multiple secure proxy protocols in parallel. Each server runs in its own container and is exposed on a unique port for client access.

## ⚙️ How It Works

`belfi`:

1. Takes in your domain and email.
2. Requests LetsEncrypt SSL certificates
3. Spins up Docker containers for each enabled proxy protocol.
4. Assigns ports, mounts config files, and handles restart policies.

> Multiplexing over a single port is not yet supported (but may be added in the future).

## 🛠️ Customization

`belfi` gives you flexibility to fine-tune each container’s behavior:

### 🔧 Per-Container Config Files
You can edit a custom config file into the container by editing the `./scripts/subscripts/server/protocol.sh` files where `protocol.sh` is to be replaces with the actual protocol, e.g. `hysteria2.sh`

>Note that it is not necessary to change the `config.json` files located in `./proxy` folder, as they are going to be rewritten by the aforementioned subscripts, when the build script is run.

## 🚀 Getting Started

We provide a bash script that automatically downloads and starts up `belfi`.
```bash
bash <(curl -fsSL https://sh.belfi.io/)
```

Or download via git clone and run manually

```bash
git clone https://github.com/Babybatrick/belfi.git
```
```bash
cd belfi
```
```bash
./build
```


## 🔐 TLS & Domains

At this stage, **TLS is handled by each container individually**. Belfi does not manage certificates or multiplex connections based on domain or SNI (yet).

> In the future, I wish to add multiplexing functionality to this project, to achieve one port many protocols solution, yet my last attempt at this using `nginx` was unsuccessful due to the fact that `nginx` cannot have UDP stream differentiated to be addressed the correct backend.
## 🧱 Roadmap

- [x] Run multiple proxy containers with isolated ports
- [ ] Optional unified TLS termination via reverse proxy (e.g., Nginx, HAProxy)
- [ ] SNI-based routing over a single port (experimental)
- [ ] Web UI for container & user config
- [ ] Stats, logging, and graceful shutdowns

## 🤝 Contributing

Feel free to fork and PR! If you’ve got ideas or feedback, open an issue.

## 📄 License

GNU GENERAL PUBLIC LICENSE V3 © 2025 `babybatrick`

---

> `belfi` — spin up your proxies, your way. 🔧