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
# Set global variable
function( nora_global_set NAME )
    # nora_logevent( "\tRegistering core global ${NAME}" )
    set( ${NAME} "${ARGN}" CACHE INTERNAL "" FORCE )
endfunction(nora_global_set)

# Prefix all
macro( nora_prefix VAR OUT PREFIX )
    set( ${OUT} "" )
    foreach( F ${VAR} )
        list( APPEND ${OUT} "${PREFIX}${F}" )
    endforeach( F )
endmacro( nora_prefix )

# Postfix all
macro( nora_postfix VAR OUT POSTFIX )
    set( ${OUT} "" )
    foreach( F ${VAR} )
        list( APPEND ${OUT} "${F}${POSTFIX}" )
    endforeach( F )
endmacro( nora_postfix )