class profile::php_fpm {

	$php_version = '7.4'

	if $virtual == 'docker' {
		$error_log = '/proc/self/fd/2'
	} else {
		$error_log = 'syslog'
	}

	$fpm_ini_settings = {
		'PHP/expose_php' => 'Off',
		'PHP/display_errors' => 'Off',
		'PHP/log_errors' => 'On',
		'PHP/error_log' => $error_log,
	}

	$cli_init_settings = {
		'PHP/expose_php' => 'Off',
		'PHP/display_errors' => 'On',
		'PHP/error_log' => $error_log,
	}

	class { 'php::globals':
		php_version => $php_version,
		fpm_pid_file => "/run/php/php${php_version}-fpm.pid",

	}

	class { 'php':
		manage_repos => false,
		composer => false,
		fpm => true,
		dev => false,
		settings => $fpm_ini_settings,
		cli_settings => $cli_init_settings,
		extensions => {
			'mysql' => {},
			'opcache' => {
				'zend' => true,
			},
		}
	}

	# FIXME rather than defining this here the php module should be fixed to not hardcode the creation in manifests/fpm/config.pp:114
	file { '/run/php':
		ensure => 'directory',
		owner => 'root',
		group => 'root',
		mode => '0644',
	}

}
