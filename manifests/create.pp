define hood::create (
  String                   $subnet,
  Array[String]            $subnet6      = [],
  Hash[String,Integer,2,2] $fastd        = { begin => 0, end => -1 },
  Hash                     $tunneldigger = { begin => 0, end => -1 },
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

  dhcp::pool { "bat-${title}":
    network    => ip_address(ip_network($subnet)),
    mask       => ip_netmask($subnet),
    range      => [ "${ip_address(ip_network($subnet, 2))} ${ip_address(ip_broadcast($subnet, 1))}" ],
    gateway    => ip_address(ip_network($subnet, 1)),
    parameters => [ "interface bat-${title}" ],
  }

  radvd::interface { "bat-${title}":
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

  if ($tunneldigger[end] - $tunneldigger[begin]) >= 0 {
    tunneldigger::instance { "${title}":
      address        => $tunneldigger[address],
      port           => $tunneldigger[port],
      interface      => $tunneldigger[interface],
      max_tunnels    => ($tunneldigger[end] - $tunneldigger[begin]),
      tunnel_id_base => $tunneldigger[begin],
      session_up     => epp('hood/tunneldigger-up.sh.epp', {
        batman_interface => "bat-${title}",
      }),
      session_down   => epp('hood/tunneldigger-down.sh.epp', {
        batman_interface => "bat-${title}",
      }),
      session_mtuchanged => epp('hood/tunneldigger-mtu.sh.epp'),
    }
  }

  yanic::interface { "bat-${title}": }

}

