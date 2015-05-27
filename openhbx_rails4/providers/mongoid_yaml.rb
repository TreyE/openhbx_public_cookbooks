def whyrun_supported?
  false
end

use_inline_resources

action :create do
  out_path = ::File.join(new_resource.configuration_path, "mongoid.yml")
  template out_path do
    cookbook "openhbx_rails4"
    source "mongoid.yml.erb"
    owner new_resource.file_user
    group new_resource.file_group
    mode "0750"
    variables({
      :username => new_resource.username,
      :password => new_resource.password,
      :uri => new_resource.uri,
      :database => new_resource.database
    })
  end
end
