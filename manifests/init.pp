class enable_jetty {

  package { 'jetty':
    ensure  => installed,
    require => Package['libjetty-extra-java'],
  }

  package { 'libjetty-extra-java':
    ensure => installed,
  }

  service { 'jetty':
    ensure  => running,
    enable  => true,
    require => [
      Package['jetty'],
      File['/etc/default/jetty'],
      File['/etc/jetty/start.config'],
    ]
  }

  file { '/etc/default/jetty':
    source  => [
      'puppet:///files/default-jetty',
      '/tmp/vagrant-puppet/files/default-jetty',
    ],
    require => Package['jetty'],
    owner   => 'root',
    group   => 'root',
  }

  File['/etc/default/jetty'] ~> Service['jetty']

  file { '/etc/jetty/start.config':
    source  => [
      'puppet:///files/jetty-start-config',
      '/tmp/vagrant-puppet/files/jetty-start-config',
    ],
    require => Package['jetty'],
    owner   => 'root',
    group   => 'root',
  }

  File['/etc/jetty/start.config'] ~> Service['jetty']

  package { 'openjdk-7-jdk':
    ensure => installed,
  }

}
