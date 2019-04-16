# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to you under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# -*- mode: ruby -*-
# vi: set ft=ruby :

tlp="jmeter"

Vagrant.configure("2") do |config|
  ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'
  config.vm.define "svn" do |vm|
    vm.vm.provider "docker" do |d|
      d.image = "elleflorio/svn-server"
      d.name = "svn-server"
      d.ports = ['80:80', '3960:3960']
    end
    vm.trigger.after :up, info: 'Register <<test>> SVN user',
        run: {inline: "vagrant docker-exec svn -- htpasswd -b /etc/subversion/passwd test test"}
    vm.trigger.after :up, info: 'Creating <<dist>> repository',
        on_error: :continue,
        run: {inline: "vagrant docker-exec svn -- svnadmin create /home/svn/dist"}
    vm.trigger.after :up, info: 'Changing ownerwship of <<dist>> to apache:apache',
        run: {inline: "vagrant docker-exec svn -- chown -R apache:apache /home/svn/dist"}
    vm.trigger.after :up, info: 'Creating dist folders',
        on_error: :continue,
        run: {inline: "vagrant docker-exec svn -- svnmucc -m 'Init' --root-url file:///home/svn/dist mkdir dev mkdir dev/#{tlp} mkdir release mkdir release/#{tlp}"}
  end
end
