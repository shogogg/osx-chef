dmg_package "Google Chrome" do
  source   node[:chrome][:source]
  dmg_name node[:chrome][:dmg_name]
  checksum node[:chrome][:checksum]
  owner    node[:current_user]
  action   :install
end
