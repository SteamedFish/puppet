# user list
class common::users {

    $uid = $::kernel ? {
        'Darwin' => 501,
        default  => 1000,
    }

    $groups = $::kernel ? {
        'Darwin' => ['admin'],
        default  => ['root', 'wheel'],
    }

    user { 'steamedfish':
        ensure => present,
        name   => 'steamedfish',
        groups => $groups,
        shell  => '/bin/zsh',
        uid    => $uid,
    }

    $homedir = $::kernel ? {
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
