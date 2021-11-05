# Configuration

Bash script for setting up my Fedora workstation from scratch. Installs packages and plugins, and configures several things.

```console
git clone https://github.com/0x8b/configuration.git ~/configuration
cd ~/configuration
chmod +x fedora-post-installer.bash
USERNAME=username sudo bash fedora-post-installer.bash |& tee /var/log/bootstrap.log
```
