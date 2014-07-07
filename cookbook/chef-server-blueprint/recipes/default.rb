#
# Cookbook Name:: chef-server-blueprint
# Recipe:: default
#
# Copyright 2014, Ryan J. Geyer <me@ryangeyer.com>
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

node["chef-server"]["api_fqdn"] = node["chef-server-blueprint"]["api_fqdn"]
node["chef-server"]["version"] = node["chef-server-blueprint"]["version"]

if node['chef-server-blueprint']['remote_file'].nil? || node['chef-server-blueprint']['remote_file'].empty?
  log "*** Input node['chef-server-blueprint']['remote_file'] is undefined, not setting node['chef-server']['package_file']"
else
  filename=""
  if (node['chef-server-blueprint']['remote_file'] =~ /.+\/(.+)$/)
    filename=$1
  else
    throw "*** node['chef-server-blueprint']['remote_file'] with value #{node['chef-server-blueprint']['remote_file']} is not a valid URL, aborting..."
  end
  
  log "*** Downloading #{node['chef-server-blueprint']['remote_file']} to /root/#{filename}"

  remote_file "/root/#{filename}" do
    source "#{node['chef-server-blueprint']['remote_file']}"
    action :create_if_missing
  end
  
  log "*** Setting node['chef-server']['package_file'] to /root/#{filename}"
  node['chef-server']['package_file']="/root/#{filename}"
end
  
log "*** Including recipe chef-server::default"
include_recipe "chef-server::default"

log "*** Adding Paths to system"

cookbook_file "/etc/profile.d/chef-server.sh" do
  source "chef-server-profile.sh"
  owner "root"
  group "root"
  mode 0777
  action :create
end

rightscale_marker :end
