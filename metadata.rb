name              'rackspace_nginx'
maintainer        'Rackspace, US Inc.'
maintainer_email  'rackspace-cookbooks@rackspace.com'
license           'Apache 2.0'
description       'Installs and configures nginx'
version           '3.0.0'

recipe 'rackspace_nginx',         'Installs nginx package and sets up configuration with Debian apache style with sites-enabled/sites-available'

depends 'rackspace_apt',             '~> 3.0'
depends 'ohai',                      '~> 1.1'
depends 'rackspace_yum',             '~> 4.0'

supports 'centos'
supports 'debian'
supports 'redhat'
supports 'ubuntu'

attribute 'rackspace_nginx/dir',
          display_name: 'Nginx Directory',
          description: 'Location of nginx configuration files',
          default: '/etc/nginx'

attribute 'rackspace_nginx/log_dir',
          display_name: 'Nginx Log Directory',
          description: 'Location for nginx logs',
          default: '/var/log/nginx'

attribute 'rackspace_nginx/user',
          display_name: 'Nginx User',
          description: 'User nginx will run as',
          default: 'www-data'

attribute 'rackspace_nginx/binary',
          display_name: 'Nginx Binary',
          description: 'Location of the nginx server binary',
          default: '/usr/sbin/nginx'

attribute 'rackspace_nginx/gzip',
          display_name: 'Nginx Gzip',
          description: 'Whether gzip is enabled',
          default: 'on'

attribute 'rackspace_nginx/gzip_http_version',
          display_name: 'Nginx Gzip HTTP Version',
          description: 'Version of HTTP Gzip',
          default: '1.0'

attribute 'rackspace_nginx/gzip_comp_level',
          display_name: 'Nginx Gzip Compression Level',
          description: 'Amount of compression to use',
          default: '2'

attribute 'rackspace_nginx/gzip_proxied',
          display_name: 'Nginx Gzip Proxied',
          description: 'Whether gzip is proxied',
          default: 'any'

attribute 'rackspace_nginx/gzip_types',
          display_name: 'Nginx Gzip Types',
          description: 'Supported MIME-types for gzip',
          type: 'array',
          default: ['text/plain',
                    'text/css',
                    'application/x-javascript',
                    'text/xml',
                    'application/xml',
                    'application/xml+rss',
                    'text/javascript',
                    'application/javascript',
                    'application/json']

attribute 'rackspace_nginx/keepalive',
          display_name: 'Nginx Keepalive',
          description: 'Whether to enable keepalive',
          default: 'on'

attribute 'rackspace_nginx/keepalive_timeout',
          display_name: 'Nginx Keepalive Timeout',
          default: '65'

attribute 'rackspace_nginx/worker_processes',
          display_name: 'Nginx Worker Processes',
          description: 'Number of worker processes',
          default: '1'

attribute 'rackspace_nginx/worker_connections',
          display_name: 'Nginx Worker Connections',
          description: 'Number of connections per worker',
          default: '1024'

attribute 'rackspace_nginx/server_names_hash_bucket_size',
          display_name: 'Nginx Server Names Hash Bucket Size',
          default: '64'

attribute 'rackspace_nginx/types_hash_max_size',
          display_name: 'Nginx Types Hash Max Size',
          default: '2048'

attribute 'rackspace_nginx/types_hash_bucket_size',
          display_name: 'Nginx Types Hash Bucket Size',
          default: '64'

attribute 'rackspace_nginx/disable_access_log',
          display_name: 'Disable Access Log',
          default: 'false'

attribute 'rackspace_nginx/default_site_enabled',
          display_name: 'Default site enabled',
          default: 'true'

attribute 'rackspace_nginx/sendfile',
          display_name: 'Nginx sendfile',
          description: 'Whether to enable sendfile',
          default: 'on'
