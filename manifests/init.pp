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

  exec { "append port to dev resolver":
    command => "echo '\nport 20559' >> /etc/resolver/dev",
    user    => "root",
    unless  => "grep -c 20559 /etc/resolver/dev",
    require => Package["pow"]
  }

  exec { "append boxen env to .powconfig":
    command => "echo '\nsource /opt/boxen/env.sh' >> ${home}/.powconfig",
    user    => "root",
    unless  => "grep -c /opt/boxen/env.sh ${home}/.powconfig",
    require => Package["pow"]
  }

  file { '/Library/LaunchDaemons/dev.pow.firewall.plist':
    source  => "puppet:///modules/pow/dev.pow.firewall.plist",
    group   => 'wheel',
    owner   => 'root',
    require => Package["pow"]
  }->
  exec { 'dev.pow.firewall':
    command => "launchctl load -w /Library/LaunchDaemons/dev.pow.firewall.plist",
    user    => "root"
  }

  file { "${home}/Library/LaunchAgents/dev.pow.powd.plist":
    source  => "puppet:///modules/pow/dev.pow.powd.plist",
    require => Package['pow']
  }->
  exec { 'dev.pow.powd':
    command => "launchctl load -w ${home}/Library/LaunchAgents/dev.pow.powd.plist"
  }
}

