# Copyright (C) 2008 - 2025 Execute Software, LLC.  All rights reserved.

# get plaform include name
macro( nora_platform_path_include OUT )
    if( Nora.Platform STREQUAL Windows )
        set( ${OUT} "IncludeWindows" )
    elseif( Nora.Platform STREQUAL Linux )
        set( ${OUT} "IncludeLinux" )
    else()
        nora_log_error( "Unknown platform: '${Nora.Platform}'" )
    endif()
endmacro(nora_platform_path_include)