def whyrun_supported?
  false
end

action :install do
  d_name = new_resource.daemon_name
  app_name = new_resource.application_name
  user_name = new_resource.run_as

  out_path = ::File.join("/etc/init.d", d_name)
  template out_path do
    cookbook "openhbx_rails4"
    source "eye_daemon.erb"
    group "root"
    mode "0755"
    variables({
      :service_name => d_name,
      :user_name => user_name,
      :unicorn_application_name => app_name
    })
  end

  service d_name do
      action [:enable]
  end
end
