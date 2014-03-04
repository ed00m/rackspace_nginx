#
# Cookbook Name:: rackspace_nginx
# Attributes:: default
#
# Author:: Adam Jacob (<adam@opscode.com>)
# Author:: Joshua Timberman (<joshua@opscode.com>)
# Author:: Jason Nelson (<jason.nelson@rackspace.com>)
#
# Copyright 2009-2013, Opscode, Inc.
# Copyright 2014, Rackspace, US Inc.
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

# In order to update the version, the checksum attribute must be changed too.
# This attribute is in the source.rb file, though we recommend overriding
# attributes by modifying a role, or the node itself.
default['rackspace_nginx']['version']              = '1.2.9'
default['rackspace_nginx']['package_name']         = 'nginx'
default['rackspace_nginx']['package_version']      = nil
default['rackspace_nginx']['config']['dir']        = '/etc/nginx'
default['rackspace_nginx']['config']['script_dir'] = '/usr/sbin'
default['rackspace_nginx']['config']['log_dir']    = '/var/log/nginx'
default['rackspace_nginx']['binary']               = '/usr/sbin/nginx'

case node['platform_family']
when 'debian'
  default['rackspace_nginx']['config']['user'] = 'www-data'
when 'rhel'
  default['rackspace_nginx']['config']['user'] = 'nginx'
  default['rackspace_nginx']['repo_source']    = 'nginx'
else
  default['rackspace_nginx']['config']['user'] = 'www-data'
end

default['rackspace_nginx']['fastcgi_params'] = false

default['rackspace_nginx']['upstart']['runlevels']     = '2345'
default['rackspace_nginx']['upstart']['respawn_limit'] = nil
default['rackspace_nginx']['upstart']['foreground']    = true

default['rackspace_nginx']['config']['group'] = node['rackspace_nginx']['config']['user']

default['rackspace_nginx']['config']['pid'] = '/var/run/nginx.pid'

default['rackspace_nginx']['config']['gzip']              = 'on'
default['rackspace_nginx']['config']['gzip_http_version'] = '1.0'
default['rackspace_nginx']['config']['gzip_comp_level']   = '2'
default['rackspace_nginx']['config']['gzip_proxied']      = 'any'
default['rackspace_nginx']['config']['gzip_vary']         = 'off'
default['rackspace_nginx']['config']['gzip_buffers']      = nil
default['rackspace_nginx']['config']['gzip_types']        = %w[
                                                    text/plain
                                                    text/css
                                                    application/x-javascript
                                                    text/xml
                                                    application/xml
                                                    application/rss+xml
                                                    application/atom+xml
                                                    text/javascript
                                                    application/javascript
                                                    application/json
                                                    text/mathml
                                                  ]
default['rackspace_nginx']['config']['gzip_min_length']   = 1_000
default['rackspace_nginx']['config']['gzip_disable']      = 'MSIE [1-6]\.'

default['rackspace_nginx']['config']['keepalive']            = 'on'
default['rackspace_nginx']['config']['keepalive_timeout']    = 65
default['rackspace_nginx']['config']['worker_processes']     = node['cpu'] && node['cpu']['total'] ? node['cpu']['total'] : 1
default['rackspace_nginx']['config']['worker_connections']   = 1_024
default['rackspace_nginx']['config']['worker_rlimit_nofile'] = nil
default['rackspace_nginx']['config']['multi_accept']         = false
default['rackspace_nginx']['config']['event']                = nil
default['rackspace_nginx']['config']['server_tokens']        = nil
default['rackspace_nginx']['config']['server_names_hash_bucket_size'] = 64
default['rackspace_nginx']['config']['sendfile'] = 'on'

default['rackspace_nginx']['config']['access_log_options']     = nil
default['rackspace_nginx']['config']['error_log_options']      = nil
default['rackspace_nginx']['config']['disable_access_log']     = false
default['rackspace_nginx']['config']['install_method']         = 'package'
default['rackspace_nginx']['config']['default_site_enabled']   = true
default['rackspace_nginx']['config']['types_hash_max_size']    = 2_048
default['rackspace_nginx']['config']['types_hash_bucket_size'] = 64

default['rackspace_nginx']['config']['proxy_read_timeout']      = nil
default['rackspace_nginx']['config']['client_body_buffer_size'] = nil
default['rackspace_nginx']['config']['client_max_body_size']    = nil
