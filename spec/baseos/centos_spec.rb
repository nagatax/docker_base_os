require 'spec_helper'

set :backend, :docker
set :docker_image, 'nagatax/base_os:centos_7'

# バイナリファイルの存在確認
describe file('/root/.bashrc') do
  it { should be_file  }
end
