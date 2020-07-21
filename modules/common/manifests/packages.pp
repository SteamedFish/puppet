# configure packages
class common::packages {
    if $facts['os']['family'] == 'Debian' {
        include apt
        class { 'apt':
            update => {
                frequency => 'daily',
            },
        }

        Class['apt::update'] -> Package <| provider == 'apt' |>
    }
}
