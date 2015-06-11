#
# Cookbook Name:: openhbx_erlang
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file "/tmp/esl-erlang_17.5-1-centos-6_amd64.rpm" do
  source "http://packages.erlang-solutions.com/site/esl/esl-erlang/FLAVOUR_3_general/esl-erlang_17.5-1~centos~6_amd64.rpm"
  not_if { `which -s erl`.blank? }
  notifies :install, "rpm_package[install_erlang]", :immediately
  retries 2 # We may be redirected to a FTP
end

rpm_package "install_erlang" do
  action :nothing
  source "/tmp/esl-erlang_17.5-1-centos-6_amd64.rpm"
  only_if {::File.exists?("/tmp/esl-erlang_17.5-1-centos-6_amd64.rpm")}
end
