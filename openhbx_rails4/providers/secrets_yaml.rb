def whyrun_supported?
  false
end

action :create do
  out_path = ::File.join(new_resource.configuration_path, "secrets.yml")
  template out_path do
    cookbook "openhbx_rails4"
    source "secrets.yml.erb"
    owner new_resource.file_user
    group new_resource.file_group
    mode "0750"
    variables({
      :cookie_secret => new_resource.cookie_secret
    })
  end
end
