def whyrun_supported?
  false
end

action :install do
  config_path = new_resource.config_path
  configuration_owner = new_resource.configuration_owner

  config_file = ::File.join(config_path, "rabbitmq.config")
  def_file = ::File.join(config_path, "local_rabbit_definitions.json")

  package "rabbitmq-server" do
    action :install
    not_if { ::File.exists?(config_file) }
  end

  template config_file do
    cookbook "openhbx_rabbitmq"
    source "rabbitmq.config.local.erb"
    user configuration_owner
    group configuration_owner
    mode "0744"
    #variables({})
  end

  template def_file do
    cookbook "openhbx_rabbitmq"
    source "local_rabbit_definitions.json.erb"
    user configuration_owner
    group configuration_owner
    mode "0744"
    variables({
      :hbx_id => new_resource.hbx_id,
      :env_name => new_resource.env_name
      :remote_broker_user => new_resource.remote_broker_user,
      :remote_broker_pw => new_resource.remote_broker_pw,
      :remote_broker_host => new_resource.remote_broker_host
    })
  end

  execute "enable rabbitmq_management plugin" do
    command "/usr/lib/rabbitmq/bin/rabbitmq-plugins enable rabbitmq_management"
    not_if { ::File.exists?("/etc/rabbitmq/enabled_plugins") && ::File.readlines("/etc/rabbitmq/enabled_plugins").grep(/rabbitmq_management/).any? }
  end

  execute "enable rabbitmq_shovel plugin" do
    command "/usr/lib/rabbitmq/bin/rabbitmq-plugins enable rabbitmq_shovel"
    not_if { ::File.exists?("/etc/rabbitmq/enabled_plugins") && ::File.readlines("/etc/rabbitmq/enabled_plugins").grep(/rabbitmq_shovel/).any? }
  end

  service "rabbitmq-server" do
    action [:enable, :start]
  end

end
