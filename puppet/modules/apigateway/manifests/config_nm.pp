# == Define: apigateway::config_nm
#
# configures node manager for OAG 11.2.3.4
#
##
define apigateway::config_nm(
  $jdk_home_dir         = hiera('oag_jdk_home_dir'),         # /usr/java/latest
  $oag_version          = hiera('oag_version', 11234),        # 11234
  $oag_home_dir         = hiera('oag_home_dir'),    # /u01/app/oracle/product/OAG-11
  $oag_file             = hiera('oag_file'), 
  $os_user              = hiera('oag_os_user'),              # oracle
  $os_group             = hiera('oag_os_group'),             # oinstall
  $oag_download_dir     = hiera('oag_download_dir'),         # /software
  $source               = hiera('oag_source', undef),        # puppet:///modules/oag/ | /mnt | /vagrant
  $remote_file          = true,                              # true|false
  $log_output           = false,                             # true|false
  $temp_directory       = hiera('oag_temp_dir','/tmp'),      # /var/tmp/install
  $oracle_inventory_dir = undef,
  $orainstpath_dir      = hiera('orainstpath_dir', undef),
  $oag_bin              = hiera('oag_bin'),
  $oag_master_host      = hiera('oag_master_host'),
  $oag_group_name       = hiera('oag_group_name'),
  $oag_instance_name    = hiera('oag_instance_name'),
  $oag_nm_port          = hiera('oag_nm_port'),
)
 
{
 
  $exec_path    = "${jdk_home_dir}/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:"   
  
  exec { "chown oag ${os_user}":
      command     => "/bin/chown -R ${os_user}:${os_group} ${oag_home_dir}",                                
  }
               
  exec { "set up nodemanager":
    command => "${oag_home_dir}/apigateway/posix/bin/managedomain -i --host ${oag_master_host} --port ${oag_nm_port}",   
    path    => $exec_path,
    user    => $os_user,
    group   => $os_group,             
                require => Exec["chown oag ${os_user}"],
  }
   
}
