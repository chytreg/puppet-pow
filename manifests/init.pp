class pow {
  package { "pow": }

  $home = "/Users/${::luser}"

  file { ["${home}/Library/Application Support/Pow", "${home}/Library/Application Support/Pow/Hosts"]:
    ensure  => "directory",
    require => Package["pow"]
  }->
  file { "${home}/.pow":
    target  => "${home}/Library/Application Support/Pow/Hosts",
    ensure  => "link",
  }

  # Set up firewall
  exec { "append port to dev resolver":
    command => "echo '\nport 20559' >> /etc/resolver/dev",
    user    => "root",
    unless  => "grep -c 20559 /etc/resolver/dev",
    require => Package["pow"]
  }

  file { "/Library/LaunchDaemons/cx.pow.firewall.plist":
    source  => "puppet:///modules/pow/firewall.plist",
    owner   => "root",
    group   => "wheel",
    require => Package["pow"]
  }->
  exec { "enable firewall launchd":
    command => "launchctl load -w /Library/LaunchDaemons/cx.pow.firewall.plist",
    user    => "root"
  }

  # launch at login
  file { "${home}/Library/LaunchAgents/cx.pow.powd.plist":
    source  => "puppet:///modules/pow/powd.plist",
    require => Package["pow"]
  }->
  exec { "enable login launchd":
    command => "launchctl load -w ${home}/Library/LaunchAgents/cx.pow.powd.plist"
  }
}

