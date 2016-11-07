
class cactos_cloudiator::install inherits cactos_cloudiator{

  notify{"$module_name installation step":}


  ############ PACKAGES

  # Install zip 
  package{'zip':
    ensure => installed,  
  }

  # Add PPA to install JDK
  include apt
  apt::ppa { 'ppa:openjdk-r/ppa':
    notify => Class[Apt::Update],
  }

  package{'openjdk-8-jre':
    require => [
      Apt::Ppa['ppa:openjdk-r/ppa'],
      Class[Apt::Update]
    ],
  ensure => installed,
  } 

  ############ MYSQL 

  # Install and configure MYSQL
  class { '::mysql::server':
    root_password           => $mysql_root_pw,
    remove_default_accounts => true,
  }

  ############ COLOSSEUM

  # Downloads colosseum from puppet
  file{'colosseum-0.2.0-SNAPSHOT.zip':
    ensure => file,
    path =>'/opt/colosseum-0.2.0-SNAPSHOT.zip',
    source => 'puppet:///modules/cactos_cloudiator/colosseum-0.2.0-SNAPSHOT.zip',
  }

  #unpack colosseum binary
  archive { "colosseum-0.2.0-SNAPSHOT.zip":
    ensure => present,
    source => "/opt/colosseum-0.2.0-SNAPSHOT.zip",
    require => [File['colosseum-0.2.0-SNAPSHOT.zip'],Package['zip']],
    extract => true,
    extract_path  => '/opt',
    path => '/opt/colosseum-0.2.0-SNAPSHOT.zip',
    creates => '/opt/colosseum-0.2.0-SNAPSHOT/',
  }

  # Create pid dir for colosseum
  file { 'col_pid_dir':
    path => '/var/run/colosseum-service',
    ensure => 'directory',
  }

  ############ ETCD

  # Download and extract etcd
  archive {'etcd':
    source => 'https://github.com/coreos/etcd/releases/download/v3.0.13/etcd-v3.0.13-linux-amd64.tar.gz',
    extract => true,
    extract_path => '/opt',
    path => '/opt/etcd.tgz',
    creates => '/opt/etcd-v3.0.13-linux-amd64/',
  }

  # Run update before package change

  exec { "apt-update":
        command => "/usr/bin/apt-get update"
  }

  Exec["apt-update"] -> Package <| |>

}
