actions :install
default_action :install
attribute :name, :kind_of => String, :name_attribute => true, :required => true
attribute :use_ssl, :kind_of => [TrueClass, FalseClass], :default => false
attribute :nginx_config_path, :kind_of => String, :default => "/etc/nginx"
attribute :ssl_key_file, :kind_of => String, :default => "nginx.key"
attribute :ssl_cert_file, :kind_of => String, :default => "nginx.crt"
attribute :ssl_private_key, :kind_of => String, :default => ""
attribute :ssl_certificate, :kind_of => String, :default => ""
attribute :unicorn_application_name, :kind_of => String, :required => true
attribute :worker_processes, :kind_of => Integer, :default => 5
attribute :worker_connections, :kind_of => Integer, :default => 10
attribute :keepalive_timeout, :kind_of => Integer, :default => 30
attribute :configuration_owner, :kind_of => String, :default => "root"
