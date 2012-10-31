#
# Cookbook Name:: rbenv_ruby
# Recipe:: default
#
# Copyright 2012, Pioneering Software, United Kingdom
# All rights reserved
#

node[:rbenv_rubies].each do |rubie|
  Chef::Log.info "Installing Ruby #{rubie}"
  rbenv_ruby rubie do
    action :install
  end
end
