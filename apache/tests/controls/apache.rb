# encoding: utf-8

title 'apache section'

control 'apache' do
  impact 0.7
  title 'Check apache package'
  desc 'Check apache package'

  # バイナリファイルの存在確認
  describe file('/root/.bashrc') do
    it { should be_file  }
  end
  describe file('/usr/local/httpd') do
    it { should be_directory  }
  end
  describe file('/usr/local/httpd/bin/httpd') do
    it { should be_file  }
  end

  # バージョンの確認
  describe command('. ~/.bashrc && httpd -v') do
    its(:stdout) { should match /#{ENV['PACKAGE_VERSION']}/ }
  end
end
