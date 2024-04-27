# Install a flask package

# Install Python 3 pip
package { 'python3-pip':
  ensure => installed,
}

# Install Flask and Werkzeug with specified versions
exec { 'install_flask_and_werkzeug':
  command => '/usr/bin/pip3 install -q Flask==2.1.0 Werkzeug==2.0.2',
  path    => ['/usr/bin'],
  require => Package['python3-pip'],
}

# Add /usr/local/bin to PATH
file_line { 'add_flask_path':
  ensure => present,
  path   => '/etc/environment',
  line   => 'PATH="$PATH:/usr/local/bin"',
  notify => Exec['reload_environment'],
}

# Reload environment variables
exec { 'reload_environment':
  command     => 'source /etc/environment',
  path        => ['/usr/bin'],
  refreshonly => true,
}
