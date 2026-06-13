fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'filo_antipeek'
author 'filo studios.'
discord 'https://discord.gg/bErPEKvRXg'
description 'A simple script that prevents players from shooting behind covers.'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/cl-*.lua'
}

server_scripts {
    'server/sv-*.lua'
}