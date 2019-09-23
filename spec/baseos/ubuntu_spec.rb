require 'spec_helper'

set :backend, :docker
set :docker_image, ENV['DOCKER_USER'] + "/base_os:ubuntu_bionic"

# バイナリファイルの存在確認
describe file('/root/.bashrc') do
  it { should be_file  }
end

# OSのバージョン確認
describe command('cat /etc/os-release') do
  its(:stdout) { should match /Ubuntu 18.04/ }
end
