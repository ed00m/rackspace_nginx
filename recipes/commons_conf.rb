#
# Cookbook Name:: rackspace_nginx
# Recipe:: common/conf
#
# Author:: AJ Christensen <aj@junglist.gen.nz>
# Author:: Jason Nelson (<jason.nelson@rackspace.com>)
#
# Copyright 2008-2013, Opscode, Inc.
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

template 'nginx.conf' do
  cookbook node['rackspace_nginx']['templates']['nginx.conf']
  path   "#{node['rackspace_nginx']['config']['dir']}/nginx.conf"
  source 'nginx.conf.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  notifies :reload, 'service[nginx]'
end

template "#{node['rackspace_nginx']['config']['dir']}/sites-available/default" do
  source 'default-site.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  notifies :reload, 'service[nginx]'
end

nginx_site 'default' do
  enable node['rackspace_nginx']['config']['default_site_enabled']
end

template "#{node['rackspace_nginx']['config']['dir']}/fastcgi_params" do
  cookbook node['rackspace_nginx']['templates']['fastcgi_params']
  source 'fastcgi_params.erb'
  mode 0644
  owner 'root'
  group 'root'
  notifies :reload, 'service[nginx]'
  only_if { node['rackspace_nginx']['fastcgi_params'] }
end
