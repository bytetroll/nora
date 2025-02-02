# Copyright (C) 2008 - 2025 Execute Software, LLC.  All rights reserved.
# https://stackoverflow.com/questions/18968979/how-to-get-colorized-output-with-cmake/19371562

function( nora_log MESSAGE )
    message( "[Nora] ${MESSAGE}" )
endfunction()

function( nora_log_headerless MESSAGE )
    message( "${MESSAGE}" )
endfunction()

# Error
function( nora_log_error MESSAGE )
    nora_log( " ERROR ${MESSAGE}" )
endfunction(nora_log_error)

# Warning
function( nora_log_warning MESSAGE )
    nora_log( " WARNING ${MESSAGE}" )
endfunction(nora_log_warning)

# Info
function( nora_log_info MESSAGE )
    nora_log( "INFO ${MESSAGE}" )
endfunction(nora_log_info)

# Event
function( nora_log_event MESSAGE )
    nora_log( "${MESSAGE}" )
endfunction()


function( nora_log_event_project MESSAGE )
    nora_log_info( "\t\t${MESSAGE}" )
endfunction()