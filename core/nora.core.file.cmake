# Copyright (C) 2008 - 2025 Execute Software, LLC.  All rights reserved.

# write to file, checks if contents are different
function( nora_file_write PATH CONTENTS )
    if( EXISTS "${PATH}" )
        file( READ "${PATH}" FileStr )
        if( NOT "${FileStr}" STREQUAL "${CONTENTS}" )
            file( WRITE "${PATH}" "${CONTENTS}" )
        endif()
    else()
        file( WRITE "${PATH}" "${CONTENTS}" )
    endif()
endfunction()