#
# Cookbook Name:: rackspace_nginx
# Recipe:: repo
# Author:: Nick Rycar <nrycar@bluebox.net>
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

case node['platform_family']
when 'rhel'
  include_recipe 'rackspace_yum::default'

  rackspace_yum_key 'nginx' do
    url    'http://nginx.org/keys/nginx_signing.key'
    key    'RPM-GPG-KEY-Nginx'
    action :add
  end

  rackspace_yum_repository 'nginx' do
    description 'Nginx.org Repository'
    url         node['rackspace_nginx']['upstream_repository']
  end

when 'debian'
  include_recipe 'rackspace_apt::default'

  rackspace_apt_repository 'nginx' do
    uri          node['rackspace_nginx']['upstream_repository']
    distribution node['lsb']['codename']
    components   %w( nginx )
    deb_src      true
    key          'http://nginx.org/keys/nginx_signing.key'
    # this apt-get update resource is from rackspace_apt::default
    notifies     :run, 'execute[apt-get update]', :immediately
  end
end
