# Custom ChefSpec matchers
module ChefSpec::Matchers # rubocop: disable ClassAndModuleChildren
  RSpec::Matchers.define :enable_nginx_site do |site|
    match do |chef_run|
      chef_run.resources.any? do |resource|
        resource.resource_name == :execute && resource.name =~ /.*nxensite.*#{site}/
      end
    end
  end

  RSpec::Matchers.define :disable_nginx_site do |site|
    match do |chef_run|
      chef_run.resources.any? do |resource|
        resource.resource_name == :execute && resource.name =~ /.*nxdissite.*#{site}/
      end
    end
  end
end
