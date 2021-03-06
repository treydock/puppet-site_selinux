# == Class: site_selinux
#
# Manage SELinux resources
#
class site_selinux (
  $ensure = 'present',
  $manage_modules = 'UNSET',
) {

  validate_re($ensure, ['^present$', '^absent$'])

  if $manage_modules == 'UNSET' {
    $manage_modules_real = getvar('selinux::mode') ? {
      'enfocing'    => true,
      'permissive'  => true,
      'disabled'    => false,
      default       => true,
    }
  } else {
    $manage_modules_real  = is_string($manage_modules) ? {
      true    => str2bool($manage_modules),
      default => $manage_modules,
    }
  }

  if $manage_modules_real {
    selinux::module { 'my-mcollective-iptables':
      ensure  => $ensure,
      source  => 'puppet:///modules/site_selinux/my-mcollective-iptables',
    }

    # TODO : Temporary until figure out why this module fails on EL7
    #if $::operatingsystemmajrelease < '7' {
      selinux::module { 'my-zabbix-agent':
        ensure  => $ensure,
        source  => 'puppet:///modules/site_selinux/my-zabbix',
      }
    #}
  }

}
