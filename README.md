puppet-rdiff_backup
===================

Puppet module for rdiff-backup over ssh connection

On server create ssh key pair:

  ~# ssh-keygen -t rsa
  Generating public/private rsa key pair.
  Enter file in which to save the key (/root/.ssh/id_rsa): 
  Enter passphrase (empty for no passphrase): 
  Enter same passphrase again: 
  Your identification has been saved in /root/.ssh/id_rsa.
  Your public key has been saved in /root/.ssh/id_rsa.pub.

Distribute public key part to clients with:

    ssh_authorized_key { 'rdiff-backup server public key':
        ensure  => present,
        type    => 'ssh-rsa',
        user    => 'root',
        key     => "AAAAB3NzaC1yc2EAAAABIwAAfQEA6KZFFVmM4xzBSA4xkj/GoFHaz3XLlU8v3vtCMFjuGu2brraFPvcf2qRXLOxLzRZP+TIgoVysqlxOoQpjFjOhZSX+6SR1kiEiZkkKi+pLiHC8EGtQbwQNLIuo/r54l8yyIXA+EhbDlv/tgQOHus6Q09b46I4mJqp6V/ykht1sGLootBlh35GUlBTsWdBy0mYndSfNlirml9UL5dUhS/1n6h3VA7qeurrrw67g3dg6fhhffhn7aB9ceU+kfJQXfhB1yQSnmf4C/yJssfNPxgPdWIOJkMlsL1zij82cYNpGJghpWITh7ultyOKNa3qepVb8rtLzTJb9npUM2i8sQp/QPw==",
        options => 'command="rdiff-backup --server --restrict-read-only /"',
    }
