def whyrun_supported?
  false
end

action :install do
  version = new_resource.version
  redis_pkg = "redis-" + version

  remote_file "/tmp/redis-2.8.rpm" do
    source "http://dhsdcassvnsrv01.dhs.dc.gov:9395/drivers/redis-2.8.19-1.el6.remi.x86_64.rpm"
    #not_if {::File.exists?("/opt/td-agent/usr/bin/td")}
    notifies :install, "rpm_package[redis-2.8]", :immediately
    retries 2 
  end

  package "jemalloc" do
    action :install
  end

  yum_package "redis-2.8" do
    source "/tmp/redis-2.8.rpm"
    only_if {::File.exists?("/tmp/redis-2.8.rpm")}
    action :nothing  
  end  

  service "redis" do
    action [:enable, :start]
  end
end
