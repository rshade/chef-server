#
# Cookbook Name:: chef-server-blueprint
#

rightscale_marker :begin

file "/etc/cron.hourly/chef_server_backup" do
  content %Q(
#!/bin/sh
rs_run_recipe --name ' chef-server-blueprint::chef-ros-backup' 2>&1 >> /var/log/rs_backup.log
exit 0
  )
  mode 00700
end

rightscale_marker :end
