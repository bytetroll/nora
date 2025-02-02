# Copyright (C) 2008 - 2025 Execute Software, LLC.  All rights reserved.

# add all subdirectories to the build system
function( nora_directory_add_all )
    file( GLOB Files * )
    foreach( File ${Files} )
        nora_log_info( "Scanning ${File}" )

        if( IS_DIRECTORY ${File} AND NOT ${File} MATCHES "^${CMAKE_SOURCE_DIR}/\\." AND EXISTS ${File}/CMakeLists.txt )
            nora_log_info( "Registering potential project in subdirectory ${File}... " )
            add_subdirectory( ${File} )
        endif()
    endforeach()
endfunction(nora_directory_add_all)

# add directories to the build system
function( nora_directory_add )
    foreach( Dir ${ARGN} )
        add_subdirectory( ${Dir} )
    endforeach()
endfunction(nora_directory_add)