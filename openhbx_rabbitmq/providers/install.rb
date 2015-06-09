def whyrun_supported?
  false
end

action :install do
  config_path = new_resource.config_path
  configuration_owner = new_resource.configuration_owner

  config_file = ::File.join(config_path, "rabbitmq.config")
  def_file = ::File.join(config_path, "definitions.json")

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
    source "definitions.json.erb"
    user configuration_owner
    group configuration_owner
    mode "0744"
    #variables({})
  end

  service "rabbitmq-server" do
    action [:enable, :start]
  end
end
