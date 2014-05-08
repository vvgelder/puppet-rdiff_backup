
class rdiff_backup::server {

    Sshkey <<| tag == 'rdiff_backup' |>>

    File <<| tag == 'rdiff_config' |>>

}
