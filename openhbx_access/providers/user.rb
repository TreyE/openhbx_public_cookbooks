def whyrun_supported?
    false
end

action :grant_access do
  user_name = new_resource.user_name
  ssh_keys = new_resource.ssh_keys
  other_groups = new_resource.other_groups
  provider_name = new_resource.provider

  if node['etc']['passwd'][user_name].nil?
    Chef::Log.debug "User #{user_name} not found in /etc/passwd, skipping :grant_access"
  else
    if other_groups.any?
      other_groups.each do |g_name|
        group g_name do
          action :modify
          members user_name
          append true
          provider provider_name
        end
      end
    end

    unless ssh_keys.empty?
      directory "/home/#{user_name}/.ssh" do
        user user_name
        group user_name
        mode "0700"
        action :create
      end  
      file "/home/#{user_name}/.ssh/authorized_keys" do
        user user_name
        group user_name
        mode "0600"
        action :create_if_missing
      end

      ssh_keys.each_pair do |key_name, public_key_base64|
        ruby_block "add rbenv to path and shell" do
          block do
            fe = Chef::Util::FileEdit.new("/home/#{user_name}/.ssh/authorized_keys")
            fe.insert_line_if_no_match(key_name, <<-SSHKEYLINE)
            #{public_key_base64} #{key_name}
            SSHKEYLINE
            fe.write_file
          end
        end
      end
    end
  end
end
