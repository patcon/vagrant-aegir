#
# Cookbook Name:: aegir
# Recipe:: source
#
# Copyright 2011, Patrick Connolly (Myplanet Digital)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

include_recipe "apt"
include_recipe "apache2"
include_recipe "php"
include_recipe "php::module_gd"
include_recipe "php::module_mysql"
include_recipe "postfix"
include_recipe "sudo"
include_recipe "rsync"
include_recipe "git"

package "unzip" do
  action :install
end

include_recipe "apache2::mod_rewrite"

include_recipe "hosts"
host_entry "localhost" do
  ip "127.0.0.1"
  aliases "localhost.localdomain"
end

host_entry node[:hostname] do
  ip node[:ipaddress]
end

include_recipe "mysql::server"
node.default["mysql"]["bind_address"] = nil

link "/var/aegir/config/apache.conf" do
  to "#{node['apache']['dir']}/conf.d/aegir.conf"
end
