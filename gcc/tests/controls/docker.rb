# encoding: utf-8

title 'docker section'

control 'docker' do
  impact 0.7
  title 'Install docker package'
  desc 'An optional description...'

  # docker
  docker_image('nagatax/gcc:develop') do
    it { should exist }
    its('repo') { should eq 'nagatax/gcc' }
    its('tag')  { should eq 'develop' }
  end

  describe docker_container(name: 'gcc') do
    it { should exist }
    it { should be_running }
    #its('id')     { should_not eq '' }
    its('image')   { should eq 'nagatax/gcc' }
    its('repo')    { should eq 'nagatax/gcc' }
    its('tag')     { should eq 'develop' }
    #its('ports')  { should eq [] }
    its('command') { should eq '/bin/bash' }
  end

end
