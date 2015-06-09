def whyrun_supported?
  false
end

action :install do
  version = new_resource.version
  redis_pkg = "redis-" + version

  remote_file "/tmp/remi-release-6.rpm" do
    source "http://rpms.famillecollet.com/enterprise/remi-release-6.rpm"
    #not_if {::File.exists?("/opt/td-agent/usr/bin/td")}
    notifies :install, "rpm_package[remi]", :immediately
    retries 2 
  end

  package "jemalloc" do
    action :install
  end

  rpm_package "remi" do
    source "/tmp/remi-release-6.rpm"
    only_if {::File.exists?("/tmp/remi-release-6.rpm")}
    action :nothing  
  end  

  package redis_pkg do
    action :install
  end

  service "redis" do
    action [:enable, :start]
  end
end
