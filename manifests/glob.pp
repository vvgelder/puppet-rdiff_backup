# define glob

define rdiff_backup::glob (
       $confdir = '/etc/rdiff', 
       $glob = [],
    ) {
    # create glob file
    file { "${confdir}/glob.d/${name}.glob":
        ensure   => 'present',
        content  => template('rdiff_backup/glob.erb'),
    }
}
