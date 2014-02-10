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
