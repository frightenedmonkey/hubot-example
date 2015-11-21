#
# Cookbook Name:: hubot-example
# Recipe:: setup
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

# Ensure node is setup & installed
# Setting the attributes for the nodejs cookbook here rather than in the local
# attributes file since it's more obvious this way.

node.default['nodejs']['install_method'] = 'source'
node.default['nodejs']['version'] = '4.2.2'

include_recipe 'nodejs'

# redis-brain automatically looks for a redis instance on localhost on the
# redis default port of 6379
package 'redis-server' if node['hubot-example']['brain']

# Take care of the user/group business
user node['hubot-example']['owner'] do
  action :create
  system true
end

group node['hubot-example']['group'] do
  action :create
  system true
end

node['hubot-example']['dirs'].each_value do |dir|
  directory dir do
    owner node['hubot-example']['owner']
    group node['hubot-example']['group']
    mode '0755'
  end
end
