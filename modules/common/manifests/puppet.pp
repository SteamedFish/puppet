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

        include apt

        apt::source {'puppet6':
            comment  => 'puppet 6 repo',
            location => 'http://apt.puppetlabs.com',
            release  => $facts['os']['distro']['codename'],
            repos    => 'puppet6',
            key      => {
                'id'     => '7F438280EF8D349F',
                'server' => 'pgp.mit.edu',
            },
            include  => {
                'deb' => true,
                'src' => false,
            },
            before   => Package['puppet6-release'],
        }

        package {'puppet6-release':
            ensure  => latest,
            require => File['puppet6.list'],
            before  => Package['puppet'],
        }
    }
}
