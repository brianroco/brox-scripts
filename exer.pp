
class exer {
	$apps = [ "vim", "curl", "git"]
	package { $apps: 
		ensure	=>	"installed",
		notify	=>	User['monitor'],
	}

	user { "monitor":
		ensure		=>	present,
		home		=>	'/home/monitor',
		shell		=>	'/bin/bash',
		managehome	=>	true,
		notify		=>	File['/home/monitor/src'],
	}

	file {'/home/monitor/src':
		ensure =>	directory,
		mode   =>	0644,
		owner	=>	'monitor',
		notify	=>	File['/home/monitor/src/my_memory_check']
	}

	file { '/home/monitor/src/my_memory_check':
		ensure	=>	link,
		target	=>	/scripts/memory_check,
		mode	=>	0744,
		owner	=>	'monitor',
		notify	=>	Cron['my_memory_check'],
	}

	cron { my_memory_check:
		command	=>	"/home/monitor/src/my_memory_check",
		minute	=>	10,
		user	=>	'monitor'
	}
}

include exer
