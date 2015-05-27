def whyrun_supported?
  false
end

action :create do
  environments_path = ::File.join(new_resource.configuration_path, "environments")
  out_path = ::File.join(environments_path, "production.rb")

  directory environments_path do
    owner new_resource.file_user
    group new_resource.file_group
    mode "0750"
    action :create
  end

  template out_path do
    source new_resource.template_name
    owner new_resource.file_user
    group new_resource.file_group
    mode "0750"
  end
end
