openhbx_access Cookbook
=======================
Provides LWRPs for easy access management.


Requirements
------------
Base chef.

You may need to choose your group provider, currently Chef::Provider::Group::Gpasswd is used.

Attributes
----------

#### openhbx_access::user
<table>
  <tr>
    <th>Attribute</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>user_name</tt></td>
    <td>String</td>
    <td>user account name</td>
    <td>Required - Name Attribute</td>
  </tr>
  <tr>
    <td><tt>other_groups</tt></td>
    <td>Array</td>
    <td>list of additional groups for the user</td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>ssh_keys</tt></td>
    <td>Hash</td>
    <td>ssh login public keys, as: "(key_name)" => "(key_type) (public key as base64)"</td>
    <td><tt>{}</tt></td>
  </tr>
  <tr>
    <td><tt>provider</tt></td>
    <td>String</td>
    <td>The group update provider</td>
    <td><tt>"Chef::Provider::Group::Gpasswd"</tt></td>
  </tr>
</table>

Usage
-----
#### openhbx_access::user

```ruby
require_recipe "openhbx_access::default"

openhbx_access_user "my.user" do
  other_groups ["superadmins", "icanusesshlogin"]
  ssh_keys({
    "my.email@my_laptop" => "ssh-rsa somebase64stuffasastringsometimesendswith=="
  })
end
