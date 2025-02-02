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