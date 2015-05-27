def whyrun_supported?
  false
end

action :install do
  user_name = new_resource.user
  ruby_list = new_resource.versions
  needed_packages = new_resource.required_packages

  needed_packages.each do |np|
    pkg = np.to_s
    package pkg do
      action :install
    end
  end

  execute "execute clone of rbenv repository" do
    command "su #{user_name} -c \"/bin/bash -l -c 'git clone https://github.com/sstephenson/rbenv.git ~/.rbenv'\""
    not_if {::File.exists?("/home/#{user_name}/.rbenv") }
  end

  directory "/home/#{user_name}/.rbenv/plugins" do
    owner user_name
    group user_name
    mode "0770"    
    action :create
  end

  execute "execute clone of ruby_build repository" do
    command "su #{user_name} -c \"/bin/bash -l -c 'git clone https://github.com/sstephenson/ruby-build.git  ~/.rbenv/plugins/'\""
    not_if {::File.exists?("/home/#{user_name}/.rbenv/plugins/ruby-build") }
  end

  ruby_block "add rbenv to path and shell" do
    block do
      fe = Chef::Util::FileEdit.new("/home/#{user_name}/.bashrc")
      fe.insert_line_if_no_match(/rbenv init -/, <<-BASHCODE)
# User specific aliases and functions
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"
      BASHCODE
      fe.write_file
    end
  end

  ruby_list.each do |version|
    ver = version.to_s
    execute "install ruby #{ver}" do
      command "su #{user_name} -c \"/bin/bash -l -c 'rbenv install #{ver}'\""
      not_if {::File.exists?("/home/#{user_name}/.rbenv/versions/#{ver}")}
    end

    execute "install bundler for #{ver}" do
      command "su #{user_name} -c \"/bin/bash -l -c 'rbenv rehash && rbenv shell #{ver} && gem install bundler && rbenv rehash'\""
    end
  end
end
