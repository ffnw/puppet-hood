class hood (
  String $bandwidth = $hood::params::bandwidth,
) inherits hood::params {

  class { 'batman': }
  class { 'fastd': }
  class { 'tunneldigger': }
  class { 'dhcp': }
  class { 'gluoncollector': }

  contain batman
  contain fastd
  contain tunneldigger
  contain dhcp
  contain gluoncollector

  create_resources('hood::create', hiera('hood::create', {}))

}

