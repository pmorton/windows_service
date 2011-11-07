#
# Author:: Paul Morton (<pmorton@biaprotect.com>)
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

module WindowsService
  module Helper
    def self.ensure_win32service_gem_installed
      begin
        require 'win32/service'
      rescue LoadError
        Chef::Log.info("Missing gem 'win32-service'...installing now.")
        `gem install "win32-service"`
        if $? != 0
          raise RuntimeError, "win32-service gem failed to install"
        end
        Gem.clear_paths

        require 'win32/service'
      end
    end
  end
end

if RUBY_PLATFORM =~ /mswin|mingw32|windows/
  WindowsService::Helper.ensure_win32service_gem_installed
end
