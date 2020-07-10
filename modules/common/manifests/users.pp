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
}
