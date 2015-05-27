actions :create
default_action :create
attribute :configuration_path, :kind_of => String, :name_attribute => true, :required => true
attribute :devise_secret_key, :kind_of => String, :required => true
attribute :file_user, :kind_of => String, :default => "nginx"
attribute :file_group, :kind_of => String, :default => "nginx"
