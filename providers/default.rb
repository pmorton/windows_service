#
# Author:: Paul Morton (<pmorton@biaprotect.com>)
# Cookbook Name:: windows_service
# Provider:: default
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

require 'timeout'

action :start do
  service_info = Win32::Service.status(new_resource.service_name)
  if(service_info.current_state != 'running')
    Win32::Service.start(new_resource.service_name)
    wait_for_status('running' )
  else
    Chef::Log.info("Service already started (#{new_resource.service_name})")
  end


end

action :stop do
  service_info = Win32::Service.status(new_resource.service_name)
  if(service_info.current_state != 'stopped')
    Win32::Service.stop(new_resource.service_name)
    wait_for_status('stopped')
  else
    Chef::Log.info("Service already stopped (#{new_resource.service_name})")
  end

end


action :restart do
  action_stop
  action_start
end

private
def wait_for_status(status_name)
  Timeout.timeout(new_resource.timeout) do
    while Win32::Service.status(new_resource.service_name).current_state != status_name
      Chef::Log.debug("Waiting for #{new_resource.service_name} to be #{status_name}, current state #{ Win32::Service.status(new_resource.service_name).current_state}")
      sleep(1)
    end
  end
end
