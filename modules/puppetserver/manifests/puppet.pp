# user list
class puppetserver::puppet {
    include puppetlabs-vcsrepo
    vcsrepo { '/etc/puppetlabs/code':
        ensure     => latest,
        provider   => git,
        source     => 'https://github.com/SteamedFish/puppet.git',
        revision   => 'master',
        submodules => true,
    }

}
