define hood::create (
  String                   $subnet,
  Array[String]            $subnet6 = [],
  Hash[String,Integer,2,2] $fastd,
) {

  include hood
  include hood::params

  $ip6 = $subnet6.map | $value | {
    ip_network($value, 1)
  }

  batman::interface { $title:
    gw_mode   => 'server',
    bandwidth => $hood::bandwidth,
    ip        => ip_network($subnet, 1),
    ip6       => $ip6,
  }

  dhcp::dhcp { $title:
    interface => "bat-${title}",
    subnet    => $subnet,
    subnet6   => $subnet6,
  }

  if ($fastd[end] - $fastd[begin]) >= 0 {
    
    $fastd_instances = range("${fastd[begin]}", "${fastd[end]}")
    $fastd_instances.each | $key, $value | {
      $fastd_num = $value - $fastd[begin]
      fastd::instance { "${title}${fastd_num}":
        port             => $value,
        batman_interface => "bat-${title}",
      }
    }

  }

  gluoncollector::receiver { "bat-${title}": }

}

