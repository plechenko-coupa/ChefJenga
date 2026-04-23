# Include base cookbook for shared helpers
include_recipe 'base::default'

# Install common utilities (duplicated across sections)
package 'curl' do
  action :install
end
package 'wget' do
  action :install
end

group node['app']['app_group'] do
  action :create
end

# Create application user
user node['app']['app_user'] do
  gid node['app']['app_group']
  home node['app']['app_home']
  shell '/bin/bash'
  action :create
end

# Create application home directory
directory node['app']['app_home'] do
  owner node['app']['app_user']
  group node['app']['app_group']
  mode '0755'
  action :create
end

# Create application logs directory
directory "#{node['app']['app_home']}/logs" do
  owner node['app']['app_user']
  group node['app']['app_group']
  mode '0755'
  action :create
end

# Create application bin directory
directory "#{node['app']['app_home']}/bin" do
  owner node['app']['app_user']
  group node['app']['app_group']
  mode '0755'
  action :create
end

# Create application app directory
directory "#{node['app']['app_home']}/app" do
  owner node['app']['app_user']
  group node['app']['app_group']
  mode '0755'
  action :create
end

# Installing Jenga app (as a static HTML file for simplicity)
file "#{node['app']['app_home']}/index.html" do
  content <<~HTML
    <!DOCTYPE html>
    <html>
    <head><title>Jenga App</title></head>
    <body>
      <h1>Welcome to Jenga App</h1>
      <pre>
      Hostname: #{node['hostname']}
      IP Address: #{node['ipaddress']}
      Last Chef Run: #{Time.now}
      </pre>
    </body>
    </html>
  HTML
  owner node['app']['app_user']
  group node['app']['app_group']
  mode '0644'
end

# Install webserver packages
package 'nginx' do
  action :install
end

# Create nginx config directory
directory node['app']['nginx_config_dir'] do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# nginx server
file "#{node['app']['nginx_config_dir']}/default.conf" do
  content <<~NGINX_SERVER_BLOCK
    server {
      listen #{node['app']['webserver_port']} default_server;
      location #{node['app']['web_location'] || '/'} {
        root #{node['app']['app_home']};
        index index.html index.htm;
        access_log #{node['app']['app_home']}/logs/app_access.log;
        error_log #{node['app']['app_home']}/logs/app_error.log;
      }
    }
  NGINX_SERVER_BLOCK
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[nginx]'
end

# Start nginx service
service 'nginx' do
  action [:enable, :start]
end

# Install additional nginx common packages
package 'curl' do
  action :install
end
package 'wget' do
  action :install
end
