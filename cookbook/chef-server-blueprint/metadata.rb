name             'chef-server-blueprint'
maintainer       'Ryan J. Geyer'
maintainer_email 'me@ryangeyer.com'
license          'All rights reserved'
description      'Installs/Configures chef-server-blueprint'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "chef-server"

# Support everything the chef-server cookbook supports
%w{ ubuntu redhat centos fedora amazon scientific oracle }.each do |os|
  supports os
end

recipe "chef-server-blueprint::default", "Same as chef-server::default, but with inputs"

attribute "chef-server-blueprint/api_fqdn",
    :display_name => "Chef Server FQDN",
    :required => "required"

attribute "chef-server-blueprint/version",
          :display_name => "Chef Server Version",
          :required => "optional",
          :default => "latest"