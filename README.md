# Conventional Commits

## Conventional Commit CLI Helper - PoC

This is a conventional commits helper for the CLI. This is not
my code, it is a tutorial done by Charmbracelet on the subject of
[gum](https://github.com/charmbracelet/gum).

## Installation


```bash
# macOS or Linux
brew install gum

# Arch Linux (btw)
pacman -S gum

# Nix
nix-env -iA nixpkgs.gum
# Or, with flakes
nix run "github:charmbracelet/gum" -- --help

# Debian/Ubuntu
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install gum

# Fedora/RHEL
echo '[charm]
name=Charm
baseurl=https://repo.charm.sh/yum/
enabled=1
gpgcheck=1
gpgkey=https://repo.charm.sh/yum/gpg.key' | sudo tee /etc/yum.repos.d/charm.repo
sudo yum install gum

# Alpine
apk add gum

# Android (via termux)
pkg install gum

# Or with Go
go install github.com/charmbracelet/gum@latest
```
---

You can also download the binaries from the [releases page](https://github.com/charmbracelet/gum/releases), or build from source:

```bash
git clone https://github.com/charmbracelet/gum

```

