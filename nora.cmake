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

get_property( NORA_CONFIGURED GLOBAL PROPERTY NORA_CONFIGURED )

# Already configured?
if( NOT NORA_CONFIGURED )
    # Root must exist in current directory
    if( NOT EXISTS "${CMAKE_CURRENT_LIST_DIR}/../nora" )
        message( FATAL_ERROR "Nora root folder misplaced, expected directory '.../nora' but got '${CMAKE_CURRENT_LIST_DIR}'" )
    endif()

    # Root
    set( NORA_ROOT "${CMAKE_CURRENT_LIST_DIR}/.." CACHE INTERNAL "FULL_PATH" )

    message( "Registered root @ ${NORA_ROOT}." )

    ## Search for root
    #function(Nora_SearchRoot FULL_PATH COUNT)
    #    # TODO: Hack
    #    if (${COUNT} EQUAL 24)
    #        Nora_LogError("NoraEngine path too deep")
    #        return()
    #    endif ()
    #
    #    # Attempt current
    #    if (EXISTS "${FULL_PATH}/.root")
    #        message(STATUS "Found NoraEngine/.root '${NORA_ROOT}'")
    #    else ()
    #        # ...
    #        string(FIND "${FULL_PATH}" "/" _INDEX REVERSE)
    #
    #        # empty?
    #        if (_INDEX EQUAL -1)
    #            message(FATAL_ERROR "NoraEngine-ROOT (NoraEngine/.root) could not be found, anchor must exist")
    #        else ()
    #            string(SUBSTRING "${FULL_PATH}" 0 ${_INDEX} NEW_PATH)
    #
    #            # ...
    #            compositor(EXPR NEW_COUNT "${COUNT} + 1")
    #            Nora_SearchRoot(${NEW_PATH} ${NEW_COUNT})
    #        endif ()
    #    endif ()
    #endfunction(Nora_SearchRoot)
    #Nora_SearchRoot(${CMAKE_SOURCE_DIR} 0)

    # clear previously cached EXEC variables
    get_cmake_property( CACHED_VARIABLES VARIABLES )
    foreach( Var ${CACHED_VARIABLES} )
        string( FIND "${Var}" "Nora." INDEX )
        if( ${INDEX} EQUAL 0 )
            unset( ${Var} CACHE )
        endif()
    endforeach()
    message( STATUS "Cleaned up previous cache" )

    # Mark as configured
    set_property( GLOBAL PROPERTY NORA_CONFIGURED "ON" )

    # Configure this
    include( ${NORA_ROOT}/nora/nora.module.cmake )

    # Configure sub systems
    include( ${NORA_PATH_BUILD}/core/nora.core.module.cmake )
    include( ${NORA_PATH_BUILD}/compiler/nora.compiler.module.cmake )
    include( ${NORA_PATH_BUILD}/platform/nora.platform.module.cmake )
    include( ${NORA_PATH_BUILD}/package/nora.package.module.cmake )
    include( ${NORA_PATH_BUILD}/project/nora.project.module.cmake )
    include( ${NORA_PATH_BUILD}/cxx/nora.cxx.module.cmake )

    # Done
    nora_log_event( "Nora build engine ready." )
endif()

# Finalize build system
macro( nora_finalize )
    if( "${CMAKE_CURRENT_LIST_DIR}" STREQUAL "${CMAKE_SOURCE_DIR}" )
        nora_package_finalize()
        nora_package_resolve_search_all()
        nora_package_resolve_all()
        nora_project_configure_all()
        nora_log_event( "Generation complete!" )
    endif()
endmacro( nora_finalize )