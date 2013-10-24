dmg_package "LibreOffice" do
  source   node[:libreoffice][:source]
  checksum node[:libreoffice][:checksum]
  owner    node[:current_user]
  action   :install
end
