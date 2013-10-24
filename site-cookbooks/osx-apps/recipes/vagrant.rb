dmg_package "Vagrant" do
  source     node[:vagrant][:source]
  checksum   node[:vagrant][:checksum]
  owner      node[:current_user]
  action     :install
  type       "pkg"
  package_id "com.vagrant.vagrant"
end
