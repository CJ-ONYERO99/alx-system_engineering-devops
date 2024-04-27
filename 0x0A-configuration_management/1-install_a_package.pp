# Install a flask package

package { 'python3-pip':
  ensure => installed,
}

package { 'flask':
  ensure   => '2.1.0',
  provider => 'pip3',
}

exec { 'update_flask_version':
  command     => '/usr/bin/pip3 install -q --upgrade Flask==2.1.0',
  path        => ['/usr/bin'],
  refreshonly => true,
  subscribe   => Package['flask'],
}
