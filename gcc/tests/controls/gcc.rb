# encoding: utf-8

title 'gcc section'

#you add controls here
control 'gcc' do                            # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'Install gcc package'               # A human-readable title
  desc 'An optional description...'

  # バイナリファイルの存在確認
  describe file('/root/.bashrc') do
    it { should be_file  }
  end
  describe file('/usr/local/gcc') do
    it { should be_directory  }
  end
  describe file('/usr/local/gcc/bin/gcc') do
    it { should be_file  }
  end
  describe file('/usr/local/gcc/bin/g++') do
    it { should be_file  }
  end

  # バージョンの確認
  describe command('. ~/.bashrc && gcc -v') do
    its(:stderr) { should match /7\.4\.0/   }
  end
end
