default['base']['motd'] = 'Welcome to Chef Jenga - Base Cookbook'
default['base']['base_user'] = 'svcuser'
default['base']['base_home'] = '/opt/base'
default['base']['base_shell'] = '/bin/bash'
default['base']['base_packages'] = %w(curl wget vim git unzip)
default['base']['base_group'] = 'svcgroup'

# Platform-specific service names
default['base']['service_names'] = {
  'debian' => 'cron',
  'rhel' => 'crond'
}

# Platform-specific package managers
default['base']['package_managers'] = {
  'debian' => 'apt',
  'rhel' => 'yum'
}
