class enable_jetty ( $xmx = 256, $javahome = "/usr/lib/jvm/java-7-openjdk-${architecture}" ) {

  require dependencies
  require disablejetty6
  require disablejava6

  service { 'jetty8':
    ensure  => running,
    enable  => true,
    require => [
      Package['jetty8'],
      File['/etc/default/jetty8'],
      Exec['check_java'],
      Exec['check_javac'],
    ]
  }

  exec {'check_java':
    command => '/bin/false',
    unless => '/usr/bin/test -e /usr/bin/java',
  }

  exec {'check_javac':
    command => '/bin/false',
    unless => '/usr/bin/test -e /usr/bin/javac',
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

class disablejetty6 {

  package { 'jetty':
    ensure  => absent,
  }

  package { 'libjetty-java':
    ensure  => absent,
  }

  package { 'libjetty-extra':
    ensure  => absent,
  }

  package { 'libjetty-extra-java':
    ensure  => absent,
  }

  file { '/etc/default/jetty':
    ensure => absent,
  }

  file { '/etc/jetty/start.config':
    ensure => absent,
  }

}

class disablejava6 {

  package { 'openjdk-6-jre-lib':
    ensure  => absent,
  }
}
