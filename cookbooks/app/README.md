# Jenga App - App Layer Cookbook

## Description

This cookbook installs and configures a sample application with a web server.

The application is a simple static web page served by Nginx. It outputs the information about the server and the last Chef run like below:

### Welcome to Jenga App
```text
Hostname: dc9d01b9b94c
IP Address: 172.17.0.2
Last Chef Run: 2026-04-23 16:40:45 +0000
```

## Features

The cookbook installs:
1. Application dependencies
2. A sample HTTP application (as a static web page)
3. Nginx web server
4. Application configuration
5. Web server configuration
