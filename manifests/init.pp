class hood (
  String $bandwidth = $hood::params::bandwidth,
) inherits hood::params {

  require batman
  require fastd
  require dhcp

  create_resources('hood::create', hiera('hood::create', {}))

}

