def whyrun_supported?
  false
end

action :install do
  use_ssl = new_resource.use_ssl
  unicorn_app_name = new_resource.unicorn_application_name
  worker_processes = new_resource.worker_processes
  worker_connections = new_resource.worker_connections
  keepalive_timeout = new_resource.keepalive_timeout
  configuration_owner = new_resource.configuration_owner

  nginx_config_path = new_resource.nginx_config_path
  config_file_path = ::File.join(nginx_config_path, "nginx.conf")

  package :nginx do
    action :install
    not_if { ::File.exists?(config_file_path) }
  end

  if use_ssl
    ssl_key_file = new_resource.ssl_key_file
    ssl_cert_file = new_resource.ssl_cert_file
    ssl_directory = ::File.join(nginx_config_path, "ssl")
    ssl_key_path = ::File.join(ssl_directory, ssl_key_file)
    ssl_cert_path = ::File.join(ssl_directory, ssl_cert_file)
    private_key = new_resource.ssl_private_key
    certificate = new_resource.ssl_certificate

    directory ssl_directory do
      owner configuration_owner
      group configuration_owner
      mode "0755"
      action :create
    end

    file ssl_key_path do
      owner configuration_owner
      group configuration_owner
      mode "0400"
      action :create
      content private_key
    end

    file ssl_cert_path do
      owner configuration_owner
      group configuration_owner
      mode "0644"
      action :create
      content certificate
    end

    template config_file_path do
      cookbook "openhbx_rails4"
      source "nginx.conf.erb"
      user configuration_owner
      group configuration_owner
      mode "0754"
      variables({
        :use_ssl => true,
        :ssl_key_path => ssl_key_path,
        :ssl_certificate_path => ssl_cert_path,
        :unicorn_application_name => unicorn_app_name,
        :worker_connections => worker_connections,
        :worker_processes => worker_processes,
        :keepalive_timeout => keepalive_timeout
      })
    end
  else
    template config_file_path do
      cookbook "openhbx_rails4"
      source "nginx.conf.erb"
      user configuration_owner
      group configuration_owner
      mode "0754"
      variables({
        :use_ssl => false,
        :unicorn_application_name => unicorn_app_name,
        :worker_connections => worker_connections,
        :worker_processes => worker_processes,
        :keepalive_timeout => keepalive_timeout
      })
    end
  end

  service "nginx" do
    action [:enable, :start]
  end
end
