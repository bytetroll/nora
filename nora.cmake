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