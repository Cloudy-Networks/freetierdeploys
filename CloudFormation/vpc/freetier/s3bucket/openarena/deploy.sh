  #!/bin/bash
  hostnamectl set-hostname oa.cloudynet.work
  sed '9 a 127.0.0.1   oa.cloudynet.work oa' /etc/hosts
  apt -y update && apt -y upgrade
  apt install -y debian-keyring debian-archive-keyring apt-transport-https
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/cfg/gpg/gpg.155B6D79CA56EA34.key' | sudo apt-key add -
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/cfg/setup/config.deb.txt?distro=debian&version=any-version' | sudo tee -a /etc/apt/sources.list.d/caddy-stable.list
  apt -y update && apt -y install openarena-server openarena-oacmp1 unzip caddy
  aws s3 cp "s3://ll-ig-oa/oaconfig/server.cfg" "/etc/openarena-server/server.cfg"
  wget https://www.excessiveplus.net/files/release/xp-oa-2.3.zip -P /usr/lib/openarena-server/ && unzip  /usr/lib/openarena-server/xp-oa-2.3.zip
  unzip  /usr/lib/openarena-server/xp-oa-2.3.zip -d /usr/lib/openarena-server/
  mkdir /usr/share/caddy/excessiveplus/
  mkdir /usr/share/caddy/oacmp-mod/
  cp /usr/lib/openarena-server/excessiveplus/* /usr/share/caddy/excessiveplus
  cp /usr/lib/openarena-server/oacmp-mod/* /usr/share/caddy/oacmp-mod/
  sed -i 's/:80/oa.cloudynet.work/g' /etc/caddy/Caddyfile
  reboot
