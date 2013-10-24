osx_defaults "set dock to be on #{node[:dock][:orientation]}" do
  domain  'com.apple.dock'
  key     'orientation'
  string  node[:dock][:orientation]
  only_if { node[:dock][:orientation] }
end

osx_defaults 'set dock to autohide' do
  domain  'com.apple.dock'
  key     'autohide'
  boolean node[:dock][:autohide]
  only_if { node[:dock].keys.include?('autohide') }
end

osx_defaults 'remove persistent apps from the dock' do
  domain  'com.apple.dock'
  key     'persistent-apps'
  array   []
  only_if { node[:dock][:clear_apps] }
end

osx_defaults "adjusts dock size to #{node[:dock][:tilesize]}" do
  domain  'com.apple.dock'
  key     'tilesize'
  integer node[:dock][:tilesize]
  only_if { node[:dock][:tilesize] }
end

execute 'relaunch dock' do
  command 'killall Dock'
  only_if { !node[:dock].empty? }
end
