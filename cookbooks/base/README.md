# Base - Layer Cookbook

## Description

This is a library cookbook providing shared helpers and utilities for other cookbooks in the Chef Jenga game.

## Components

### Libraries

The `libraries/helpers.rb` provides shared utility methods:
- `service_name_for(node)` - Returns platform-specific service name (cron/crond)
- `package_manager_for(node)` - Returns platform-specific package manager (apt/yum)
- `user_home_dir(user)` - Returns home directory for a user

### Default Recipe

The `recipes/default.rb` performs minimal setup:
- Installs base system packages
- Creates base directories for application use
- Sets up a service user account

## Usage in Other Cookbooks

Include the base cookbook in your metadata:
```ruby
depends 'base'
```

Use helper methods in your recipes:
```ruby
service_name = service_name_for(node)

service service_name do
  action [:enable, :start]
end
```

## Refactoring Opportunities

This cookbook demonstrates several good starting points for refactoring:
- Hardcoded package lists in default recipe
- Duplicated user creation logic
- Inline file content that could be templated
- Platform conditionals that could use helpers
