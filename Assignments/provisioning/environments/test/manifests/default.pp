node 'appserver' {
	include apt_get_update
	include nodejs
	include write_ip
}

node 'dbserver' {
	include apt_get_update
	include mysql
	include write_ip
}

node 'web' {
	include apt_get_update
	include nginx
	include write_ip
}

node /tst[0-9]+/ {
	include apt_get_update
	include write_ip
}


class apt_get_update{
	exec {"apt_get_update":
		command => 'sudo apt-get update',
		provider => shell,
	}
}

class write_ip{
	exec {"write_ip":
		command => "ifconfig eth1 | grep inet | awk '{ print $2 }' | head -1 >> /vagrant/hosts ",
		provider => shell,
		require => Exec["apt_get_update"],
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

class nginx{
	exec {"nginx":
		command => 'sudo apt-get install -y nginx',
		provider => shell,
		require => Exec["apt_get_update"],
	}
}


class mysql{

	exec {"mysql":
		command => 'sudo apt-get install -y mysql-server',
		provider => shell,
		require => Exec["apt_get_update"],
	}

	exec {"mysql-set-pw":
		command => 'echo mysql-server mysql-server/root_password password Passw0rd! | sudo debconf-set-selections',
		provider => shell,
		require => [
			Exec["apt_get_update"],
			Exec["mysql"],
		],
	}
}
