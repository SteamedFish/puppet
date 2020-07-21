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

    if $facts['os']['family'] == 'Debian' {
        file { 'puppet6.list':
            ensure   => file,
            name     => '/etc/apt/sources.list.d/puppet6.list',
            contenet => template('apt-sourcelist/puppet6.list.erb'),
        }
        package {'puppet6-release':
            ensure  => latest,
            require => File['puppet6.list'],
            before  => Package['puppet'],
        }
    }
}
