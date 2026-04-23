# Install base system packages
package 'curl'
package 'wget'
package 'nano'
package 'git'
package 'unzip'

# Create base service group
group node['base']['base_group'] do
  action :create
end

# Create base service user
user node['base']['base_user'] do
  gid node['base']['base_group']
  home node['base']['base_home']
  shell node['base']['base_shell']
  action :create
end

# Create base application directory
directory node['base']['base_home'] do
  owner node['base']['base_user']
  group node['base']['base_group']
  mode '0755'
  action :create
end

# Create base status file
file '/tmp/chef-jenga-base.txt' do
  content "#{node['base']['motd']}\nUser: #{node['base']['base_user']}\nHome: #{node['base']['base_home']}\nGroup: #{node['base']['base_group']}\n"
  mode '0644'
end
