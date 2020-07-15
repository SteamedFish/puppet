# configrations
class common::dotfiles {
    $homedir = $::kernel ? {
        'Darwin' => '/Users/steamedfish',
        default  => '/home/steamedfish',
    }

    vcsrepo { "${homedir}/.emacs.d":
        ensure     => latest,
        provider   => git,
        source     => 'https://github.com/hlissner/doom-emacs.git',
        revision   => 'develop',
        user       => 'steamedfish',
        submodules => true,
        require    => User['steamedfish'],
    }

    vcsrepo { "${homedir}/.vim":
        ensure     => latest,
        provider   => git,
        source     => 'https://github.com/SpaceVim/SpaceVim.git',
        revision   => 'master',
        user       => 'steamedfish',
        submodules => true,
        require    => User['steamedfish'],
    }

    file { "${homedir}/.zinit":
        ensure  => directory,
        owner   => 'steamedfish',
        group   => 'steamedfish',
        mode    => '0755',
        require => User['steamedfish'],
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
}
