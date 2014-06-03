
class rdiff_backup::server ( 
        $confdir       = '/etc/rdiff',
        $keyfile       = '~/.ssh/id_rsa',
        $rdiffbin      = '/usr/bin/rdiff-backup',
        $destination   = '/var/backup',
    ) {

    Sshkey <<| tag == 'rdiff_backup' |>>

    # realize globfile
    # overide variables for server
    Rdiff_backup::Script <<| tag == 'rdiff_script_config' |>> {
        confdir      => "${confdir}",
        keyfile      => "${keyfile}",
        rdiffbin     => "${rdiffbin}",
        destination  => "${destination}",
    }
    # realize globfile
    # overide path variable to put file inside $confdir
    Rdiff_backup::Glob <<| tag == 'rdiff_glob_config' |>> {
        confdir => "${confdir}",
    }

    cron { backupdaily:
        command   => "cd / && run-parts --report --regex '.*\.sh' $confdir/scripts.d",
        user      => root,
        special   => 'daily',
    }
}
