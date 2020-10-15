class profile::demo_app1_apache {

	apache::vhost { 'app1':
		port => '80',
		docroot => '/var/www/html',
		error_log_file => '/dev/stderr',
		access_log_file => '/dev/stdout',
		custom_fragment => 'ProxyPassMatch ^/(.*\.php)$ fcgi://${PHP_FPM_ADDRESS}/var/www/html/$1',
	}

	# Exported resource is collected by mariadb profile
	@@mysql::db { 'app1':
		user => 'app1',
		# FIXME use a real password
		password => 'app1',
		grant => 'ALL',
		host => '%',
		tag => 'project:demo',
	}

}
