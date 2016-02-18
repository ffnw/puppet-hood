class hood (
  String $bandwidth = $hood::params::bandwidth,
) inherits hood::params {

  contain batman
  contain fastd
  contain dhcp

  class { 'batman': }
  class { 'fastd': }
  class { 'dhcp': }

}

