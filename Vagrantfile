# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2204"

  nodes = [
    { name: "vm1", idx: 1, ip_int: "172.16.0.2",  ip_nat: "172.16.10.2", ip_pf: "172.16.20.2" },
    { name: "vm2", idx: 2, ip_int: "172.16.0.3",  ip_nat: "172.16.11.2" },
    { name: "vm3", idx: 3, ip_int: "172.16.0.4",  ip_nat: "172.16.12.2" }
  ]

  nodes.each do |n|
    config.vm.define n[:name] do |node|
      node.vm.hostname = n[:name]

      # Red interna común entre VMs (aislada del exterior)
      node.vm.network "private_network",
        type: "dhcp",
        ip: n[:ip_int],
        netmask: "255.255.255.0",
        libvirt__network_name: "int_172_16_0",
        libvirt__network_address: "172.16.0.0",
        libvirt__netmask: "255.255.255.0",
        libvirt__forward_mode: "none",
        libvirt__dhcp_enabled: false

      # Red NAT propia por VM (sin L2 compartida)
      nat_net_name = "nat_#{n[:name]}"
      nat_prefix =
        case n[:name]
        when "vm1" then "172.16.10.0"
        when "vm2" then "172.16.11.0"
        else            "172.16.12.0"
        end

      node.vm.network "private_network",
        type: "dhcp",
        ip: n[:ip_nat],
        netmask: "255.255.255.0",
        libvirt__network_name: nat_net_name,
        libvirt__network_address: nat_prefix,
        libvirt__netmask: "255.255.255.0",
        libvirt__forward_mode: "nat",
        libvirt__dhcp_enabled: false

      # Solo vm1: NIC extra NAT para port forwarding con una red distinta
      if n[:name] == "vm1"
        node.vm.network "private_network",
          type: "dhcp",
          ip: n[:ip_pf],
          netmask: "255.255.255.0",
          libvirt__network_name: "nat_pf_vm1",
          libvirt__network_address: "172.16.20.0",
          libvirt__netmask: "255.255.255.0",
          libvirt__forward_mode: "nat",
          libvirt__dhcp_enabled: false

        node.vm.network "forwarded_port", guest: 80,   host: 80,   host_ip: "0.0.0.0", auto_correct: false
        node.vm.network "forwarded_port", guest: 443,  host: 443,  host_ip: "0.0.0.0", auto_correct: false
        node.vm.network "forwarded_port", guest: 8080, host: 8080, host_ip: "0.0.0.0", auto_correct: false
      end

      node.vm.provider :libvirt do |lv|
        lv.memory = 2048
        lv.cpus = 2

        # Evita contención del TPM hardware al arrancar varias VMs
        lv.tpm_type = "emulator"
        lv.tpm_version = "2.0"
        lv.tpm_model = "tpm-crb"
      end
    end
  end
end
