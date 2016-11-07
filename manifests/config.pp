
class cactos_cloudiator::config inherits cactos_cloudiator{

  notify{"$module_name config step":}

  ############ MYSQL 

  #Create MYSQL user and database
  mysql::db { 'colosseum':
    user     => $mysql_col_name,
    password => $mysql_col_pw,
    host     => 'localhost',
  }

  ############ COLOSSEUM 

  # ensure the config directory for colosseum is present
  file { 'col_conf_dir':
    path => '/opt/colosseum-0.2.0-SNAPSHOT/conf',
    ensure => 'directory',
    require => Archive['colosseum-0.2.0-SNAPSHOT.zip'],
  }

  # colosseum application configuration
  file { 'col_conf_application':
    path => '/opt/colosseum-0.2.0-SNAPSHOT/conf/application.conf',
    ensure => 'file',
    require => File['col_conf_dir'],
    source => 'puppet:///modules/cactos_cloudiator/application.conf'
  }

  # colosseum general configuration
  file { '/opt/colosseum-0.2.0-SNAPSHOT/conf/config.conf':
    content => "include \"application.conf\"\nplay.crypto.secret =\"$col_secret\"\ndb.default.driver=org.mariadb.jdbc.Driver\ndb.default.url=\"mysql://$mysql_col_name:$mysql_col_pw@localhost/colosseum\"\ncolosseum.nodegroup = $col_prefix",
    require => File['col_conf_dir'],
  }
}
