def whyrun_supported?
  false
end

action :install do
  version = new_resource.version
  redis_pkg = "redis-" + version

  package "jemalloc" do
    action :install
  end

  execute 'get-redis' do
    command '/usr/bin/curl --insecure -O https://dhsdcassvnsrv01.dhs.dc.gov:9395/drivers/redis-2.8.19-1.el6.remi.x86_64.rpm -o /tmp/redis-2.8.19-1.el6.remi.x86_64.rpm'
    action :nothing
  end

  package "redis" do
    source "/tmp/redis-2.8.19-1.el6.remi.x86_64.rpm"
    action :install
    provider Chef::Provider::Package::Rpm
  end  

  service "redis" do
    action [:enable, :start]
  end
end
