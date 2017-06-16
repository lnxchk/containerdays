#
# Cookbook:: containerdays
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#
#

# fire up docker
docker_service 'default' do
  action [:create, :start]
end

# need docker-compose
remote_file '/usr/local/bin/docker-compose' do
  source 'https://github.com/docker/compose/releases/download/1.11.2/docker-compose-Linux-x86_64'
  mode '0755'
  action :create
end

cookbook_file '/home/vagrant/mongo-compose.yml' do
  content 'mongo-compose.yml'
  owner 'vagrant'
  group 'vagrant'
end

group 'docker' do
  append true
  members ['vagrant']
  action :modify
end

# get some habitat
hab_install 'install habitat'

user 'hab'

# install the runners for the demo bits
cookbook_file '/home/vagrant/0-ponyserve.sh' do
  content '0-ponyserve.sh'
  owner 'vagrant'
  group 'vagrant'
  mode 0775
end

cookbook_file '/home/vagrant/1-mongo-docker.sh' do
  content '1-mongo-docker.sh'
  owner 'vagrant'
  group 'vagrant'
  mode 0775
end

cookbook_file '/home/vagrant/2-mongo-run.sh' do
  content '2-mongo-run.sh'
  owner 'vagrant'
  group 'vagrant'
  mode 0775
end

cookbook_file '/home/vagrant/3-natparks-run.sh' do
  content '3-natparks-run.sh'
  owner 'vagrant'
  group 'vagrant'
  mode 0775
end

