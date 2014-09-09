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
    rpm insall -g hubot coffee-script
  EOH
end

### redis
%(redis).each do |p|
  package p do
    options "--enablerepo=epel"
    action :install
  end
end

bash "redis server up" do
  user "root"
  group "root"
  code <<-EOH
    redis-server /etc/redis.conf &
  EOH
  not_if "ps ax | grep -q redis-server"
end

