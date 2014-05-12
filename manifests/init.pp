# == Class: rdiff_backup
#
# Use rdiff-backup over ssh to backup your linux machines
# 
#
# === Parameters
#
# Document parameters here.
# [*ssh_user*]
#   
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Examples
#
#  class { rdiff_backup:
#       retention => '1M',
#       options   => '--exclude-device-files',
#       glob      => [ 
#                      '+ /etc',
#                      '- /etc/X11',
#                      '+ /root',
#                      '+ /home',
#                      '+ /var/www',
#                      '+ /var/spool/cron',
#                      '+ /var/mail',
#                    ], 
#  }
#
# === Authors
#
# Vincent van Gelder <vvgelder@gmail.com>
#
# === Copyright
#
# Copyright 2014 Vincent van Gelder
#
class rdiff_backup ( 
        $ssh_user   = 'root',
        $retention  = '1M',
        $backuproot = '/',
        $options    = '--exclude-device-files',
        $group      = undef,
        $glob       = [],
    ) {

    # create exported resource for backup script
    @@rdiff_backup::script { "${fqdn}":
        retention   => $retention,
        backuproot  => $backuproot,
        options     => $options,
        group       => $group,
        tag         => 'rdiff_script_config',
    }

    # create exported resource for glob
    @@rdiff_backup::glob { "${fqdn}":
        glob   => $glob,
        tag    => 'rdiff_glob_config',
    }


    # export the local ssh key for backup server
    if "$sshrsakey" {
        @@sshkey { $hostname: type => rsa, key => $sshrsakey, tag => 'rdiff_backup', }
    } elsif "$sshdsakey" {
        @@sshkey { $hostname: type => dsa, key => $sshdsakey, tag => 'rdiff_backup', }
    }

    @package { "rdiff-backup":
        ensure => "installed",
    }

    realize Package[rdiff-backup]
}
