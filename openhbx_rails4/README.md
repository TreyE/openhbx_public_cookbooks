openhbx_rails4 Cookbook
==============================

Provides LWRP for managing common Rails4 setup tasks.

Requirements
------------
Base chef.

Attributes
----------

#### openhbx_rails4_devise_initializer
#### openhbx_rails4_eye_daemon
#### openhbx_rails4_mongoid_yaml
#### openhbx_rails4_nginx_unicorn
#### openhbx_rails4_production_environment
#### openhbx_rails4_secrets_yaml
<table>
  <tr>
    <th>Attribute</th>
    <th>Type</th>
    <th>Description</th>
    <th>Required</th>
  </tr>
  <tr>
    <td><tt>configuration_path</tt></td>
    <td>String</td>
    <td>path to your rails 'config' directory</td>
    <td>Required - Name attribute</td>
  </tr>
  <tr>
    <td><tt>cookie_secret</tt></td>
    <td>String</td>
    <td>Secret key for rails cookies</td>
    <td>Required</td>
  </tr>
  <tr>
    <td><tt>file_user</tt></td>
    <td>String</td>
    <td>User to whom the rails configuration files belong.</td>
    <td>Required</td>
  </tr>
  <tr>
    <td><tt>file_group</tt></td>
    <td>String</td>
    <td>User to whom the rails configuration files belong.</td>
    <td>Required</td>
  </tr>
</table>

Usage
-----

#### openhbx_rails4_nginx_unicorn
```ruby
require_recipe "openhbx_rails4::default"

openhbx_rails4_nginx_unicorn "install nginx and configuration with ssl" do
  use_ssl true
  ssl_key_file "myapp.key"
  ssl_cert_file "myapp.crt"
  unicorn_application_name "myapp"
  ssl_private_key <<-PRIVKEY
-----BEGIN RSA PRIVATE KEY-----
PRIVATE KEY
-----END RSA PRIVATE KEY-----
PRIVKEY
  ssl_certificate <<-CERTDATA
-----BEGIN CERTIFICATE-----
PUBLIC CERTIFICATE
-----END CERTIFICATE-----
CERTDATA
end

#### openhbx_rails4_production_environment

```ruby
require_recipe "openhbx_rails4::default"

openhbx_rails4_production_environment "/var/www/deployments/myapp/shared/config" do
  file_user "nginx"
  file_group "nginx"
  template_name "production.rb.erb"
end

#### openhbx_rails4_secrets_yaml

```ruby
require_recipe "openhbx_rails4::default"

openhbx_rails4_secrets_yaml "/var/www/deployments/myapp/shared/config" do
  file_user "nginx"
  file_group "nginx"
  cookie_secret "thesecrethexthingrailslikes"
end
