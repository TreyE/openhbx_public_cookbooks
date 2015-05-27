actions :install
default_action :install
attribute :name, :kind_of => String, :name_attribute => true, :required => true
attribute :user, :kind_of => String, :required => true
attribute :versions, :kind_of => Array, :default => ["2.2.2"]
attribute :required_packages, :kind_of => Array, :required => true
