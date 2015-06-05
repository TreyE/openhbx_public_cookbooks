actions :install
default_action :install
attribute :name, :kind_of => String, :name_attribute => true, :required => true
attribute :config_path, :kind_of => String, :default => "/etc"
attribute :log_path, :kind_of => String, :default => "/var/log/mongodb"
attribute :port, :kind_of => Integer, :default => 27017
attribute :db_path, :kind_of => String, :default => "/var/lib/mongo"
attribute :version, :kind_of => String, :default => "2.6"
attribute :pid_file_path, :kind_of => String, :default => "/var/run/mongodb"
attribute :repo_path, :kind_of => String, :default => "/etc/yum.repos.d"
attribute :configuration_owner, :kind_of => String, :default => "root"
