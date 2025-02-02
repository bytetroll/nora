# Copyright (C) 2008 - 2025 Execute Software, LLC.  All rights reserved.

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