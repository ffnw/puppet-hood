class hood (
  String $bandwidth = $hood::params::bandwidth,
) inherits hood::params {

  class { 'batman': }
  class { 'fastd': }
  class { 'dhcp': }

  contain batman
  contain fastd
  contain dhcp

  create_resources('hood::create', hiera('hood::create', {}))

}

