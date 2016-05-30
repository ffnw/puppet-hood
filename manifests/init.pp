class hood (
  String $bandwidth = $hood::params::bandwidth,
) inherits hood::params {

  class { 'batman': }
  class { 'fastd': }
  class { 'tunneldigger': }
  class { 'dhcp': }
  class { 'gluoncollector': }
  class { 'hopglassserver': }

  contain batman
  contain fastd
  contain tunneldigger
  contain dhcp
  contain gluoncollector
  contain hopglassserver

  create_resources('hood::create', hiera('hood::create', {}))

}

