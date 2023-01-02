fx_version "cerulean"

description "4MA-ra"
author "Pedy"
version '1.3.0'
update "NO update "
repository 'https://github.com/Pedy1/pedy_dokumentum'

lua54 'yes'

games {
  "gta5",
}

ui_page 'web/build/index.html'

client_scripts {
  "config.lua",
  "client/**/*"
}
server_scripts {
  "@mysql-async/lib/MySQL.lua",
  "config.lua",
  "server/**/*"
}

files {
  'web/build/index.html',
  'web/build/**/*'
}
