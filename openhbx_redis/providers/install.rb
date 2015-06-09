def whyrun_supported?
  false
end

action :install do
  version = new_resource.version
  redis_pkg = "redis-" + version

  remote_file "#{Chef::Config[:file_cache_path]}/remi-release-6.rpm" do
    source "http://rpms.famillecollet.com/enterprise/remi-release-6.rpm"
    action :create
  end

  rpm_package "remi-release-6*.rpm" do
    source "#{Chef::Config[:file_cache_path]}/remi-release-6.rpm"
    action :install
  end  

  package redis_pkg do
    action :install
  end

  service "redis" do
    action [:enable, :start]
  end
end