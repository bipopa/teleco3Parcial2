# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|


if Vagrant.has_plugin? "vagrant-vbguest"
 config.vbguest.no_install = true
 config.vbguest.auto_update = false
 config.vbguest.no_remote = true
 end

 config.vm.define :firewallParcial do |firewallParcial|
 firewallParcial.vm.box = "centos/stream8" 
 firewallParcial.vm.network :private_network, ip: "209.191.100.5"
 firewallParcial.vm.network :private_network, ip: "192.168.50.15"
 firewallParcial.vm.hostname = "firewallParcial"
 firewallParcial.vm.provision :shell, :path => "script.sh"
 end

 config.vm.define :servidorParcial do |servidorParcial|
 servidorParcial.vm.box = "centos/stream8" 
 servidorParcial.vm.network :private_network, ip: "192.168.50.8"
 servidorParcial.vm.hostname = "servidorParcial"
 servidorParcial.vm.provision :shell, :path => "scriptServer.sh"
 end



end
