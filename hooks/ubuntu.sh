#!/bin/bash -ex

http_proxy="http://qa-proxy.qa.ebay.com:80"
no_proxy="qa.ebay.com, vip.ebay.com"
export http_proxy no_proxy

wget -q -O - "http://apt.puppetlabs.com/pubkey.gpg" | sudo apt-key add -
echo "deb http://apt.puppetlabs.com `lsb_release -cs` main" | sudo tee /etc/apt/sources.list.d/puppet.list

apt-get update
apt-get install -y puppet git-core

git_repo="git://qagit.qa.ebay.com/GITHUB/jiyjiang/pipeline_cm_ux.git"
rm -rf puppet
git clone $git_repo puppet
puppet apply -l "/var/log/puppet/jenkins.log" --modulepath=puppet/modules "puppet/manifests/site.pp"