directory '/opt/lw1/templates' do
  action :create
  recursive true
end

cookbook_file '/opt/lw1/templates/virtuoso.ini.erb' do
  action :create
  source 'templates/virtuoso.ini.erb'
end

template '/opt/lw1/initial.rb' do
  action :create
  source 'initial.rb.erb'
end

file '/etc/cron.d/first_boot' do
  action :create
  content '@reboot root /usr/bin/chef-apply /opt/lw1/initial.rb > /dev/null'
end
