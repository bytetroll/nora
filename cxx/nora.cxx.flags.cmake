# Copyright (C) 2008 - 2025 Execute Software, LLC.  All rights reserved.

# Reset flags
macro( nora_cxx_flags_set OUT_CXX OUT_C OUT_LINKER BUILD_TYPE )
    # Defaults
    # Note: On GCC compiler =gnu++17 is used instead of std++17 for extensions
    nora_global_set( ${OUT_CXX} "-std=gnu++17 -W -fPIC -msse -msse2 -msse3 -mmmx" )
    nora_global_set( ${OUT_LINKER} "-fPIC" )

    # Configuration types

    # append build architecture
    if( CMAKE_BUILD_TYPE MATCHES "64" )
        nora_global_set( ${OUT_CXX} "${${OUT_CXX}} -m64 " )
        nora_global_set( ${OUT_C} "${CMAKE_C_FLAGS} -m64 " )
    else()
        # ...
    endif()

    # Warning Flags
    # Note: "-Wduplicated-branches" was removed due to incorrect behaviour
    #set(CXX_WARNING_FLAGS "")
    # -Werror = warnings as errors
    nora_global_set( CXX_WARNING_FLAGS "-Wall -Wextra -Wduplicated-cond -Wlogical-op -Wnull-dereference -Wformat=0 -Wno-unused-function -Wno-reorder -Wold-style-cast -Wno-maybe-uninitialized -Wno-unused-parameter -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-but-set-parameter -Wno-null-dereference" )

    # Set intermediate flags
    if( ${BUILD_TYPE} MATCHES "Debug" )
        nora_global_set( ${OUT_CXX} "${${OUT_CXX}} -g -O0 -DDEBUG ${CXX_WARNING_FLAGS}" )
        nora_global_set( ${OUT_LINKER} "${${OUT_LINKER}} -g" )
    elseif( ${BUILD_TYPE} MATCHES "Verify" )
        nora_global_set( ${OUT_CXX} "${${OUT_CXX}} -g -O0 -DDEBUG ${CXX_WARNING_FLAGS} -fsanitize=address -fno-omit-frame-pointer" )
        nora_global_set( ${OUT_LINKER} "${${OUT_LINKER}} -g -fsanitize=address" )
    elseif( ${BUILD_TYPE} MATCHES "Release" )
        nora_global_set( ${OUT_CXX} "${${OUT_CXX}} -O3 -s ${CXX_WARNING_FLAGS}" )
        nora_global_set( ${OUT_LINKER} "${${OUT_LINKER}} -s" )
    elseif( ${BUILD_TYPE} MATCHES "Profile" )
        nora_global_set( ${OUT_CXX} "${${OUT_CXX}} -O3 -g ${CXX_WARNING_FLAGS}" )
        nora_global_set( ${OUT_LINKER} "${${OUT_LINKER}} -O3 -g" )
    endif()
endmacro(nora_cxx_flags_set)