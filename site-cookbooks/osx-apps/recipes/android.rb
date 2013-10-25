remote_file "#{Chef::Config[:file_cache_path]}/android-sdk-macosx.zip" do
  source   node[:android][:source]
  checksum node[:android][:checksum]
end

execute "unzip android-sdk-macosx.zip" do
  command "unzip '#{Chef::Config[:file_cache_path]}/android-sdk-macosx.zip'"
  cwd     node[:android][:prefix]
  not_if  { ::File.directory?(::File.join(node[:android][:prefix], 'android-sdk-macosx')) }
end
