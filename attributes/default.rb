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
default['rackspace_nginx']['version']      = '1.2.9'
default['rackspace_nginx']['package_name'] = 'nginx'
default['rackspace_nginx']['dir']          = '/etc/nginx'
default['rackspace_nginx']['script_dir']   = '/usr/sbin'
default['rackspace_nginx']['log_dir']      = '/var/log/nginx'
default['rackspace_nginx']['binary']       = '/usr/sbin/nginx'

case node['platform_family']
when 'debian'
  default['rackspace_nginx']['user']       = 'www-data'
  default['rackspace_nginx']['init_style'] = 'runit'
when 'rhel'
  default['rackspace_nginx']['user']        = 'nginx'
  default['rackspace_nginx']['init_style']  = 'init'
  default['rackspace_nginx']['repo_source'] = 'nginx'
else
  default['rackspace_nginx']['user']       = 'www-data'
  default['rackspace_nginx']['init_style'] = 'init'
end

default['rackspace_nginx']['upstart']['runlevels']     = '2345'
default['rackspace_nginx']['upstart']['respawn_limit'] = nil
default['rackspace_nginx']['upstart']['foreground']    = true

default['rackspace_nginx']['group'] = node['rackspace_nginx']['user']

default['rackspace_nginx']['pid'] = '/var/run/nginx.pid'

default['rackspace_nginx']['gzip']              = 'on'
default['rackspace_nginx']['gzip_http_version'] = '1.0'
default['rackspace_nginx']['gzip_comp_level']   = '2'
default['rackspace_nginx']['gzip_proxied']      = 'any'
default['rackspace_nginx']['gzip_vary']         = 'off'
default['rackspace_nginx']['gzip_buffers']      = nil
default['rackspace_nginx']['gzip_types']        = %w[
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
default['rackspace_nginx']['gzip_min_length']   = 1_000
default['rackspace_nginx']['gzip_disable']      = 'MSIE [1-6]\.'

default['rackspace_nginx']['keepalive']            = 'on'
default['rackspace_nginx']['keepalive_timeout']    = 65
default['rackspace_nginx']['worker_processes']     = node['cpu'] && node['cpu']['total'] ? node['cpu']['total'] : 1
default['rackspace_nginx']['worker_connections']   = 1_024
default['rackspace_nginx']['worker_rlimit_nofile'] = nil
default['rackspace_nginx']['multi_accept']         = false
default['rackspace_nginx']['event']                = nil
default['rackspace_nginx']['server_tokens']        = nil
default['rackspace_nginx']['server_names_hash_bucket_size'] = 64
default['rackspace_nginx']['sendfile'] = 'on'

default['rackspace_nginx']['access_log_options']     = nil
default['rackspace_nginx']['error_log_options']      = nil
default['rackspace_nginx']['disable_access_log']     = false
default['rackspace_nginx']['install_method']         = 'package'
default['rackspace_nginx']['default_site_enabled']   = true
default['rackspace_nginx']['types_hash_max_size']    = 2_048
default['rackspace_nginx']['types_hash_bucket_size'] = 64

default['rackspace_nginx']['proxy_read_timeout']      = nil
default['rackspace_nginx']['client_body_buffer_size'] = nil
default['rackspace_nginx']['client_max_body_size']    = nil
