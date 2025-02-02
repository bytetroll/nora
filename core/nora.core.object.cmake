# Copyright (C) 2008 - 2025 Execute Software, LLC.  All rights reserved.

function( nora_object_path_get TARGET SOURCE OUTPUT )
    if( MSVC )
        foreach( f ${source_files} )
            get_filename_component( fname ${SOURCE} NAME )
            string( REPLACE ".cpp" ".obj" fname2 ${fname} )
            string( REPLACE ".c" ".obj" fname2 ${fname2} )
            if( MSVC60 )
                set( ${OUTPUT} "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/${fname2}" PARENT_SCOPE )
            else()
                set( ${OUTPUT} "${CMAKE_CURRENT_BINARY_DIR}/${TARGET}.dir/${CMAKE_CFG_INTDIR}/${fname2}" PARENT_SCOPE )
            endif()
        endforeach()
    else()
        # Backwards compat to core <= 2.8.4
        if( "${CMAKE_CURRENT_LIST_DIR}" STREQUAL "" )
            get_filename_component( CMAKE_CURRENT_LIST_DIR ${CMAKE_CURRENT_LIST_FILE} PATH ABSOLUTE )
        endif()

        #GET_FILENAME_COMPONENT(fname ${SOURCE} NAME)
        string( REPLACE "${CMAKE_CURRENT_LIST_DIR}/" "" fname "${SOURCE}" )
        if( WIN32 )
            set( ${OUTPUT} "${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles/${TARGET}.dir/${fname}.obj" PARENT_SCOPE )
        else()
            set( ${OUTPUT} "${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles/${TARGET}.dir/${fname}.o" PARENT_SCOPE )
        endif()
    endif()

endfunction()