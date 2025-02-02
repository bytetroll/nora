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

nora_global_set( Nora.Cxx.Preprocessors "" )

# Custom configuration types
nora_global_set( CMAKE_CONFIGURATION_TYPES "Debug64;Release64;Profile64;Verify64" )

# add global preprocessor
function( nora_cxx_preprocessor_global_add STR )
    nora_global_set( Nora.Cxx.Preprocessors "${Nora.Cxx.Preprocessors};${STR}" )
endfunction()

# Profile property_mode?
# Profile also enables debug property_mode
if( CMAKE_BUILD_TYPE MATCHES "Profile" )
    nora_cxx_preprocessor_global_add( NORA_PROFILE=1 )
    nora_cxx_preprocessor_global_add( NORA_DEBUG=1 )
endif()

# Verify property_mode?
# Verify also enables debug property_mode
if( CMAKE_BUILD_TYPE MATCHES "Verify" )
    nora_cxx_preprocessor_global_add( NORA_VERIFY=1 )
    nora_cxx_preprocessor_global_add( NORA_PROFILE=1 )
    nora_cxx_preprocessor_global_add( NORA_DEBUG=1 )
endif()

# Debug property_mode?
if( CMAKE_BUILD_TYPE MATCHES "Debug" )
    nora_cxx_preprocessor_global_add( NORA_DEBUG=1 )
endif()

# Release property_mode?
if( CMAKE_BUILD_TYPE MATCHES "Release" )
    nora_cxx_preprocessor_global_add( NORA_RELEASE=1 )
endif()

# DLL Import
# TODO: VC++ dllXXX
if( Nora.Compiler STREQUAL MSVC )
    nora_log_info( "Using MSVC compatible dll linkage" )
    nora_global_set( Nora.Cxx.DLLImport "__declspec(dllimport)" )
    nora_global_set( Nora.Cxx.DLLExport "__declspec(dllexport)" )
    nora_global_set( Nora.Cxx.DLLIgnore "__declspec(dllexport)" )
else()
    if( Nora.Platform STREQUAL Windows )
        nora_log_info( "Using windows compatible dll linkage" )
        nora_global_set( Nora.Cxx.DLLExport "__attribute__ ((dllexport))" )
        nora_global_set( Nora.Cxx.DLLImport "__attribute__ ((dllimport))" )
        nora_global_set( Nora.Cxx.DLLIgnore "__attribute__ ((visibility (\"hidden\")))" )
    else()
        nora_log_info( "Using linux compatible dll linkage" )
        nora_global_set( Nora.Cxx.DLLExport "__attribute__ ((visibility (\"default\")))" )
        nora_global_set( Nora.Cxx.DLLImport "__attribute__ ((visibility (\"default\")))" )
        nora_global_set( Nora.Cxx.DLLIgnore "__attribute__ ((visibility (\"hidden\")))" )
    endif()
endif()

# Includes
include( ${NORA_PATH_BUILD}/cxx/nora.cxx.flags.cmake )
