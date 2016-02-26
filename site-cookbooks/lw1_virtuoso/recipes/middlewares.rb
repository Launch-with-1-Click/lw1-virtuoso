template "/etc/yum.repos.d/amimoto-nginx-mainline.repo" do
  source "yum/amimoto-nginx-mainline.repo.erb"
  owner "root"
  group "root"
  mode  "0644"
end

package 'nginx'
package 'php56-fpm'

template '/etc/nginx/nginx.conf' do
  action :create
  source 'nginx.conf.erb'
end


service 'rpcbind' do
  action [:stop, :disable]
end

service 'sendmail' do
  action [:stop, :disable]
end

package 'postfix'

ruby_block "postfix main.cf" do
  block do
    _file = Chef::Util::FileEdit.new('/etc/postfix/main.cf')
    _file.search_file_replace_line(/^#local_recipient_maps =$/, "local_recipient_maps =")
    _file.write_file
  end
end
