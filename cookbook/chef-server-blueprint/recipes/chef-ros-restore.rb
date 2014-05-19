#
# Cookbook Name:: chef-server-blueprint
#
# Restore chef server from Remote Object Storage(ex: AWS S3, RackSpace CloudFiles, etc)

rightscale_marker :begin

log "*** in recipe: chef-server-blueprint::chef-ros-restore"

raise "*** ROS gem missing, please add rightscale::install_tools recipes to runlist." unless File.exists?("/opt/rightscale/sandbox/bin/ros_util")

if (("#{node[:chef-server-blueprint][:backup][:storage_account_id]}" == "") ||
    ("#{node[:chef-server-blueprint][:backup][:storage_account_secret]}" == "") ||
    ("#{node[:chef-server-blueprint][:backup][:container]}" == "") ||
    ("#{node[:chef-server-blueprint][:backup][:lineage]}" == ""))
  raise "*** Attributes chef-server-blueprint/backup/storage_account_id, storage_account_secret, container and lineage are required by chef-server-blueprint::chef-ros-backup. Aborting"
end

container = node[:chef-server-blueprint][:backup][:container]
cloud = node[:chef-server-blueprint][:backup][:storage_account_provider]

# Overrides default endpoint or for generic storage clouds such as Swift.
# Is set as ENV['STORAGE_OPTIONS'] for ros_util.
require 'json'

options =
  if node[:chef-server-blueprint][:backup][:storage_account_endpoint].to_s.empty?
    {}
  else
    {'STORAGE_OPTIONS' => JSON.dump({
      :endpoint => node[:chef-server-blueprint][:backup][:storage_account_endpoint],
      :cloud => node[:chef-server-blueprint][:backup][:storage_account_provider].to_sym
    })}
  end

environment_variables = {
  'STORAGE_ACCOUNT_ID' => node[:chef-server-blueprint][:backup][:storage_account_id],
  'STORAGE_ACCOUNT_SECRET' => node[:chef-server-blueprint][:backup][:storage_account_secret]
}.merge(options)

backup_script = ::File.join(::File.dirname(__FILE__), "..", "files", "default", "chef-backup.sh")

rightscale_marker :end
