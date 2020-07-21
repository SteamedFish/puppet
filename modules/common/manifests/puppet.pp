# configrations
class common::puppet {
    $puppetpackage = $facts['os']['family'] ? {
        'Debian'    => 'puppet-agent',
        'Archlinux' => 'puppet',
        default     => 'puppet',
    }

    package { 'puppet':
        ensure => latest,
        name   => $puppetpackage,
    }

    service { 'puppet':
        ensure  => 'running',
        name    => 'puppet',
        enable  => true,
        require => Package['puppet'],
    }
}
