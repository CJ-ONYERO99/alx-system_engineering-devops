# Install a flask package

package { 'python3-pip':
  ensure => installed,
}

package { 'flask':
  ensure   => present,
  provider => 'pip3',
  require  => Package['python3-pip'],
}

exec { 'update_flask_version':
  command     => '/usr/bin/pip3 install -q --upgrade Flask==2.1.0',
  path        => ['/usr/bin'],
  refreshonly => true,
  subscribe   => Package['flask'],
}
