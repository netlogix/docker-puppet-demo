class profile::apache {

	if $virtual == 'docker' {
		$error_log = '/dev/stderr'
	} else {
		$error_log = undef
	}

	class { 'apache':
		error_log => $error_log,
		default_vhost => false,
	}

	# PHP setup
	include apache::mod::proxy
	include apache::mod::proxy_fcgi

}
