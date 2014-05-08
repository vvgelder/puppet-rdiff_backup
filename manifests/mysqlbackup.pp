
class rdiff_backup::mysqlbackup ($backupdir = '/var/backups/mysql/') {
   file { "/etc/cron.daily/vvg-mysqlbackup":
        ensure   => 'present',
        mode     => '0755',
        content  => template('rdiff_backup/mysqlbackup.erb'),
   }
}
