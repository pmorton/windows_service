#
# Author:: Paul Morton (<pmorton@biaprotect.com>)
# Cookbook Name:: windows_service
# Resource:: manage
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

actions :create, :delete, :configure

attribute :service_name, :kind_of => String, :name_attribute => true
attribute :display_name, :kind_of => String, :default => nil
attribute :desired_access, :default => nil
attribute :service_type, :default => nil
attribute :start_type, :default => nil
attribute :error_control, nil
attribute :binary_path_name, :default => nil
attribute :service_start_name, :default => nil
attribute :password, :default => nil
attribute :description, :default => nil
attribute :fail_exist_check, :default => true