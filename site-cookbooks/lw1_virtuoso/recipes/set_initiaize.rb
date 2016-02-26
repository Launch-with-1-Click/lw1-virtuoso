directory '/opt/lw1/templates' do
  action :create
  recursive true
end

directory '/opt/lw1/files' do
  action :create
  recursive true
end

directory '/opt/lw1/tasks' do
  action :create
  recursive true
end

directory '/opt/lw1/www' do
  action :create
  owner "apache"
  group "apache"
  recursive true
end

cookbook_file '/opt/lw1/templates/virtuoso.ini.erb' do
  action :create
  source 'templates/virtuoso.ini.erb'
end

cookbook_file "/opt/lw1/tasks/install_amiage.php.erb" do
  source "lw1_tasks/install_amiage.php.erb"
end

remote_file "/opt/virtuoso-opensource/share/virtuoso/vad/cartridges_dav.vad" do
  source "http://opldownload.s3.amazonaws.com/uda/vad-packages/7.2/cartridges_dav.vad"
  checksum "9e18d7bcb7bada8e36a929050d4b3ae0bcf46a0300beade2e7462e1eae931ad0"
  owner "virtuoso"
  group "virtuoso"
end

file "/opt/lw1/files/isql_cartridges_dav" do
  content <<-EOL
  vad_install('/opt/virtuoso-opensource/share/virtuoso/vad/cartridges_dav.vad');
  EOL
end

template '/opt/lw1/initial.rb' do
  action :create
  source 'initial.rb.erb'
end

cookbook_file '/etc/cron.d/first_boot' do
  action :create
  source 'first_boot'
end
