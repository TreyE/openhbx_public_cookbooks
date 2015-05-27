actions :install
default_action :install
attribute :name, :kind_of => String, :name_attribute => true, :required => true
attribute :use_ssl, :kind_of => [true, false], :default => false
attribute :unicorn_application_name, :type => String, :required => true
attribute :worker_processes, :type => Integer, :default => 5
attribute :worker_connections, :type => Integer, :default => 10
attribute :keepalive_timeout, :type => Integer, :default => 30
