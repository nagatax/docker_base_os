# encoding: utf-8

title 'nginx section'

control 'nginx' do
  impact 0.7
  title 'Check nginx package'
  desc 'Check nginx package'

  # バイナリファイルの存在確認
  describe file('/root/.bashrc') do
    it { should be_file  }
  end
  describe file('/usr/local/nginx') do
    it { should be_directory  }
  end
  describe file('/usr/local/nginx/sbin/nginx') do
    it { should be_file  }
  end

  # バージョンの確認
  describe command('. ~/.bashrc && nginx -v') do
    its(:stderr) { should match /1\.19\.4/ }
  end

end
