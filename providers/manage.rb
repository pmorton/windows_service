#
# Author:: Paul Morton (<pmorton@biaprotect.com>)
# Cookbook Name:: windows_service
# Provider:: manage
#
# Copyright:: 2011, Business Intelligence Associates, Inc
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

action :create do
  if new_resource.binary_path_name.nil?
    raise Chef::Exceptions::Service, "Ergh... You must provide a binary_path for the service (#{new_resource.service_name})"
  end

  service_options = {
      :service_name         => new_resource.service_name,
      :display_name         => new_resource.display_name,
      :desired_access       => new_resource.desired_access || Win32::Service::ALL_ACCESS ,
      :service_type         => new_resource.service_type ||  Win32::Service::WIN32_OWN_PROCESS ,
      :start_type           => new_resource.start_type ||  Win32::Service::AUTO_START ,
      :error_control        => new_resource.error_control || Win32::Service::ERROR_NORMAL ,
      :binary_path_name     => new_resource.binary_path_name,
      :service_start_name   => new_resource.service_start_name,
      :password             => new_resource.password,
      :description          => new_resource.description
  }
  if Win32::Service.exists?(new_resource.service_name) && new_resource.fail_exist_check

    raise Chef::Exceptions::Service, "This service already exists (#{new_resource.service_name})"

  elsif Win32::Service.exists?(new_resource.service_name)
    Chef::Log.info("Service not created because it already exists (#{new_resource.service_name})")
  else
    Win32::Service.new(service_options)
    Chef::Log.info("Service created (#{new_resource.service_name})")
  end


end

action :configure do

  raise Chef::Exceptions::Service, "You cannot set the service name of an existing service" unless new_resource.desired_access.nil?

  service_options = {}
  service_options[:service_name] = new_resource.service_name
  service_options[:service_type] = new_resource.service_type if new_resource.service_type
  service_options[:error_control] = new_resource.error_control if new_resource.error_control
  service_options[:binary_path_name] = new_resource.binary_path_name if new_resource.binary_path_name
  service_options[:service_start_name] = new_resource.service_start_name if new_resource.service_start_name
  service_options[:password] = new_resouce.password if new_resource.password
  service_options[:display_name] = new_resource.display_name if new_resource.display_name
  service_options[:description] = new_resource.description if new_resource.description


  if Win32::Service.exists?(new_resource.service_name)
    Win32::Service.configure(service_options)
  else
    raise Chef::Exceptions::Service, "This does not exists (#{new_resource.service_name})"
  end


end

action :delete do
  if Win32::Service.exists?(new_resource.service_name).eql? false && new_resource.fail_exist_check

    raise Chef::Exceptions::Service, "This service does not exists (#{new_resource.service_name})"

  elsif Win32::Service.exists?(new_resource.service_name).eql? false
    Chef::Log.info("Service not deleted because it does not exists (#{new_resource.service_name})")
  else
    Win32::Service.delete(new_resource.service_name)
    Chef::Log.info("Service deleted (#{new_resource.service_name})")
  end

end

