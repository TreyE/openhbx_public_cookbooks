#
# Cookbook Name:: openhbx_erlang
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

["wxGTK", "wxGTK-devel", "unixODBC", "unixODBC-devel"].each do |pkg_name|
  package pkg_name do
    action :install
  end
end

remote_file "/tmp/esl-erlang_17.5-1-centos-6_amd64.rpm" do
  source "http://packages.erlang-solutions.com/site/esl/esl-erlang/FLAVOUR_3_general/esl-erlang_17.5-1~centos~6_amd64.rpm"
  not_if 'which erl'
  retries 2 # We may be redirected to a FTP
end

rpm_package "install_erlang" do
  action :install
  source "/tmp/esl-erlang_17.5-1-centos-6_amd64.rpm"
  not_if 'which erl'
end
