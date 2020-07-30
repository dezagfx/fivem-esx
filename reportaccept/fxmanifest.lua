fx_version 'bodacious'

game 'gta5'

author 'deza'
description 'misc commands'
version '1.0.0'

client_scripts {'config.lua',
    'client/main.lua'
}

server_scripts {'config.lua',
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua',
}