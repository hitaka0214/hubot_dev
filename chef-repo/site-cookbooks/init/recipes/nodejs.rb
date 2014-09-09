#
# Cookbook Name:: init
# Recip%e:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# https://www.zabbix.com/documentation/2.2/manual/installation/requirements

### epel
remote_file "#{Chef::Config[:file_cache_path]}/epel-release-7-1.noarch.rpm" do
  source "http://ftp.riken.jp/Linux/fedora/epel/7/x86_64/e/epel-release-7-1.noarch.rpm"
  action :create
  not_if { ::File.exists?("#{Chef::Config[:file_cache_path]}/epel-release-7-1.noarch.rpm") }
end

rpm_package "epel-release-7-1.noarch.rpm" do
  source "#{Chef::Config[:file_cache_path]}/epel-release-7-1.noarch.rpm"
  action :install
  not_if "yum list installed | grep installed | grep -q epel-release"
end

%w(/etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel-testing.repo).each do |f|
  file f do
    content lazy {
      _repo = Chef::Util::FileEdit.new(f)
      _repo.search_file_replace(/^enabled\s*=\s*1/, 'enabled=0')
      _repo.send(:editor).lines.join
    }
  end
end

### nodejs
%w(
  nodejs
  npm
).each do |package|
  package package do
    options "--enablerepo=epel"
    action :install
  end
end
