define rclone::config::dropbox (
  String $os_user,
  Enum['present', 'absent'] $ensure = 'present',
  String $token = '',
  String $client_secret = '',
  String $client_id = '',
) {

  $_options = {
    token         => $token,
    client_secret => $client_secret,
    client_id     => $client_id,
  }

  rclone::config { $title:
    ensure  => $ensure,
    os_user => $os_user,
    type    => 'dropbox',
    options => $_options,
  }
}
