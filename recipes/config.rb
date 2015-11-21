#
# Cookbook Name:: hubot-example
# Recipe:: config
#
# The MIT License (MIT)
#
# Copyright (c) 2015 Michael Lewis
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Setup the upstart file for hubot
template '/etc/init/hubot.conf' do
  variables({
    user: node['hubot-example']['owner'],
    group: node['hubot-example']['group'],
    adapter: node['hubot-example']['adapter'],
  })
end

# Any config information is exported in the hubot config file
# which will be sourced in the upstart file.
template "#{node['hubot-example']['dirs']['conf']}/config" do
  source 'hubot-conf.erb'
  owner node['hubot-example']['owner']
  group node['hubot-example']['group']
  mode '0644'
  variables({
    config: node['hubot-example']['config'],
  })
  notifies :restart, 'service[hubot]'
end
