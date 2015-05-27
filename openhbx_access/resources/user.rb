actions :grant_access
default_action :grant_access
attribute :user_name, :kind_of => String, :name_attribute => true, :required => true
attribute :other_groups, :kind_of => Array, :default => []
attribute :ssh_keys, :kind_of => Hash, :default => {}
attribute :provider, :kind_of => String, :default => "Chef::Provider::Group::Gpasswd"
