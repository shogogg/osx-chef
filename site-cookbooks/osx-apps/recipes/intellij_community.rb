dmg_package node[:intellij_community][:package_name] do
  source   node[:intellij_community][:source]
  checksum node[:intellij_community][:checksum]
  owner    node[:current_user]
  action   :install
end
