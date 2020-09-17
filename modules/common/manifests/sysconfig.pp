# configure sysconfig
class common::syconfig {
    file { 'motd':
        ensure => present,
        path   => '/etc/motd',
        mode   => '0644',
        owner  => 'root',
        group  => 'root',
        source => 'puppet:///modules/common/motd',
    }
}
