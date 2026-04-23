module Base
  module Helpers
    def service_name_for(node)
      node['base']['service_names'][node['platform_family']] || 'cron'
    end

    def package_manager_for(node)
      node['base']['package_managers'][node['platform_family']] || 'apt'
    end

    def user_home_dir(user)
      require 'etc'
      pwd = Etc.getpwnam(user)
      pwd.dir
    rescue ArgumentError
      "/home/#{user}"
    end

    def app_user(node)
      node['app']['app_user']
    end

    def app_group(node)
      node['app']['app_user']
    end
  end
end

Chef::Node.include(Base::Helpers)
Chef::Recipe.include(Base::Helpers)
