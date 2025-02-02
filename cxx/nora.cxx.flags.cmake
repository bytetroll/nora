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