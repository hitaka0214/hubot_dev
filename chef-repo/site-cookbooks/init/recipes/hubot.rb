#
# Cookbook Name:: init
# Recip%e:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# https://www.zabbix.com/documentation/2.2/manual/installation/requirements

### hubot, coffee-script
bash "install hubt and coffee-script" do
  user "vagrant"
  group "vagrant"
  code <<-EOH
    sudo npm install -g hubot coffee-script
  EOH
end

### redis
%w(redis).each do |p|
  package p do
    options "--enablerepo=epel"
    action :install
    not_if "rpm -qa | grep -q #{p}"
  end
end

