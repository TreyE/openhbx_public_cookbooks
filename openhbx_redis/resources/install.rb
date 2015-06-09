actions :install
default_action :install
attribute :name, :kind_of => String, :name_attribute => true, :required => true
attribute :version, :kind_of => String, :default => "2.8"
attribute :configuration_owner, :kind_of => String, :default => "root"
