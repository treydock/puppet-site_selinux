# == Class: site_selinux
#
# Manage SELinux resources
#
class site_selinux (
  $ensure = 'present',
  $manage_modules = true,
) {

  validate_re($ensure, ['^present$', '^absent$'])
  validate_bool($manage_modules)

  if $manage_modules {
    selinux::module { 'my-mcollective-iptables':
      ensure  => $ensure,
      source  => 'puppet:///modules/site_selinux/my-mcollective-iptables',
    }

    selinux::module { 'my-zabbix-agent':
      ensure  => $ensure,
      source  => 'puppet:///modules/site_selinux/my-zabbix',
    }
  }

}
