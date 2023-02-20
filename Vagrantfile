ENV["LC_ALL"] = "en_US.UTF-8"

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/jammy64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = false

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.99.100"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # The hostname the machine should have.
  config.vm.hostname = "docker-jammy-2302"

  # Mount shared folders.
  config.vm.synced_folder "/Users/ushuz/Code", "/Users/ushuz/Code"
  config.vm.synced_folder "/Users/ushuz/Downloads", "/Users/ushuz/Downloads"
  config.vm.synced_folder "/Users/ushuz/go", "/Users/ushuz/go"

  # # Resize primary disk. This is an experimental feature that requires a
  # # flag, see: https://www.vagrantup.com/docs/disks/usage
  # config.vm.disk :disk, size: "20GB", primary: true

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:

  config.vm.provider "virtualbox" do |vb|
    # VM name
    vb.name = config.vm.hostname
    # Customize the amount of memory on the VM:
    vb.memory = "2048"
  end

  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL

# purge junks
apt-get purge --auto-remove -y \
  accountsservice \
  byobu \
  irqbalance \
  lx* \
  mdadm \
  mlocate \
  networkd-dispatcher \
  policykit-1 \
  python3-distupgrade \
  python3-update-manager \
  snapd* \
  unattended-upgrades

# purge existing docker installation
apt-get purge --auto-remove -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
rm -rf /var/lib/docker /var/lib/containerd

# install docker
CONTAINERD_VERSION=1.6.9-1
DOCKER_VERSION=23.0.1-1
DOCKER_BUILDX_VERSION=0.10.2-1
DOCKER_COMPOSE_VERSION=2.16.0-1
for pkg in \
  "containerd.io_${CONTAINERD_VERSION}_amd64.deb" \
  "docker-ce-cli_${DOCKER_VERSION}~ubuntu.$(lsb_release -rs)~$(lsb_release -cs)_amd64.deb" \
  "docker-ce_${DOCKER_VERSION}~ubuntu.$(lsb_release -rs)~$(lsb_release -cs)_amd64.deb" \
  "docker-buildx-plugin_${DOCKER_BUILDX_VERSION}~ubuntu.$(lsb_release -rs)~$(lsb_release -cs)_amd64.deb" \
  "docker-compose-plugin_${DOCKER_COMPOSE_VERSION}~ubuntu.$(lsb_release -rs)~$(lsb_release -cs)_amd64.deb" \
; do
  [ ! -f $pkg ] && curl -fsSLO "https://download.docker.com/linux/ubuntu/dists/$(lsb_release -cs)/pool/stable/amd64/$pkg" || :
  dpkg -Ei $pkg
done

# grant docker usage
usermod -aG docker vagrant

# daemon json
tee /etc/docker/daemon.json > /dev/null <<EOF
{
  "hosts": [
    "unix://",
    "tcp://0.0.0.0:2375"
  ],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
# remove -H CLI flag set in systemd config to avoid conflicts
sed -i 's|-H fd:// ||g' /lib/systemd/system/docker.service

# reload docker
systemctl daemon-reload
systemctl restart docker

# enable net forward
grep -qxF '^net.ipv4.ip_forward=1' /etc/sysctl.conf || sed -i 's|#net.ipv4.ip_forward=1|net.ipv4.ip_forward=1|g' /etc/sysctl.conf
sysctl -w net.ipv4.ip_forward=1

# # workaround docker disabling forward, see:
# # https://docs.docker.com/network/iptables/
# # https://serverfault.com/a/1005666/414586
# # https://serverfault.com/a/984924/414586
# tee /etc/iptables.rules > /dev/null <<EOF
# *filter
# :DOCKER-USER - [0:0]
# -A DOCKER-USER -j ACCEPT
# COMMIT
# EOF
# tee /etc/systemd/system/restore-iptables.service > /dev/null <<EOF
# [Service]
# Type=oneshot
# ExecStart=/bin/sh -c '/sbin/iptables-restore /etc/iptables.rules'
# [Install]
# WantedBy=network-pre.target
# EOF

# systemctl daemon-reload
# systemctl enable restore-iptables
# systemctl restart restore-iptables

SHELL
end
