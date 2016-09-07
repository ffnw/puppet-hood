class hood (
  String $bandwidth = $hood::params::bandwidth,
) inherits hood::params {

  class { 'batman': }
  class { 'fastd': }
  class { 'tunneldigger': }
  class { 'dhcp': }
  class { 'radvd': }
  class { 'hopglassserver': }

  contain batman
  contain fastd
  contain tunneldigger
  contain dhcp
  contain radvd
  contain hopglassserver


  service { 'gluon-collector':
    ensure => stopped,
    enable => false,
  } ->
  file {
    default:
      ensure => absent,
      force  => true;
    '/etc/node-collector.yaml':;
    '/opt/gluon-collector':;
    '/var/log/gluon-collector.log':;
    '/etc/systemd/system/gluon-collector.service':;
  }

  service { 'dnsmasq':
    ensure => stopped,
    enable => false,
  }

  package { 'dnsmasq':
    ensure => purged,
  }

  create_resources('hood::create', hiera('hood::create', {}))

}

