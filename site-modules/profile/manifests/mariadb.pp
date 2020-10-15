class profile::mariadb {

	if $virtual == 'docker' {
		$service_enabled = false
	} else {
		$service_enabled = true
	}

	class { 'mysql::server':
		package_name => 'mariadb-server',
		remove_default_accounts => true,
		restart => $service_enabled,
		override_options => {
			'mysqld' => {
				'skip-name-resolve' => true,
				'bind-address' => '0.0.0.0',
			},
		},
	}

	class { 'mysql::client':
		package_name => 'mariadb-client',
	}

	if defined(Class['dummy_service']) {
		# Start a temporary mysql instance (similar to docker image entry point)
		exec { 'start temporary mysql instance for setup':
			command => 'install -d -o mysql -g root -m 0755 /var/run/mysqld && /usr/sbin/mysqld --skip-networking >/var/log/mysql/setup.log 2>&1 &',
			provider => 'shell',
			require => Class['mysql::server::installdb'],
			before => Class['mysql::server::service'],
		}
	}

	if $::facts['project'] {
		Mysql::Db <<| tag == "project:${::facts['project']}" |>>
		Mysql_user <<| tag == "project:${::facts['project']}" |>>
		Mysql_grant <<| tag == "project:${::facts['project']}" |>>
		Mysql_database <<| tag == "project:${::facts['project']}" |>>
	}

}
