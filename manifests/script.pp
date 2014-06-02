# define script

define rdiff_backup::script ( 
    $ssh_user, 
    $retention, 
    $backuproot, 
    $confdir, 
    $options, 
    $destination, 
    $keyfile,
    $rdiffbin, 
    $syslog = undef, 
    $group = undef ) {

    if $group != undef {
        $dest = "${destination}/${group}"
    }

    # create backup script from template
    file { "${confdir}/scripts.d/${name}.sh":
        mode     => '0750',
        ensure   => 'present',
        content  => template('rdiff_backup/script.erb'),
    }
}
