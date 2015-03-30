#
# Author:: Shawn Neal <sneal@daptiv.com>
# Cookbook Name:: visualstudio
# Recipe:: nuget
#
# Copyright 2013, Daptiv Solutions, LLC.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

vsix_installer_exe = win_friendly_path(
  File.join(node['visualstudio']['install_dir'], 'Common7\IDE\VSIXInstaller.exe'))
nuget_vsix = win_friendly_path(
  File.join(Chef::Config[:file_cache_path], 'NuGet.Tools.vsix'))

remote_file 'nuget_client' do
  path nuget_vsix
  source node['visualstudio']['nuget']['package_src_url']
  checksum node['visualstudio']['nuget']['checksum']
  notifies :run, 'execute[nuget_client_install]'
end

execute 'nuget_client_install' do
  command "#{vsix_installer_exe} /q #{nuget_vsix}"
  action :nothing
end
