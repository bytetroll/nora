# Copyright 2025 Miguel Peterson.  All rights reserved.
# Copyright 2025 Nathan Young.  All rights reserved.
# Copyright 2025 Stefen Wendling.  All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
# documentation files (the “Software”), to deal in the Software without restriction, including without
# limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions
# of the Software.
#
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
# TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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