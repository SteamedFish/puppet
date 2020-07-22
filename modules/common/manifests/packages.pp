# configure packages
class common::packages {

    $packages = [
        'htop',
        'lftp',
        'bash',
        'zsh',
        'bash-completion',
        'dos2unix',
        'figlet',
        'toilet',
        'git',
        'hugo',
        'exa',
        'p7zip',
        'ripgrep',
        'telnet',
        'unrar',
        'unzip',
        'wget',
        'rsync',
    ]

    $packages_debian = ['toilet-fonts', 'fd-find', 'build-essential', 'bind9-host','bsdutils']

    $packages_arch = ['toilet-fonts', 'youtube-dl', 'you-get', 'fd', 'lsd']

    $packages_linux = ['dstat', 'dnsutils','busybox','diffutils','dmidecode','dnsutils','ansible-lint', 'ansible']


    each($packages) |$package| {
        package { $package:
            ensure => installed,
        }
    }

    if $facts['kernel'] == 'Linux' {
        each($packages_linux) |$package| {
            package { $package:
                ensure => installed,
            }
        }
    }

    if $facts['os']['family'] == 'Debian' {
        include apt
        class { 'apt':
            update => {
                frequency => 'daily',
            },
        }

        Class['apt::update'] -> Package <| provider == 'apt' |>

        each($packages_debian) |$package| {
            package { $package:
                ensure => installed,
            }
        }
    }
    elsif $facts['os']['family'] == 'Archlinux' {
        each($packages_arch) |$package| {
            package { $package:
                ensure => installed,
            }
        }
    }
}
