class profile::base {

	# Prepare package mangament
	include apt

	# Ensure apt-get update is run before any package installations except software-properties-common, which is needed
	# to add PPAs which of course need to be present before running apt-get update.
	Class['apt::update'] -> Package <| title != $apt::ppa_package |>

}
