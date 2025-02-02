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

include( ${NORA_PATH_BUILD}/toolchain/nora.toolchain.md.cmake )
nora_toolchain_md_prepare( TEMPLATE )

nora_toolchain_md_header( "${${LocalProject}.Name} - Report" )

nora_toolchain_md_text( "**Path:** `${${LocalPackage}.Dir}`" )
nora_toolchain_md_text( "**Build Path:** `${${${LocalProject}.Package}.BuildPath}`" )

# INSTALLED
nora_toolchain_md_header1( "Installed:" )
foreach( Var ${${LocalPackage}.Installed} )
    nora_toolchain_md_option( "`${Var}`" )
endforeach()

# DEFINES
nora_toolchain_md_header1( "Defines:" )
foreach( Var ${${LocalPackage}.AllDefines} )
    nora_toolchain_md_option( "`${Var}`" )
endforeach()

# DEPENDENCIES
nora_toolchain_md_header1( "Dependencies:" )
foreach( Var ${${LocalPackage}.Dependencies} )
    nora_toolchain_md_option( "`${Var}`" )
endforeach()

# INCLUDES
nora_toolchain_md_header1( "Include directories:" )
foreach( Var ${${LocalPackage}.IncludeDirs} )
    nora_toolchain_md_option( "`${Var}`" )
endforeach()

# INCLUDES
nora_toolchain_md_header1( "External Include directories:" )
nora_toolchain_md_text( "    (Exempt from diagnostics such as extra compiler warnings)" )
foreach( Var ${${LocalPackage}.ExternIncludeDirs} )
    nora_toolchain_md_option( "`${Var}`" )
endforeach()

# LINK INCLUDES
nora_toolchain_md_header1( "Link directories:" )
foreach( Var ${${LocalPackage}.LinkDirs} )
    nora_toolchain_md_option( "`${Var}`" )
endforeach()

# LINKS
nora_toolchain_md_header1( "Links:" )
foreach( Var ${${LocalPackage}.Links} )
    nora_toolchain_md_option( "`${Var}`" )
endforeach()

# SOURCES
nora_toolchain_md_header1( "Sources:" )
foreach( Var ${${LocalProject}.Sources} )
    nora_toolchain_md_option( "`${Var}`" )
endforeach()