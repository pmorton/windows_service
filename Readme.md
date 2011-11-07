Description
===========
Provides a native interface for controlling and creating windows services

Requirement
===========

Platform
--------

* Windows XP
* Windows Vista
* Windows Server 2003 R2
* Windows 7
* Windows Server 2008 (R1, R2)

Resources/Providers
===================

windows_service
---------------
### Actions
- :start: Starts a service
- :stop: Stops a service
- :restart: Restarts a service

### Attribute Parameters
- :service_name: Name attribute for the service to perform the action on

### Examples

    # Restart the print spooler
    windows_service "spooler" do
        action :restart
    end

windows_service_manage
----------------------
### Actions
- :create: Create a Windows SCM Service
- :delete: Deletes a Windows SCM Service
- :configure: Configures and existing service

### Attributes
- :service_name: The name of the service to create, modify, or delete
- :display_name: The display name of the service
- :desired_access: Defaults to Win32::Service::ALL_ACCESS (See Constants)
- :service_type: Defaults to Win32::Service::WIN32_OWN_PROCESS (See Constants)
- :start_type: Defaults to Win32::Service::AUTO_START (See Constants)
- :error_control: Win32::Service::ERROR_NORMAL (See Constants)
- :binary_path_name: The path to the exe or dll to run as a service
- :service_start_name: The user to start the service as
- :password: The password to use when starting the service as a user,
- :description: a breif description of the service
- :fail_exist_check: If the provider checks for the existance of the service prior to action, true will prevent the provider from raising an exception if the check fails

### Constanst
[Win32-Service RubyGem Constants] (http://rubyforge.org/docman/view.php/85/595/service.html)

### Examples
    #Create a new service called clamd
    windows_service_manage "clamd" do
      action :create
      binary_path_name "C:\clamav\clamd.exe --daemon"
      description "Clam Anti-Virus Scanning Daemon"
      display_name "ClamD Scanning Service"
      fail_exist_check false
    end

    #Delete a service called clamd
    windows_service_manage "clamd" do
        action :delete
    end

    #Set a service called clamd to manual startup
    windows_service_manage "clamd" do
        action :configure
        start_type Win32::Service::DEMAND_START
    end
