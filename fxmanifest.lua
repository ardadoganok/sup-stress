fx_version 'adamant'
game 'gta5'

client_scripts {
  'client/main.lua',
  'config.lua'
}

server_scripts {
	'server/main.lua',
  'config.lua'
}

ui_page {
	"html/ui.html",
}

files {
  "html/ui.html",
  "html/js/js.js"
}

exports {
    "AddStress",
    "RemoveStress"
}