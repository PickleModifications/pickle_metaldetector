fx_version 'cerulean'
lua54 'yes'
game 'gta5'

name         'pickle_metaldetector'
version      '1.1.1'
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

file {
    'stream/bv_scanner.ytyp'
}

data_file 'DLC_ITYP_REQUEST' 'stream/bv_scanner.ytyp'
