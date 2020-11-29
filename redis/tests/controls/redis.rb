# encoding: utf-8

title 'redis section'

control 'redis' do
  impact 0.7
  title 'Check redis package'
  desc 'Check redis package'

  # バイナリファイルの存在確認
  describe file('/root/.bashrc') do
    it { should be_file  }
  end
  describe file('/usr/local/redis') do
    it { should be_directory  }
  end
  describe file('/usr/local/redis/bin/redis-server') do
    it { should be_file  }
  end
  describe file('/usr/local/redis/bin/redis-cli') do
    it { should be_file  }
  end

  # バージョンの確認
  describe command('. ~/.bashrc && redis-server -v') do
    its(:stdout) { should match /6\.0\.9/ }
  end

  # 動作確認
  describe command('. ~/.bashrc && redis-cli -h localhost ping') do
    its(:stdout) { should match /PONG/ }
  end
  describe command('. ~/.bashrc && redis-cli -h localhost set foo bar') do
    its(:stdout) { should match /OK/ }
  end
  describe command('. ~/.bashrc && redis-cli -h localhost get foo') do
    its(:stdout) { should match /bar/ }
  end
end
