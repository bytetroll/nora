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