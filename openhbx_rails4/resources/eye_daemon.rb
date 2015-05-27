actions :install
default_action :install
attribute :daemon_name, :kind_of => String, :name_attribute => true, :required => true
attribute :application_name, :kind_of => String, :required => true
attribute :run_as, :kind_of => String, :required => true
