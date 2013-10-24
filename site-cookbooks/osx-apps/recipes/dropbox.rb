dmg_package 'Dropbox' do
  volumes_dir 'Dropbox Installer'
  source      'https://www.dropbox.com/download?plat=mac'
  owner       node[:current_user]
  action      :install
end
