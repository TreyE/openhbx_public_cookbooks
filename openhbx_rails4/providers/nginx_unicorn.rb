def whyrun_supported?
  false
end

action :install do
  use_ssl = new_resource.use_ssl
  unicorn_app_name = new_resource.unicorn_application_name
end
