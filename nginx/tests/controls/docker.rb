# encoding: utf-8

title 'docker section'

control 'docker' do
  impact 0.7
  title 'Check docker container'
  desc 'Check docker container'

  describe docker_container(name: 'sut') do
    it { should exist }
    it { should be_running }
    its('id')      { should_not eq '' }
    its('image')   { should eq ENV['IMAGE_NAME'] }
    its('repo')    { should eq ENV['DOCKER_REPO'] }
    its('tag')     { should eq ENV['CACHE_TAG'] }
    its('ports')   { should eq '80/tcp' }
    its('command') { should eq '/usr/local/nginx/sbin/nginx -g \'daemon off;\'' }
  end

end
