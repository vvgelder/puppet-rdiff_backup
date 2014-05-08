# == Class: rdiff_backup
#
# Use rdiff-backup over ssh to backup your linux machines
# 
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { rdiff_backup:
       confdir   => '/etc/rdiff',
       retention => '1M',
       dest      => '/var/backup/rdiff',
       options   => '--exclude-device-files',
       glob      => [ 
                      '+ /etc',
                      '- /etc/X11',
                      '+ /root',
                      '+ /home',
                      '+ /var/www',
                      '+ /var/spool/cron',
                      '+ /var/mail',
                    ], 
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
        $confdir = "/etc/rdiff",
        $ssh_user = 'root',
        $retention = "1M",
        $bin = '/usr/bin/rdiff-backup',
        $keyfile = '~/.ssh/id_rsa',
        $dest='/var/backup/rdiff', 
        $options='',
        $glob = [],
    ) {

    # create backup script from template
    @@file { "${confdir}/scripts.d/${fqdn}.sh":
        mode     => '0750',
        ensure   => 'present',
        content  => template('rdiff_backup/script.erb'),
        tag      => 'rdiff_config',
    }

    # create glob file
    @@file { "${confdir}/glob.d/${fqdn}.glob":
        ensure   => 'present',
        content  => template('rdiff_backup/glob.erb'),
        tag      => 'rdiff_config',
    }

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
