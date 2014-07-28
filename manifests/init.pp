# == Class: site_selinux
#
# Manage SELinux resources
#
class site_selinux (
  $ensure = 'present',
  $manage_modules = true,
) {

  validate_re($ensure, ['^present$', '^absent$'])

  $manage_modules_real = is_string($manage_modules) ? {
    true    => str2bool($manage_modules),
    default => $manage_modules,
  }

  if $manage_modules_real {
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
