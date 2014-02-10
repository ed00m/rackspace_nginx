rackspace_nginx Cookbook
==============

Installs nginx from package and sets up configuration handling similar to Debian's Apache2 scripts.


Requirements
------------
### Cookbooks
The following cookbooks are direct dependencies because they're used for common "default" functionality.

- ohai (for nginx::ohai_plugin)

The following cookbook is not a strict dependency because its use can be controlled by an attribute, so it may not be a common "default."

- On Ubuntu, when using Nginx.org's stable package, `recipe[rackspace_apt::default]` is required.


### Platforms
The following platforms are supported and tested under test kitchen:

- Ubuntu 12.04
- CentOS 6.4
- Debian 7.2

Other Debian and RHEL family distributions are assumed to work.


Attributes
----------
Node attributes for this cookbook are logically separated into different files. Some attributes are set only via a specific recipe.

### default
Generally used attributes. Some have platform specific values. See `attributes/default.rb`. "The Config" refers to "nginx.conf" the main config file.

- `node['rackspace_nginx']['config']['dir']` - Location for Nginx configuration.
- `node['rackspace_nginx']['config']['log_dir']` - Location for Nginx logs.
- `node['rackspace_nginx']['config']['user']` - User that Nginx will run as.
- `node['rackspace_nginx']['config']['group]` - Group for Nginx.
- `node['rackspace_nginx']['binary']` - Path to the Nginx binary.
- `node['rackspace_nginx']['upstart']['foreground']` - Set this to true if you
  want upstart to run nginx in the foreground, set to false if you
  want upstart to detach and track the process via pid.
- `node['rackspace_nginx']['upstart']['runlevels']` - String of runlevels in the
  format '2345' which determines which runlevels nginx will start at
  when entering and stop at when leaving.
- `node['rackspace_nginx']['upstart']['respawn_limit']` - Respawn limit in upstart
  stanza format, count followed by space followed by interval in seconds.
- `node['rackspace_nginx']['config']['pid']` - Location of the PID file.
- `node['rackspace_nginx']['config']['keepalive']` - Whether to use `keepalive_timeout`,
  any value besides "on" will leave that option out of the config.
- `node['rackspace_nginx']['config']['keepalive_timeout']` - used for config value of
  `keepalive_timeout`.
- `node['rackspace_nginx']['config']['worker_processes']` - used for config value of
  `worker_processes`.
- `node['rackspace_nginx']['config']['worker_connections']` - used for config value of
  `events { worker_connections }`
- `node['rackspace_nginx']['config']['worker_rlimit_nofile']` - used for config value of
  `worker_rlimit_nofile`. Can replace any "ulimit -n" command. The
  value depend on your usage (cache or not) but must always be
  superior than worker_connections.
- `node['rackspace_nginx']['config']['multi_accept']` - used for config value of `events {
  multi_accept }`. Try to accept() as many connections as possible.
  Disable by default.
- `node['rackspace_nginx']['config']['event']` - used for config value of `events { use
  }`. Set the event-model. By default nginx looks for the most
  suitable method for your OS.
- `node['rackspace_nginx']['config']['server_tokens']` - used for config value of
  `server_tokens`.
- `node['rackspace_nginx']['config']['server_names_hash_bucket_size']` - used for config
  value of `server_names_hash_bucket_size`.
- `node['rackspace_nginx']['config']['disable_access_log']` - set to true to disable the
  general access log, may be useful on high traffic sites.
- `node['rackspace_nginx']['config']['access_log_options']` - Set to a string of additional options
  to be appended to the access log directive
- `node['rackspace_nginx']['config']['error_log_options']` - Set to a string of additional options
  to be appended to the error log directive
- `node['rackspace_nginx']['config']['default_site_enabled']` - enable the default site
- `node['rackspace_nginx']['config']['sendfile']` - Whether to use `sendfile`. Defaults to "on".
- `node['rackspace_nginx']['config']['install_method']` - Whether nginx is installed from
  packages or from source.
- `node['rackspace_nginx']['config']['types_hash_max_size']` - Used for the
  `types_hash_max_size` configuration directive.
- `node['rackspace_nginx']['config']['types_hash_bucket_size']` - Used for the
  `types_hash_bucket_size` configuration directive.
- `node['rackspace_nginx']['config']['proxy_read_timeout']` - defines a timeout (between two
  successive read operations) for reading a response from the proxied server.
- `node['rackspace_nginx']['config']['client_body_buffer_size']` - used for config value of
  `client_body_buffer_size`.
- `node['rackspace_nginx']['config']['client_max_body_size']` - specifies the maximum accepted body
  size of a client request, as indicated by the request header Content-Length.
- `node['rackspace_nginx']['repo_source']` - when installed from a package this attribute affects
  which yum repositories, if any, will be added before installing the nginx package. The
  default value of nginx' will use the `nginx::repo` recipe, and setting no value will not add any 
  additional repositories.

### gzip module

- `node['rackspace_nginx']['config']['gzip']` - Whether to use gzip, can be "on" or "off"
- `node['rackspace_nginx']['config']['gzip_http_version']` - used for config value of `gzip_http_version`.
- `node['rackspace_nginx']['config']['gzip_comp_level']` - used for config value of `gzip_comp_level`.
- `node['rackspace_nginx']['config']['gzip_proxied']` - used for config value of `gzip_proxied`.
- `node['rackspace_nginx']['config']['gzip_vary']` - used for config value of `gzip_vary`.
- `node['rackspace_nginx']['config']['gzip_buffers']` - used for config value of `gzip_buffers`.
- `node['rackspace_nginx']['config']['gzip_types']` - used for config value of `gzip_types` - must be an Array.
- `node['rackspace_nginx']['config']['gzip_min_length']` - used for config value of `gzip_min_length`.
- `node['rackspace_nginx']['config']['gzip_disable']` - used for config value of `gzip_disable`.

### Attributes set in recipes

#### nginx::authorized_ips
- `node['rackspace_nginx']['remote_ip_var']` - The remote ip variable name to
  use.
- `node['rackspace_nginx']['authorized_ips']` - IPs authorized by the module

### status
These attributes are used in the `nginx::http_stub_status_module` recipe.

- `node['rackspace_nginx']['status']['port']` - The port on which nginx will
  serve the status info (default: 8090)

Recipes
-------
This cookbook provides three main recipes for installing Nginx.

- `default.rb` - *Use this recipe* if you have a native package for
  Nginx.
- `repo.rb` - The developer of Nginx also maintain
  [stable packages](http://nginx.org/en/download.html) for several
  platforms.

Several recipes are related to the `source` recipe specifically. See
that recipe's section below for a description.

### default
The default recipe will install Nginx as a native package for the
system through the package manager and sets up the configuration
according to the Debian site enable/disable style with `sites-enabled`
using the `nxensite` and `nxdissite` scripts. The nginx service will
be managed with the normal init scripts that are presumably included
in the native package.

Includes the `ohai_plugin` recipe so the plugin is available.

### ohai_plugin
This recipe provides an Ohai plugin as a template. It is included by
both the `default` and `source` recipes.

### authorized_ips
Sets up configuration for the `authorized_ip` nginx module.

Ohai Plugin
-----------
The `ohai_plugin` recipe includes an Ohai plugin. It will be
automatically installed and activated, providing the following
attributes via ohai, no matter how nginx is installed (source or
package):

- `node['rackspace_nginx']['version']` - version of nginx
- `node['rackspace_nginx']['prefix']` - installation prefix
- `node['rackspace_nginx']['conf_path']` - configuration file path

In the source recipe, it is used to determine whether control
attributes for building nginx have changed.


Usage
-----
Include the recipe on your node or role that fits how you wish to
install Nginx on your system per the recipes section above. Modify the
attributes as required in your role to change how various
configuration is applied per the attributes section above. In general,
override attributes in the role should be used when changing
attributes.

There's some redundancy in that the config handling hasn't been
separated from the installation method (yet), so use only one of the
recipes, default or source.

Testing
-------

Pleas see testing guidelines at [contributing](https://github.com/rackspace-cookbooks/contributing/blob/master/CONTRIBUTING.md)

Contributing
------------

Please see contributing guidelines at [contributing](https://github.com/rackspace-cookbooks/contributing/blob/master/CONTRIBUTING.md)


License & Authors
-----------------
- Author:: Joshua Timberman (<joshua@opscode.com>)
- Author:: Adam Jacob (<adam@opscode.com>)
- Author:: AJ Christensen (<aj@opscode.com>)
- Author:: Jamie Winsor (<jamie@vialstudios.com>)
- Author:: Jason Nelson (<jason.nelson@rackspace.com>)

```text
Copyright 2008-2013, Opscode, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
