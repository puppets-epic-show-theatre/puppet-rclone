define rclone::config::dropbox (
  String $os_user,
  Enum['present', 'absent'] $ensure = 'present',
) {

  rclone::config { $title:
    ensure  => $ensure,
    os_user => $os_user,
    type    => 'dropbox',
    options => {},
  }

  if !defined(File['/home/rclone/.config/']) {
    file {'/home/rclone/.config/':
      ensure  => $ensure ? {'present' => 'directory', 'absent' => 'absent'}, # lint:ignore:selector_inside_resource
      owner   => 'rclone',
      group   => 'rclone',
      require => User['rclone']
    }
  }

  file {'/home/rclone/.config/rclone/rclone.conf':
    ensure  => $ensure,
    owner   => 'rclone',
    group   => 'rclone',
    replace => 'no',
    content => '
[check24-dropbox]
type = dropbox
app_key =
app_secret =
token = {}',
    require => [User['rclone'], File['/home/rclone/.config/']]
  }
}
