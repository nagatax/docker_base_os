# encoding: utf-8

title 'php section'

control 'php' do
  impact 0.7
  title 'Check php package'
  desc 'Check php package'

  # バイナリファイルの存在確認
  describe file('/root/.bashrc') do
    it { should be_file  }
  end
  describe file('/usr/local/php') do
    it { should be_directory  }
  end
  describe file('/usr/local/php/bin/php') do
    it { should be_file  }
  end

  # バージョンの確認
  describe command('. ~/.bashrc && php -v') do
    its(:stderr) { should match /7\.2\.14/   }
  end
end
