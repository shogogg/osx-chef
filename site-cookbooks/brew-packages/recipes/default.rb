node[:brew_packages].each do |pkg|
  package pkg do
    provider Chef::Provider::Package::Homebrew
    action   :install
  end
end
