# encoding: utf-8

title 'docker section'

control 'docker' do
  impact 0.7
  title 'Install docker package'
  desc 'An optional description...'

  # docker
  describe docker_image(ENV['IMAGE_NAME'].gsub(/index\./, "")) do
    it { should exist }
    its('repo') { should eq ENV['DOCKER_REPO'] }
    its('tag')  { should eq nil }
  end

  describe docker_container(name: 'sut') do
    it { should exist }
    it { should be_running }
    its('id')     { should_not eq '' }
    its('image')   { should eq ENV['DOCKER_REPO'].gsub(/index\./, "") }
    its('repo')    { should eq ENV['DOCKER_REPO'].gsub(/index\./, "") }
    its('tag')     { should eq nil }
    its('ports')  { should eq [] }
    its('command') { should eq '/bin/bash' }
  end

end
