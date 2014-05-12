
class rdiff_backup::server ( 
        $confdir = '/etc/rdiff',
        $keyfile = '~/.ssh/id_rsa',
        $bin = '/usr/bin/rdiff-backup',
    ) {

    Sshkey <<| tag == 'rdiff_backup' |>>

    # realize globfile
    # overide path variable to put file inside $confdir
    File <<| tag == 'rdiff_glob_config' |>> {
        path => "${confdir}${name}",
    }

}
