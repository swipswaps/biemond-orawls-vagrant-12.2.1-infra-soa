# == Define: apigateway::service_nm
#
# configures node manager as a service for OAG 11.2.3.4
#
##
define apigateway::service_nm(
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
)
 
{
 
  $exec_path    = "${jdk_home_dir}/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:"   
    
  file { 'nodemanager-api':
          ensure  => present,
          source  => "${oag_download_dir}/nodemanager-api",
                                 replace => true,
                                 path    => '/etc/init.d/nodemanager-api',
                                 mode    => '0755',                           
  }
 
  file { 'nodemanager-config':
          ensure  => present,
          source  => "${oag_download_dir}/nodemanger-config",
                                 replace => true,
                                 path    => '/etc/default/nodemanager-api',                      
                                 require => File["nodemanager-api"],
  }
    
  service { 'nodemanager-api':
    enable => true,
                ensure => 'running',
                require => File["nodemanager-config"],
  }
   
}
