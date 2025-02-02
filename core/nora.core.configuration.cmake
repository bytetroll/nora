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
macro( nora_configuration_write_start VAR )
    set( ${VAR} "" )
endmacro()

macro( nora_configuration_write CONFIG NAME )
    set( ${CONFIG} "${${CONFIG}}${NAME}\n${ARGN}\n" )
endmacro()

function( nora_configuration_write_end CONFIG PATH )
    file( WRITE "${PATH}" "${${CONFIG}}" )
endfunction()

function( nora_configuration_read PATH PREFIX GLOBAL )
    file( READ "${PATH}" Contents )
    string( REPLACE ";" "½" Contents "${Contents}" )
    string( REPLACE "\n" ";" Contents "${Contents}" )

    list( LENGTH Contents Length )

    set( i 0 )

    set( break OFF )
    while( NOT ${break} )
        list( GET Contents ${i} Name )
        math( EXPR i "${i} + 1" )
        list( GET Contents ${i} Value )
        string( REPLACE "½" ";" Value "${Value}" )
        math( EXPR i "${i} + 1" )

        if( GLOBAL )
            nora_global_set( "${PREFIX}${Name}" ${Value} )
        else()
            set( "${PREFIX}${Name}" ${Value} )
        endif()

        math( EXPR j "${i} + 2" )
        if( ${j} GREATER ${Length} )
            set( break ON )
        endif()
    endwhile()
endfunction()