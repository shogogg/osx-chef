zip_package "Alfred 2" do
  source   node[:alfred2][:source]
  checksum node[:alfred2][:checksum]
  owner    node[:current_user]
end
