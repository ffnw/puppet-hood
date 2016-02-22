define hood::create (
  String        $subnet,
  Array[String] $subnet6 = [],
  Integer       $fastd   = 1,
) {

  require hood
  require hood::params

  $ip6 = []
  $subnet6.each | $value | {
    $ip6 = $ip6 + [ ip_address(ip_network($value, 1)) ]
  }

  batman::instance { $title:
    gw_mode   => 'server',
    bandwidth => $bandwidth,
    ip        => ip_address(ip_network($subnet, 1)),
    ip6       => $ip6,
  }

  dhcp::dhcp { $title:
    interface => "bat-${title}",
    subnet    => $subnet,
    subnet    => $subnet6,
  }

  $fastd = $fastd - 1
  if $fastd > 0 {

    $fastd_instances = range('0', "${fastd}")
    $fastd_instances.each | $instance | {
      fastd::instance { $title:
        port             => 10000 + $instance,
        batman_interface => "bat-${title}",
      }
    }

  }

}

