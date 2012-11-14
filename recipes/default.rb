#
# Cookbook Name:: rbenv_ruby
# Recipe:: default
#
# Copyright 2012, Pioneering Software, United Kingdom
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node[:rbenv_rubies].each do |rubie|
  Chef::Log.info "Installing Ruby #{rubie}"
  rbenv_ruby rubie do
    action :install
  end
end

ruby_block "set up rbenv root, path, version and gem_binary" do
  block do
    # Converge! The following runs at convergence time. Set up node attributes
    # to help out other recipes configure their environment suitable for a
    # particular Ruby. The Unix environment needs variables RBENV_ROOT, PATH and
    # RBENV_VERSION setting up. Gem-based binaries appear as shims.
    node.set[:rbenv_root] = node[:rbenv][:root_path]
    node.set[:rbenv_path] = [::File.join(node[:rbenv_root], 'bin'), ::File.join(node[:rbenv_root], 'shims')].join(':')

    # Automatically configure a default gem binary if and only if the node
    # carries the rbenv_rubies attribute and it contains just a single Ruby
    # version. In such cases, assume that the node intends to use the single
    # Ruby environment as a default. This assumes that you use the rbenv_ruby
    # cookbook to install Ruby versions using Fletcher Nichol's rbenv cookbook.
    if node[:rbenv_rubies] && node[:rbenv_rubies].length == 1
      node.set[:rbenv_version] = node[:rbenv_rubies][0]
      node.set[:gem_binary] = ::File.join(node[:rbenv_root], 'versions', node[:rbenv_version], 'bin', 'gem') unless node[:gem_binary]
    end

    # If a gem binary location exists, whether automatically derived or not,
    # work out the gem paths by shelling out to the gem binary asking for gem
    # paths. Set up node[:gem_path] equal to the string for finding gems.
    if node[:gem_binary]
      shell_out = Mixlib::ShellOut.new("#{node[:gem_binary]} env gempath")
      shell_out.run_command
      shell_out.error!
      node.set[:gem_path] = shell_out.stdout.chomp
    end
  end
end
