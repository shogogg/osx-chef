dmg_package "SourceTree" do
  source   node[:sourcetree][:source]
  checksum node[:sourcetree][:checksum]
  owner    node[:current_user]
  action   :install
end
