FROM      	ubuntu:trusty
MAINTAINER 	Dominik Richter "dominik.richter@gmail.com"

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get update

# install puppet
RUN apt-get -y install puppet

# install puppet module (os_hardening, ssh_hardening) and there dependencies 
# to allow immediate use of the image without copy modules to /modules

RUN puppet module install hardening-ssh_hardening && puppet module install hardening-os_hardening

# add this folder
ADD . /hardening

# run puppet
RUN sh -c 'puppet apply -v -d --detailed-exitcodes /hardening/manifests/docker.pp; exit 0'

# simple command to get into the box
CMD /bin/bash

