#
# Cookbook Name:: rackspace_nginx
# Recipe:: authorized_ips
#
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
# Author:: Jason Nelson (<jason.nelson@rackspace.com>)
#
# Copyright 2012-2013, Riot Games
# Copyright 2014. Rackspace, US Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node.default['rackspace_nginx']['remote_ip_var']  = 'remote_addr'
node.default['rackspace_nginx']['authorized_ips'] = ['127.0.0.1/32']

template 'authorized_ip' do
  cookbook node['rackspace_nginx']['templates']['authorized_ip']
  path   "#{node['rackspace_nginx']['config']['dir']}/authorized_ip"
  source 'modules/authorized_ip.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  notifies :reload, 'service[nginx]'
  variables(
    cookbook_name: cookbook_name
  )
end
