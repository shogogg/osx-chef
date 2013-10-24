zip_package "iTerm" do
  source   node[:iterm2][:source]
  checksum node[:iterm2][:checksum]
  owner    node[:current_user]
end
