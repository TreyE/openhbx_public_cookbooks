def whyrun_supported?
  false
end

action :install do
  version = new_resource.version
  db_path = new_resource.db_path
  config_path = new_resource.config_path
  log_path = new_resource.log_path
  pid_file_path = new_resource.pid_file_path
  port = new_resource.port
  repo_path = new_resource.repo_path
  configuration_owner = new_resource.configuration_owner

  config_file = ::File.join(config_path, "mongod.conf")
  repo_file = ::File.join(repo_path, "mongodb-org-" + version + ".repo")

  template repo_file do
    cookbook "openhbx_mongodb"
    source "mongodb-" + version + ".repo.erb"
    user configuration_owner
    group configuration_owner
    mode "0644"
  end

  package "mongodb-org" do
    action :install
    not_if { ::File.exists?(config_file) }
  end

  template config_file do
    cookbook "openhbx_mongodb"
    source "mongodb.conf.erb"
    user configuration_owner
    group configuration_owner
    mode "0754"
    variables({
      :log_path => log_path, 
      :db_path => db_path,
      :port => port,
      :pid_file_path => pid_file_path
    })
  end

  service "mongod" do
    action [:enable, :start]
  end
end
