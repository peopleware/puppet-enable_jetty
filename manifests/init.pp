class enable_jetty ( $xmx = 256 ) {

  package { 'jetty8':
    ensure  => installed,
  }

  service { 'jetty8':
    ensure  => running,
    enable  => true,
    require => [
      Package['jetty8'],
      File['/etc/default/jetty8'],
    ]
  }

  file { '/etc/default/jetty8':
    content => template('enable_jetty/default-jetty.erb'),
    require => Package['jetty8'],
    owner   => 'root',
    group   => 'root',
  }

  File['/etc/default/jetty8'] ~> Service['jetty8']

  package { 'openjdk-7-jdk':
    ensure => installed,
  }

  package { 'libtomcat6-java':
    ensure => installed,
  }

  package { 'libecj-java':
    ensure => installed,
  }

  package { 'libjstl1.1-java':
    ensure => installed,
  }

  package { 'libservlet3.0-java':
    ensure => installed,
  }

}
