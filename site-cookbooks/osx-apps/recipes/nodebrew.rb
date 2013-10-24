nodebrew_path = ::File.expand_path('~/.nodebrew')

bash "install nodebrew" do
  code   "curl -L git.io/nodebrew | perl - setup"
  not_if { ::File.directory?(nodebrew_path) }
end

bash "update nodebrew" do
  code "nodebrew selfupdate"
end

node[:node_versions].each do |node_version|
  bash "install node #{node_version}" do
    code <<-EOH
      nodebrew install-binary #{node_version}
      nodebrew use #{node_version}
    EOH
    not_if { ::File.directory?(::File.join(nodebrew_path, 'node', node_version))}
  end
end
