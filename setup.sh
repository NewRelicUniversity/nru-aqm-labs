#!/bin/sh

echo
echo Updating repositories...
wget -O- https://apt.releases.hashicorp.com/gpg > /dev/null 2>&1 | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null 2>&1
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null 2>&1
sudo apt update > /dev/null 2>&1
sudo scripts/preinst.sh

echo Downloading Infrastructure agent...
wget https://download.newrelic.com/infrastructure_agent/binaries/linux/amd64/newrelic-infra_linux_1.51.0_amd64.tar.gz > /dev/null 2>&1
echo Extracting archive...
tar -xf newrelic-infra_linux_1.51.0_amd64.tar.gz > /dev/null

echo Installing agent...
sudo mv ./newrelic-infra/etc/newrelic-infra /etc/
sudo mkdir /etc/newrelic-infra/logging.d
sudo mv ./newrelic-infra/usr/bin/* /usr/bin/
sudo mkdir -p /var/db/newrelic-infra/newrelic-integrations/logging
sudo mv ./newrelic-infra/var/db/newrelic-infra/ /var/db/newrelic-infra
sudo mkdir /var/log/newrelic-infra
sudo mkdir /var/run/newrelic-infra

echo Installing fluent-bit...
wget https://github.com/newrelic/fluent-bit-package/releases/download/2.0.8/fluent-bit_2.0.8_ubuntu-jammy_amd64.deb > /dev/null 2>&1
sudo apt install ./fluent-bit_2.0.8_ubuntu-jammy_amd64.deb -y > /dev/null 2>&1
sudo wget -O /var/db/newrelic-infra/newrelic-integrations/logging/out_newrelic.so https://github.com/newrelic/newrelic-fluent-bit-output/releases/download/v1.19.1/out_newrelic-linux-amd64-1.19.1.so > /dev/null 2>&1
sudo wget -O /var/db/newrelic-infra/newrelic-integrations/logging/parsers.conf https://raw.githubusercontent.com/newrelic/fluent-bit-package/main/parsers.conf > /dev/null 2>&1

echo Installing stress-ng...
sudo apt install stress-ng -y > /dev/null 2>&1

echo Installing terraform...
sudo apt install terraform -y > /dev/null 2>&1

echo Cleaning up
rm fluent-bit_2.0.8_ubuntu-jammy_amd64.deb
rm newrelic-infra_linux_1.51.0_amd64.tar.gz
rm -rf newrelic-infra/

sudo scripts/postinst.sh
echo
