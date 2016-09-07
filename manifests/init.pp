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

  create_resources('hood::create', hiera('hood::create', {}))

}

