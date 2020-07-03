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
  config.vm.box = "ubuntu/bionic64"

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
  config.vm.hostname = "docker-bionic-2004"
  config.vm.define "docker-bionic-2004"

  # Shared folders
  config.vm.synced_folder "/Users/ushuz/Code", "/Users/ushuz/Code"
  config.vm.synced_folder "/Users/ushuz/go", "/Users/ushuz/go"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:

  config.vm.provider "virtualbox" do |vb|
    # VM name
    vb.name = "docker-bionic-2004"
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
  lx* \
  mdadm \
  mlocate \
  policykit-1 \
  python3-distupgrade \
  python3-update-manager \
  snapd* \
  unattended-upgrades

# surge
export http_proxy=http://10.0.2.2:6152
export https_proxy=http://10.0.2.2:6152

# download / install
for pkg in \
  containerd.io_1.2.6-3_amd64.deb \
  docker-ce-cli_19.03.8~3-0~ubuntu-bionic_amd64.deb \
  docker-ce_19.03.8~3-0~ubuntu-bionic_amd64.deb \
; do
  [ ! -f $pkg ] && curl -fsSLO https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/$pkg || :
  dpkg -Ei $pkg
done

# grant docker usage
usermod -aG docker vagrant

# configure daemon

# daemon json
tee /etc/docker/daemon.json > /dev/null <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "experimental": true,
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

mkdir -p /etc/systemd/system/docker.service.d

# override ExecStart
tee /etc/systemd/system/docker.service.d/start.conf > /dev/null <<EOF
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd
EOF
# daemon proxy
tee /etc/systemd/system/docker.service.d/proxy.conf > /dev/null <<EOF
[Service]
Environment="HTTP_PROXY=${http_proxy}" "HTTPS_PROXY=${https_proxy}"
EOF

systemctl daemon-reload
systemctl restart docker
SHELL
end
