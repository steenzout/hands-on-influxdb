#!/usr/bin/env ruby

require 'yaml'

PLAYBOOK = 'site.yml'
CONFIGURATION_FILE = 'boxes.yml'

Vagrant.configure('2') do |config|

  # overcome 'stdin: is not a tty' errors when trying to provision on vivid64
  config.ssh.pty = true
  config.ssh.shell = 'bash'

  # puts "[DEBUG] loading box settings from #{CONFIGURATION_FILE}..."
  vagrant_environment = YAML.load_file(File.expand_path(CONFIGURATION_FILE, File.dirname(__FILE__)))

  vagrant_environment['vagrant'].each do |box_name, box_settings|
    if not box_settings['enabled']
        # puts "[DEBUG] #{box_name} is not enabled. skipping..."
        next
    end

    # puts "[DEBUG] applying #{box_name} settings..."
    config.vm.define box_name do |host|

      host.vm.box = box_settings['box'] unless not box_settings.key? 'box'

      host.vm.network box_settings['network']['name'], ip: box_settings['network']['ip'] unless box_settings.key? 'network'
      host.vm.network :forwarded_port, guest: 8083, host: 4560 # Admin
      host.vm.network :forwarded_port, guest: 8086, host: 4567 # API
      host.vm.network :forwarded_port, guest: 3000, host: 4568 # Grafana

      # puts "[DEBUG] applying virtualbox settings for #{box_name} box..."
      customize_args = [ "modifyvm", :id ]
      box_settings['provider']['virtualbox'].collect { |k, v| customize_args |= ["--#{k}", v.to_s] }
      host.vm.provider 'virtualbox' do |vb|
        vb.customize customize_args
      end

      # puts "[DEBUG] provision using ansible vagrant playbook..."
      host.vm.provision 'ansible' do |ansible|
        ansible.playbook = PLAYBOOK
        ansible.verbose = 'v'
      end
    end
  end
end

