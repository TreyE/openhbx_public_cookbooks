def whyrun_supported?
  false
end

action :install do
  config_path = new_resource.config_path
  configuration_owner = new_resource.configuration_owner

  config_file = ::File.join(config_path, "rabbitmq.config")
  def_file = ::File.join(config_path, "hbx_rabbit_definitions.json")

  package "rabbitmq-server" do
    action :install
    not_if { ::File.exists?(config_file) }
  end

  template config_file do
    cookbook "openhbx_rabbitmq"
    source "rabbitmq.config.erb"
    user configuration_owner
    group configuration_owner
    mode "0744"
    #variables({})
  end

  template def_file do
    cookbook "openhbx_rabbitmq"
    source "hbx_rabbit_definitions.json.erb"
    user configuration_owner
    group configuration_owner
    mode "0744"
    variables({
      :hbx_id => new_resource.hbx_id,
      :env_name => new_resource.env_name
    })
  end

  execute "enable rabbitmq_management plugin" do
    command "/usr/lib/rabbitmq/bin/rabbitmq-plugins enable rabbitmq_management"
    not_if { File.readlines("/etc/rabbitmq/enabled_plugins").grep(/rabbitmq_management/).any? }
  end

  service "rabbitmq-server" do
    action [:enable, :start]
  end

end
