# Script to install nginx using puppet

exec { 'apt-get update':
  command => '/usr/bin/apt-get update',
}

package { 'nginx':
  ensure  => installed,
  require => Exec['apt-get update'],
}

file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello World!',
  require => Package['nginx'],
}

file_line { 'configure_nginx_listen':
  path    => '/etc/nginx/sites-available/default',
  line    => '        listen 80;',
  match   => '^[ \t]*listen[ \t]+\*:80;',
  require => Package['nginx'],
}

file_line { 'configure_nginx_redirect':
  path    => '/etc/nginx/sites-available/default',
  line    => '        return 301 https://github.com/CJ-ONYERO99;',
  after   => 'location /redirect_me {',
  require => Package['nginx'],
}

service { 'nginx':
  ensure     => running,
  enable     => true,
  hasrestart => true,
  require    => [
    File['/var/www/html/index.html'],
    File_line['configure_nginx_listen'],
    File_line['configure_nginx_redirect'],
  ],
}
