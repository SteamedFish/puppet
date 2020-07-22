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
        'tree',
        'tcpdump',
        'socat',
    ]

    $packages_debian = [
        'toilet-fonts',
        'fd-find',
        'build-essential',
        'bind9-host',
        'bsdutils'
        'vim-nox',
        'emacs-nox',
        'mtr-tiny',
        'golang',
    ]

    $packages_arch = [
        'toilet-fonts',
        'youtube-dl',
        'you-get',
        'fd',
        'lsd',
        'diff-so-fancy',
        'bind',
        'yadm',
        'vim',
        'mtr',
        'go',
    ]

    $packages_linux = [
        'dstat',
        'dnsutils',
        'busybox',
        'diffutils',
        'dmidecode',
        'ansible-lint',
        'ansible',
        'grc',
        'git-crypt',
    ]


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
