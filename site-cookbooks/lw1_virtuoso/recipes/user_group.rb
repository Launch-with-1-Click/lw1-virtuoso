group 'virtuoso' do
  action :create
  gid 501
end

user 'virtuoso' do
  action :create
  home '/opt/virtuoso-opensource'
  shell '/bin/false'
  system true
  uid 501
  gid 501
end
