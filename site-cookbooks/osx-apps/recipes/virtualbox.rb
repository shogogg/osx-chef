dmg_package "VirtualBox" do
  source     node[:virtualbox][:source]
  checksum   node[:virtualbox][:checksum]
  owner      node[:current_user]
  action     :install
  type       "pkg"
  package_id "org.virtualbox.pkg.virtualbox"
end
