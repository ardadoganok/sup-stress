fx_version 'adamant'
game 'gta5'

client_scripts {
  'client/*.lua'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
	'server/main.lua'
}

ui_page {
	"html/index.html",
}

files {
  "html/index.html",
  "html/scripts.js"
}

exports {
    "AddStress",
    "RemoveStress"
}
