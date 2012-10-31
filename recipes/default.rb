#
# Cookbook Name:: rbenv_ruby
# Recipe:: default
#
# Copyright 2012, Pioneering Software, United Kingdom
# All rights reserved
#

node[:rbenv_ruby].each do |rbenv|
  Chef::Log.info "Installing Ruby #{rbenv.map { |k, v| "#{k}:#{v}" }.join(' ') }"
  rbenv_ruby rbenv[:ruby_version] do
    global rbenv[:global] || false
    force rbenv[:force] || false
  end
end
