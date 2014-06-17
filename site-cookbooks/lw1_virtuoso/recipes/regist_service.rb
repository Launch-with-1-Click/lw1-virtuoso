template '/etc/init.d/virtuoso' do
  action :create
  source 'init_virtuoso.erb'
  mode   '0755'
end

execute '/sbin/chkconfig --add virtuoso' do
  action :nothing
  subscribes :run, 'template[/etc/init.d/virtuoso]'
end

execute '/sbin/chkconfig virtuoso off' do
  action :nothing
  subscribes :run, 'template[/etc/init.d/virtuoso]'
end
