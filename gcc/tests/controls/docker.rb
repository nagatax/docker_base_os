# encoding: utf-8

title 'docker section'

control 'docker' do
  impact 0.7
  title 'Install docker package'
  desc 'An optional description...'

  # docker
  docker_image('nagatax/gcc:latest') do
    it { should exist }
    its('repo') { should eq 'docker.io/nagatax/gcc' }
    its('tag') { should eq 'latest' }
  end

  describe docker_container(name: 'gcc') do
    it { should exist }
    it { should be_running }
    #its('id') { should_not eq '' }
    its('image') { should eq 'docker.io/nagatax/gcc' }
    its('repo') { should eq 'docker.io/nagatax/gcc' }
    its('tag') { should eq 'latest' }
    #its('ports') { should eq [] }
    its('command') { should eq '/bin/bash' }
  end

end
