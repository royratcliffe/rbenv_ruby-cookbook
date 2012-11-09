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
