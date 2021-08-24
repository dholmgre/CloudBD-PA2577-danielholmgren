node 'appserver' {
	include apt_get_update
	include nodejs
}

node 'dbserver' {
	include apt_get_update
	include mysql
}


class apt_get_update{
	exec {"apt_get_update":
		command => 'sudo apt-get update',
		provider => shell,
	}
}


class nodejs{
	
	exec {"prerequisite":
			command => 'curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -',
			provider => shell,
	}
	
	exec {"nodejs":
		command => 'sudo apt-get install -y nodejs',
		provider => shell,
		require => [
			Exec["apt_get_update"],
			Exec["prerequisite"],
		],
	}
}

class mysql{
	if ($pw == undef ) { 
		$pw = "Passw0rd!" 
	}

	exec {"mysql":
		command => 'sudo apt-get install -y mysql-server',
		provider => shell,
		require => Exec["apt_get_update"],
	}

	exec {"mysql-set-pw":
		command => 'echo mysql-server mysql-server/root_password password ${pw} | sudo debconf-set-selections',
		provider => shell,
		require => [
			Exec["apt_get_update"],
			Exec["mysql"],
		],
	}
}
