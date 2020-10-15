# Default manifest
#
# Defines some sane defaults for resource types and determines the nodes role

File {
	owner => 'root',
	group => 'root',
	mode  => '0644',
}

# Some modules need this to be globally set, e.g. augeas
Exec {
	path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

# Building Docker container support
# This has a fix for service provider on docker
if $virtual == 'docker' {
	include ::dummy_service
}

# Determine role from facts
# Node role needs to be set from outside puppet run. Either using an environment variable like this:
# $ FACTER_role=webserver puppet agent --test
# or by using external facts, e.g.
# $ echo 'role=webserver' > /etc/puppetlabs/facter/facts.d/role.txt
if ! defined('$role') {
	fail('The node has no role defined as fact. Please specify the role fact, e.g. using the FACTER_role environment variable.')
}

if defined("role::${facts['role']}") {
	include "role::${facts['role']}"
} elsif defined("${facts['role']}") {
	include "${facts['role']}"
} else {
	fail("The role ${facts['role']} doen't exist.")
}
