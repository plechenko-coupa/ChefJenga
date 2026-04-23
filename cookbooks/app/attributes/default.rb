# Application configuration
default['app']['app_name'] = 'jenga-app'
default['app']['app_user'] = 'appuser'
default['app']['app_group'] = app_group(node)
default['app']['app_home'] = "/opt/#{node['app']['app_name']}"

# Application runtime dependencies
default['app']['runtime_packages'] = %w[ruby ruby-dev bundler]
default['app']['dev_packages'] = %w[ruby ruby-dev build-essential]

# Webserver configuration
default['app']['webserver_port'] = 8080
default['app']['webserver_user'] = 'nginx'
default['app']['webserver_group'] = node['app']['webserver_user']

# Nginx packages
default['app']['nginx_packages'] = %w[nginx]

# Status and configuration
default['app']['enable_app'] = true
default['app']['enable_webserver'] = true
default['app']['nginx_config_dir'] = '/etc/nginx/conf.d'
