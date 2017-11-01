# == Define: apigateway::install
#
# installs OAG 11.2.3.4
#
##
define apigateway::install(
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
)
{
 
  $exec_path    = "${jdk_home_dir}/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:"   
               
  exec { "create temp directory":
    command => "mkdir -p ${temp_directory}",
    unless  => "test -d ${temp_directory}",
    path    => $exec_path,   
  }
               
  # check install folder
  if !defined(File[$temp_directory]) {
    file { "${temp_directory}":
      ensure  => directory,
      require => Exec["create temp directory"],
      replace => false,
      owner   => $os_user,
      group   => $os_group,
      mode    => '0777',
    }
  }
 
  exec { "unzip OAG":
          command   => "unzip -o -q '${oag_download_dir}/${oag_file}' -d '${temp_directory}'",
          timeout   => 0,
          path      => $exec_path,
          user      => $os_user,
          group     => $os_group,        
          cwd       => $temp_directory,
          require   => Exec["create temp directory"],
        }
                              
  exec { "chmod OAG bin":
      command     => "chmod +x '${temp_directory}/${oag_bin}'",                
      path      => $exec_path,           
                  require   => Exec["unzip OAG"],
  }
               
  exec { "install OAG":
      command     => "${temp_directory}/${oag_bin} --optionfile ${oag_download_dir}/oag_silent.xml",                         
                  path        => $exec_path,
                  require     => Exec["chmod OAG bin"],
  }
  
}
