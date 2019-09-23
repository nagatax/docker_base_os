require 'spec_helper'

set :backend, :docker
set :docker_image, ENV['DOCKER_USER'] + "/base_os:centos_7"

# バイナリファイルの存在確認
describe file('/root/.bashrc') do
  it { should be_file  }
end

# OSのバージョン確認
# describe command('cat /etc/redhat-release') do
#   its(:stdout) { should match /CentOS Linux release 7.7.1908 (Core)/ }
# end
