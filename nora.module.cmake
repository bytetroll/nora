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

cmake_minimum_required( VERSION 3.7 )

####
## Loads the build system and performs any needed configurations
####

enable_language( ASM )

# Assign build system
set( NORA_BUILD_SYSTEM ${NORA_ROOT}/nora/nora.cmake )

# Assign common paths
set( NORA_PATH_PIPELINE ${NORA_ROOT}/.pipeline/${CMAKE_BUILD_TYPE} )
set( NORA_PATH_EXTERN ${NORA_ROOT}/.external ) # Dependencies folder.
set( NORA_PATH_BUILD ${NORA_ROOT}/nora ) # this should go to a seperate pipeline folder.`
set(NORA_PATH_BUILD_CMAKE_CACHE ${CMAKE_BINARY_DIR})

string(SUBSTRING ${NORA_BUILD_SYSTEM} 0 3 NORA_BUILD_SYSTEM_DRIVE)
string(SUBSTRING ${NORA_PATH_BUILD_CMAKE_CACHE} 3 -1 NORA_PATH_BUILD_CMAKE_CACHE_DRIVELESS)
set(NORA_PATH_BUILD_CMAKE_CACHE "${NORA_BUILD_SYSTEM_DRIVE}${NORA_PATH_BUILD_CMAKE_CACHE_DRIVELESS}")