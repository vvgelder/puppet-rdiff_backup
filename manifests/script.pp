# define script

define rdiff_backup::script ( $rdiffbin, $confdir, $retention, $ssh_user, $rootdir, $options, $dest, $syslog = undef, $group = undef ) {

    if $group != undef {
        $dest = "${dest}/${group}",
    }

    # create backup script from template
    file { "${confdir}/scripts.d/${name}.sh":
        mode     => '0750',
        ensure   => 'present',
        content  => template('rdiff_backup/script.erb'),
    }
}
