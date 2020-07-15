# user list
class common::users {

    $uid = $facts['kernel'] ? {
        'Darwin' => 501,
        default  => 1000,
    }

    if $facts['kernel'] == 'Darwin' {
        $groups = ['admin']
    } elsif $facts['os']['family'] == 'Debian' {
        $groups = ['root', 'adm']
    } else {
        $groups = ['root', 'wheel']
    }

    user { 'steamedfish':
        ensure => present,
        name   => 'steamedfish',
        groups => $groups,
        shell  => '/bin/zsh',
        uid    => $uid,
    }

    $homedir = $facts['kernel'] ? {
        'Darwin' => '/Users',
        default  => '/home',
    }

    file { "${homedir}/steamedfish":
        ensure  => directory,
        owner   => 'steamedfish',
        group   => 'steamedfish',
        mode    => '0700',
        require => User['steamedfish'],
    }
}
