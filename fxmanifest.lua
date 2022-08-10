fx_version 'cerulean'
games { 'gta5' }

author "Swkeep#7049"

shared_scripts {
     'config.lua',
     'shared/shared.lua'
}

client_scripts {
     'client/lib/c_lib.lua',
     'client/client_main.lua',
}

server_script {
     'server/lib/s_lib.lua',
     'server/server_main.lua',
}

lua54 'yes'
