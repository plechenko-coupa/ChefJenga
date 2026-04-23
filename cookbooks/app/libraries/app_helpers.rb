# App cookbook helper methods
module AppHelpers
  def nginx_user(node)
    node['app']['webserver_user']
  end
end

Chef::DSL::Recipe.include(AppHelpers)
