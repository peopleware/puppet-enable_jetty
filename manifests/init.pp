class enable_jetty ( $xmx = 256 ) {

  require dependencies

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

}

class dependencies {

  package { 'jetty8':
    ensure  => installed,
  }

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

  file { '/usr/share/jetty8/lib/autostore':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    require => Package['jetty8'],
  }

  file { '/usr/share/jetty8/lib/autostore/ecj.jar':
    ensure => 'link',
    target => '../../../java/ecj.jar',
    require => File['/usr/share/jetty8/lib/autostore'],
  }

  file { '/usr/share/jetty8/lib/autostore/jasper-el.jar':
    ensure => 'link',
    target => '../../../java/jasper-el.jar',
    require => File['/usr/share/jetty8/lib/autostore'],
  }

  file { '/usr/share/jetty8/lib/autostore/jasper.jar':
    ensure => 'link',
    target => '../../../java/jasper.jar',
    require => File['/usr/share/jetty8/lib/autostore'],
  }

  file { '/usr/share/jetty8/lib/autostore/jstl1.1.jar':
    ensure => 'link',
    target => '../../../java/jstl1.1.jar',
    require => File['/usr/share/jetty8/lib/autostore'],
  }

  file { '/usr/share/jetty8/lib/autostore/tomcat-el-api-2.2.jar':
    ensure => 'link',
    target => '../../../java/tomcat-el-api-2.2.jar',
    require => File['/usr/share/jetty8/lib/autostore'],
  }

  file { '/usr/share/jetty8/lib/autostore/tomcat-jsp-api-2.2.jar':
    ensure => 'link',
    target => '../../../java/tomcat-jsp-api-2.2.jar',
    require => File['/usr/share/jetty8/lib/autostore'],
  }

  file { '/usr/share/jetty8/lib/autostore/tomcat-juli.jar':
    ensure => 'link',
    target => '../../../java/tomcat-juli.jar',
    require => File['/usr/share/jetty8/lib/autostore'],
  }

}
