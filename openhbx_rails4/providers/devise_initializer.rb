def whyrun_supported?
  false
end

action :create do
  initializers_path = ::File.join(new_resource.configuration_path, "initializers")
  out_path = ::File.join(initializers_path, "devise.rb")

  directory initializers_path do
    owner new_resource.file_user
    group new_resource.file_group
    mode "0750"
    action :create
  end

  template out_path do
    cookbook "openhbx_rails4"
    source "devise_initializer.rb.erb"
    owner new_resource.file_user
    group new_resource.file_group
    mode "0750"
    variables({
      :devise_secret_key => new_resource.devise_secret_key
    })
  end
end
