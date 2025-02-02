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

# Create project
# @Name: Name of the project
function( nora_project_create NAME )
    # Must not exist
    if( NOT "${Nora.Projects.${NAME}.Name}" STREQUAL "" )
        nora_log_error( "Project with name '${NAME}' already exists" )
    endif()
    nora_log_headerless( "\n\n##################################################################################" )
    nora_log_info( "Creating project ${NAME}" )
    nora_log_headerless( "##################################################################################\n" )

    # append
    list( APPEND Nora.Projects ${NAME} )
    nora_global_set( Nora.Projects "${Nora.Projects}" )

    # Initialize variables
    nora_global_set( "Nora.Projects.${NAME}.Name" "${NAME}" )
    nora_global_set( "Nora.Projects.${NAME}.InstallName" "${NAME}" )
    nora_global_set( "Nora.Projects.${NAME}.Deps" "" )
    nora_global_set( "Nora.Projects.${NAME}.Path" "${CMAKE_CURRENT_LIST_DIR}" )

    # Create preprocessor name
    string( REPLACE "." "_" SAFE_DEFINE "${NAME}" )
    string( TOUPPER "${SAFE_DEFINE}" SAFE_DEFINE )
    nora_global_set( "Nora.Projects.${NAME}.PreprocessorName" "${SAFE_DEFINE}" )

    # Create package
    nora_package_create( ${NAME} "Nora.Projects.${NAME}.Package" )
    nora_global_package_build_path_set( "${NORA_PATH_PIPELINE}/" )

    # Scoped global
    nora_global_set( "Nora.Projects.glocal" "Nora.Projects.${NAME}" )

    # Create project
    project( "${Nora.Projects.${NAME}.Name}" CXX )

    # Default flags
    nora_cxx_flags_set( Nora.Projects.${NAME}.CxxFlags Nora.Projects.${NAME}.CFlags Nora.Projects.${NAME}.LinkerFlags ${CMAKE_BUILD_TYPE} )

    # get platform include path
    # nora_platform_includepath( PlatformIncludePath )

    # all projects are defaulted to /Include/ & /Include<PLATFORM>/
    if( EXISTS "${CMAKE_CURRENT_LIST_DIR}/Include" )
        nora_project_directory_include_add( Include )
    endif()

    # Includes for platform specific configuration.  Issue on some Linux environemnts where platform include path
    # is empty, but because we check for path/, we get true when we don't actually have the folder.
    if( NOT "${PlatformIncludePath}" STREQUAL "" AND EXISTS "${CMAKE_CURRENT_LIST_DIR}/${PlatformIncludePath}" )
        nora_project_directory_include_add( "${PlatformIncludePath}" )
    endif()

    # all projects are defaulted to /Pipeline/
    nora_project_directory_link_add( ${NORA_PATH_PIPELINE} )

    # Default dll import
    nora_project_definitions_add( NORA_EXPORT_${Nora.Projects.${NAME}.PreprocessorName}=${Nora.Cxx.DLLImport} )
    nora_project_definitions_add( "NORA_C_EXPORT_${Nora.Projects.${NAME}.PreprocessorName}=extern \"C\" ${Nora.Cxx.DLLImport}" )
endfunction( nora_project_create )

function( nora_project_test_create PROJECT )
    nora_project_create( ${PROJECT}.Test )
    nora_project_dependency_add( ${PROJECT} )
    nora_project_files_source_add_all( ${ARGN} )
    nora_project_install( EXEC )
endfunction()

function( nora_project_attribute_set NAME )
    nora_global_set( "${Nora.Projects.glocal}.Attr${NAME}" )
endfunction()

function( nora_project_build_mode_set MODE )
    # Default flags
    nora_cxx_flags_set( ${Nora.Projects.glocal}.CxxFlags ${Nora.Projects.glocal}.CFlags ${Nora.Projects.glocal}.LinkerFlags ${MODE} )
endfunction()

# add define
function( nora_project_definitions_add )
    nora_package_definitions_add( ${ARGN} )
endfunction()

# Set build name
function( nora_project_build_name_set NAME )
    nora_global_set( "${Nora.Projects.glocal}.InstallName" "${NAME}" )
endfunction()

# add include directories
function( nora_project_directory_include_add )
    nora_package_directory_include_add( ${ARGN} )
endfunction()

# Glob all paths under the specified include directory.
#MACRO(nora_subdirlist result curdir)
#     file(GLOB children RELATIVE ${curdir} ${curdir}/*)
#    #file( GLOB Files ${curdir}/* )
#    # nora_loginfo( "Recurse resolver - Globbing children ${children}." )
#
#    set(dirlist "")
#    foreach(child ${children})
#        nora_loginfo( "Recurse resolver - Found child ${child}." )
#
#        if(IS_DIRECTORY ${curdir}/${child})
#            nora_loginfo( "Recurse resolver - Using child ${child}." )
#            LIST(APPEND dirlist ${child})
#        endif()
#    endforeach()
#    set(${result} ${dirlist})
#endmacro()

MACRO(nora_project_directory_subdirectory_list result curdir)
    #file(GLOB children RELATIVE ${curdir} ${curdir}/*)
    #file( GLOB Files ${curdir}/* )
    # nora_loginfo( "Recurse resolver - Globbing children ${children}." )

    file( GLOB children ${curdir}/* )
    set(dirlist "")
    foreach( child ${children} )
        nora_log_event_project( "Recurse resolver - Found child ${child}." )

        if( IS_DIRECTORY ${child} AND NOT ${child} MATCHES "^${CMAKE_SOURCE_DIR}/\\." AND EXISTS ${File}/CMakeLists.txt )
            nora_log_event_project( "\tRegistering directory with resolver set." )
            LIST(APPEND dirlist ${child})
        else()
            nora_log_event_project( "\tNot of type directory so throwing out. " )
        endif()
    endforeach()

    # Append our root.
    LIST(APPEND dirlist ${curdir})

    set(${result} ${dirlist})
endmacro()

# For projects where we still want recurse resolve, but
# source is in different folders.
function( nora_project_files_include_add_all )
    nora_project_directory_subdirectory_list( subdirs ${ARGN} )

    foreach(subdir ${subdirs})
        nora_project_directory_include_add(${subdir})
    endforeach()
endfunction()

function( nora_project_directory_add_source_any )
    nora_log_info("[Resolver] Running on path " ${ARGN})
    nora_project_directory_subdirectory_list( subdirs ${ARGN} )
    foreach(subdir ${subdirs})
        nora_log_info("[Resolver] Found current file " subdir)
        nora_project_files_source_add_all(${subdir})
    endforeach()
endfunction()

# Resolve all subs for projects where source and include
# are in same folder.
function( nora_project_directory_add_any )
    nora_log_event_project( "Recurse resolver - Requested resolve at root directory ${ARGN}." )
    nora_project_directory_subdirectory_list( subdirs ${ARGN} )

    nora_log_event_project( "\tRegistering resolver set with project." )
    foreach(subdir ${subdirs})
        nora_log_event_project( "\t\tRegistering ${subdir} to project." )
        nora_project_files_include_add_all(${subdir})
        nora_project_directory_add_source_any(${subdir})
    endforeach()
endfunction()

# add extern include directories
function( nora_project_directory_external_include_add_any )
    nora_package_directory_include_external_add( ${ARGN} )
endfunction()

# add extern links
function( nora_project_external_link_add )
    nora_package_link_external_add( ${ARGN} )
endfunction()

# add extern binaries
function( nora_project_external_binary_add )
    nora_package_binary_external_add( ${ARGN} )
endfunction()

# add library directories
function( nora_project_directory_link_add )
    nora_package_directory_link_add( ${ARGN} )
endfunction()

# add links
function( nora_project_link_add )
    nora_package_link_add_many( ${ARGN} )
endfunction()

# Set sources
function( nora_project_source_set )
    # To absolute
    nora_prefix( "${ARGN}" Absolute "${CMAKE_CURRENT_LIST_DIR}/" )

    # add
    nora_global_set( "${Nora.Projects.glocal}.Sources" "${${Nora.Projects.glocal}.Sources};${Absolute}" )
endfunction()

# Set project output path
function( nora_global_project_path_build PATH )
    # Path must end with \/
    if( NOT "${PATH}" MATCHES "[\\\\\\/]$" )
        set( PATH "${PATH}/" )
    endif()

    # IS_ABSOLUTE is somewhat unreliable
    if( "${PATH}" MATCHES "^[A-z]:[\\\\\\/]|^[\\\\\\/]" )
        nora_global_package_build_path_set( "${PATH}${CMAKE_BUILD_TYPE}/" )
    else()
        nora_global_package_build_path_set( "${${Nora.Projects.glocal}.Path}/${PATH}${CMAKE_BUILD_TYPE}/" )
    endif()

    if( NOT EXISTS "${${Nora.Packages.glocal}.BuildPath}" )
        nora_log_info( "Created output directory ${${Nora.Packages.glocal}.BuildPath}" )
        file( MAKE_DIRECTORY "${${Nora.Packages.glocal}.BuildPath}" )
    endif()
endfunction()

# Set sources by searching inside directories given
# Can specify platform specific by:
# WINDOWS Path1 Path2 PathN
function( nora_project_files_source_add_all )
    # Parse arguments
    cmake_parse_arguments( ARG "" "" "${Nora.Platforms.Uppercase}" ${ARGN} )

    nora_log_info( "Source search requested for project ${Nora.Projects.glocal}" )

    # Compose folders
    set( Folders ${ARG_UNPARSED_ARGUMENTS} )
    foreach( Platform ${Nora.Platforms.Uppercase} )
        if( ${Platform} STREQUAL ${Nora.Platform.Uppercase} )
            list( APPEND Folders ${ARG_${Platform}} )
        endif()
    endforeach()

    # To absolute
    nora_prefix( "${Folders}" AbsoluteFolders "${CMAKE_CURRENT_LIST_DIR}/" )

    nora_log_info("Folder are ${Folders} ${AbsoluteFolders}" )

    # Apply
    nora_postfix( "${AbsoluteFolders}" Headers "/*.h" )
    nora_postfix( "${AbsoluteFolders}" Sources "/*.cpp" )
    nora_postfix( "${AbsoluteFolders}" Asm "/*.asm" )
    nora_postfix( "${AbsoluteFolders}" AsmS "/*.S" )
    file( GLOB_RECURSE SOURCES ${Headers} ${Sources} ${Asm} ${AsmS} )
    nora_global_set( "${Nora.Projects.glocal}.Sources" "${${Nora.Projects.glocal}.Sources};${SOURCES}" )
    nora_log_info("Project global set ${${Nora.Projects.glocal}.Sources}" )
endfunction()

function( nora_project_load_order MODE )
    nora_package_load_order( ${MODE} ${ARGN} )
endfunction()

# add project dependencies
function( nora_project_dependency_add )
    nora_package_dependency_add( ${ARGN} )
endfunction(nora_project_dependency_add)

# Install project
# Options:
#   VIRTUAL : Does not produce an output and is instead handled internally
#   DYNAMIC : Produces a dynamic linked library
#   STATIC  : Produces a staticically linked library
#   EXEC    : Executable
function( nora_project_install )
    nora_global_set( ${Nora.Projects.glocal}.InstallType ${ARGN} )

    # all dynamic libraries depend on the header generator and reflection
#    if( "${ARGN}" STREQUAL "DYNAMIC" )
#        nora_project_adddependencies( Libraries.Reflection )
#        nora_project_adddependencies( Tools.DHG )
#    endif()

    # Set installed
    if( NOT "${ARGN}" STREQUAL "VIRTUAL" )
        nora_global_package_installed_set( "${${Nora.Projects.glocal}.Name}" "${ARGN}" )
    endif()
endfunction( nora_project_install )

# Set project description
function( nora_global_project_description DESC )
    nora_global_package_description_set( ${DESC} )
endfunction(nora_global_project_description)