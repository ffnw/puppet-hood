define hood::create (
  String  $subnet,
  String  $subnet6,
  Integer $fastd   = 1,
) {

  require hood
  require hood::params

  batman::instance { $title:
    gw_mode   => 'server',
    bandwidth => $bandwidth,
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

