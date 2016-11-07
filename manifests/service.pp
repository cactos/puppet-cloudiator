
class cactos_cloudiator::service inherits cactos_cloudiator{

  notify{"$module_name service step":}

  # Create colosseum service  
  service { 'colosseum-service':
    require    => File['col_pid_dir'],
    ensure     => running,
    start      => "nohup /opt/colosseum-0.2.0-SNAPSHOT/bin/colosseum -Dpidfile.path=/var/run/play.pid -Dconfig.file=/opt/colosseum-0.2.0-SNAPSHOT/conf/config.conf -Dlca.client.config.registry=etcdregistry -Dlca.client.config.registry.etcd.hosts=0.0.0.0 2>&1 >> /var/log/colosseum-service.log &",
    stop       => "/usr/bin/pkill -f colosseum",
    pattern    => "colosseum-0.2.0-SNAPSHOT", #todo improve pattern to avoid ambiguity
    provider   => 'base',
  }

  # Create etcd service  
  service{'etcd':
    require    => Archive['etcd'],
    ensure     => running,
    start      => "nohup /opt/etcd-v3.0.13-linux-amd64/etcd 2>&1 >> /var/log/etcd.log &",
    stop       => "/usr/bin/pkill -f etcd",
    pattern    => "etcd", #todo improve pattern to avoid ambiguity
    provider   => 'base',
  }

}
