# archpi — Arch Linux Post-Installation

Post-installation script that turns a fresh **Arch Linux** into a complete
development workstation.

## Layout

```
archpi/
├── install.sh            # executor: sources lib/, prompts per phase
├── lib/
│   ├── common.sh         # helpers, logging, idempotency, ask_phase
│   └── phases/           # one file per phase (01.sh … 14.sh)
├── lists/                # install lists (edit freely)
└── scripts/verify.sh     # oracle
```

## Usage

```bash
git clone https://github.com/EmanuProds/archpi.git && cd archpi
chmod +x install.sh
sudo ./install.sh
```

Interactive: each phase asks before running (10s countdown, auto-yes).
Full log in `/tmp/archpi.log`.

## License

MIT — EmanuProds