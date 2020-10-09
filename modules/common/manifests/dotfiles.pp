# configrations
class common::dotfiles {

    require common::users

    $homedir = $::kernel ? {
        'Darwin' => '/Users/steamedfish',
        default  => '/home/steamedfish',
    }

    vcsrepo { "${homedir}/.config/emacs":
        ensure     => latest,
        provider   => git,
        source     => 'https://github.com/hlissner/doom-emacs.git',
        revision   => 'develop',
        user       => 'steamedfish',
        submodules => true,
    }

    vcsrepo { "${homedir}/.vim":
        ensure     => latest,
        provider   => git,
        source     => 'https://github.com/SpaceVim/SpaceVim.git',
        revision   => 'master',
        user       => 'steamedfish',
        submodules => true,
    }

    file { "${homedir}/.zinit":
        ensure => directory,
        owner  => 'steamedfish',
        group  => 'steamedfish',
        mode   => '0755',
    }

    vcsrepo { "${homedir}/.zinit/bin":
        ensure     => latest,
        provider   => git,
        source     => 'https://github.com/zdharma/zinit.git',
        revision   => 'master',
        user       => 'steamedfish',
        submodules => true,
        require    => File["${homedir}/.zinit"],
    }

    exec { 'dotfiles':
        command => 'yadm clone git@github.com:SteamedFish/dotfiles.git',
        creates => "${homedir}/.config/yadm/repo.git",
        path    => '/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin',
        user    => 'steamedfish',
        group   => 'steamedfish',
        onlyif  => ["bash -c 'command -v yadm'", "test -f ${homedir}/.ssh/id_rsa"],
        timeout => 3000,
        tries   => 10,
    }
}
