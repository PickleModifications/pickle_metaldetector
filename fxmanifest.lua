fx_version 'cerulean'
lua54 'yes'
game 'gta5'

name         'pickle_metaldetector'
version      '1.0.0'
description  'A multi-framework metal detector that goes great with police / security roleplay.'
author       'Pickle Mods'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'core/shared.lua',
    "locales/locale.lua",
    "locales/translations/*.lua",
    'modules/**/shared.lua',
}

server_scripts {
    'bridge/**/server.lua',
    'modules/**/server.lua',
}

client_scripts {
    'core/client.lua',
    'bridge/**/client.lua',
    'modules/**/client.lua',
}

escrow_ignore {
	"config.lua",
	"_INSTALL/**/*.*",
	"bridge/**/*.*",
	"locales/**/*.*",

	-- COMMENT BELOW IF NOT SOURCE --

	--"modules/**/*.*",
	--"core/*.*",
}