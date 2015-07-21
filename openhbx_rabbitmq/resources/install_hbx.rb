actions :install
default_action :install
attribute :name, :kind_of => String, :name_attribute => true, :required => true
attribute :config_path, :kind_of => String, :default => "/etc/rabbitmq"
attribute :configuration_owner, :kind_of => String, :default => "root"
attribute :hbx_id, :kind_of => String, :default => "dc0"
attribute :env_name, :kind_of => String, :default => "test"
