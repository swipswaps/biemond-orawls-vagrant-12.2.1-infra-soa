# apigateway

Installs, configures and manages OAG 11.1.2.3.4

## Author

Arturo Viveros
https://github.com/gugalnikov

### Required software and artifacts

- ofm_oag_linux_11.1.2.4_disk1of1.zip
- oag_silent.xml (response file for silent installation)

## Usage

Example usage:

# oag vars
 
oag_jdk_home_dir:   '/usr/java/latest'
oag_version:        '11234'
oag_home_dir:       '/u01/app/oracle/product/OAG-11'
oag_file:           'ofm_oag_linux_11.1.2.4_disk1of1.zip'
oag_os_user:        'oracle'
oag_os_group:       'oinstall'
oag_download_dir:   '/software'
oag_source:         'puppet:///modules/oag/'
oag_temp_dir:       '/var/tmp/install'
oag_bin:            'OAG-11.1.2.4.0-linux-x64-installer.run'
 
class oag {
  require java  
  apigateway::install{ '11234':     
      oag_version => hiera('oag_version', 11234),    
  }

This section is where you describe how to customize, configure, and do the
fancy stuff with your module here. It's especially helpful if you include usage
examples and code samples for doing things with your module.

## Reference

Here, include a complete list of your module's classes, types, providers,
facts, along with the parameters for each. Users refer to this section (thus
the name "Reference") to find specific details; most users don't read it per
se.

## Limitations

This is where you list OS compatibility, version compatibility, etc. If there
are Known Issues, you might want to include them under their own heading here.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You can also add any additional sections you feel
are necessary or important to include here. Please use the `## ` header.
