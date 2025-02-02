# Copyright (C) 2008 - 2025 Execute Software, LLC.  All rights reserved.

# Detect the current core
if( "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang" )
    nora_global_set( Nora.Compiler "CLANG" )
elseif( "${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU" )
    nora_global_set( Nora.Compiler "GNU" )
elseif( "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel" )
    nora_global_set( Nora.Compiler "Intel" )
elseif( "${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC" )
    nora_global_set( Nora.Compiler "MSVC" )
endif()

# To uppercase
nora_global_set( TOUPPER ${Nora.Compiler} Nora.Compiler.Uppercase )

# Default preprocessors
nora_global_set( Nora.Compiler.Preprocessors "" )