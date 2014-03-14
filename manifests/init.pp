class enable_jetty ( $xmx = 256 ) {

  package { 'jetty':
    ensure  => installed,
  }

  service { 'jetty':
    ensure  => running,
    enable  => true,
    require => [
      Package['jetty'],
      File['/etc/default/jetty'],
    ]
  }

  file { '/etc/default/jetty':
    content => template('enable_jetty/default-jetty.erb'),
    require => Package['jetty'],
    owner   => 'root',
    group   => 'root',
  }

  File['/etc/default/jetty'] ~> Service['jetty']

  package { 'openjdk-7-jdk':
    ensure => installed,
  }

}
