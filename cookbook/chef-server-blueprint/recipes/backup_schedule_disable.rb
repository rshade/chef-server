#
# Cookbook Name:: chef-server-blueprint
#

rightscale_marker :begin

file "/etc/cron.hourly/chef_server_backup" do
  action :delete
end

rightscale_marker :end
