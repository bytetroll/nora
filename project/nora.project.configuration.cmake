# Copyright (C) 2008 - 2025 Execute Software, LLC.  All rights reserved.

# Configure all package
function( nora_project_configure_all )
    nora_log_event( "Configuring projects..." )

    # foreach project
    nora_log_info( "!! Ignore Warnings !!" )
    foreach( Project ${Nora.Projects} )
        set( ArchiveDir "${${Nora.Projects.${Project}.Package}.BuildPath}" )
        set( LibraryDir "${${Nora.Projects.${Project}.Package}.BuildPath}" )
        set( RuntimeDir "${${Nora.Projects.${Project}.Package}.BuildPath}" )

        # DHG file cutting
        string( LENGTH "${Nora.Projects.${Project}.Path}/" BaseLength )

        # Application Interface Path
        set( APIPath "${Nora.Projects.${Project}.Path}/.API.${Nora.Projects.${Project}.Name}" )

        # Virtuals do not have installed
        if( NOT "${Nora.Projects.${Project}.InstallType}" STREQUAL "VIRTUAL" )
            # Exec DHG support?
            unset( ExecDHG )
            if( "${Nora.Projects.${Project}.InstallType}" STREQUAL "EXEC" AND "Libraries.Reflection" IN_LIST ${Nora.Projects.${Project}.Package}.AllDependencies )
                set( ExecDHG ON )
            endif()

            # DHG for dynamic of executable targets
#            set( DHGAPIPath "${APIPath}/DHG.cpp" )
#            if( "${Nora.Projects.${Project}.InstallType}" STREQUAL "DYNAMIC" OR ExecDHG )
#                # write
#                if( NOT EXISTS "${DHGAPIPath}" )
#                    nora_writefile( "${DHGAPIPath}" "\#error Not generated" )
#                endif()
#            endif()

            # DHG Options
            set( DHGOptions "" )
#            if( WIN32 )
#                set( DHGOptions "-fconstexpr-depth=1024 -Os -w -s -g0 -fno-var-tracking -ffunction-sections -fdata-sections -Wa,-mbig-obj -fno-exceptions -DNORA_THROW=;" )
#            else()
#                set( DHGOptions "-fconstexpr-depth=1024 -Os -w -s -g0 -fno-var-tracking -ffunction-sections -fdata-sections" )
#            endif()

            # Find correct type and install final target
            if( "${Nora.Projects.${Project}.InstallType}" STREQUAL "DYNAMIC" )
#                set( PluginAPIPath "${APIPath}/Plugin.cpp" )

                # Plugin API Helper
                # TODO: Refactor this, move to a generated like format
#                set( PluginAPI "/* Generated file */\n" )
#                set( PluginAPI "${PluginAPI}#include <core/cxx.h>\n" )
#                set( PluginAPI "${PluginAPI}#include <Host/IRegistry.h>\n" )
#                set( PluginAPI "${PluginAPI}#include <Host/PluginAPI.h>\n" )
#                set( PluginAPI "${PluginAPI}#include <Platform/specification/LibraryMemoryHooks.h>\n\n" )
#                set( PluginAPI "${PluginAPI}NORA_C_EXPORT_${Nora.Projects.${Project}.PreprocessorName} Nora::COM::Result NORA_PLUGINAPI_INFO(Nora::Host::PluginInfo& out) {\n" )
#                set( PluginAPI "${PluginAPI}\tout.Description(\"${${Nora.Projects.${Project}.Package}.Desc}\");\n" )
#                set( PluginAPI "${PluginAPI}\tout.Name(\"${Nora.Projects.${Project}.Name}\");\n" )
#                foreach( Dep ${${Nora.Projects.${Project}.Package}.Dependencies} )
#                    if( "${Nora.Projects.${Dep}.InstallType}" STREQUAL "DYNAMIC" AND NOT "${Dep}" IN_LIST ${Nora.Projects.${Project}.Package}.LoadBefore )
#                        set( PluginAPI "${PluginAPI}\tout.AddDependency(Nora::Host::PluginDependencyMode::eAfter, \"${Dep}\");\n" )
#                    endif()
#                endforeach()
#                foreach( Dep ${${Nora.Projects.${Project}.Package}.LoadAfter} )
#                    set( PluginAPI "${PluginAPI}\tout.AddDependency(Nora::Host::PluginDependencyMode::eAfter, \"${Dep}\");\n" )
#                endforeach()
#                foreach( Dep ${${Nora.Projects.${Project}.Package}.LoadBefore} )
#                    set( PluginAPI "${PluginAPI}\tout.AddDependency(Nora::Host::PluginDependencyMode::eBefore, \"${Dep}\");\n" )
#                endforeach()
#                set( PluginAPI "${PluginAPI}\treturn Nora::COM::kOK;\n" )
#                set( PluginAPI "${PluginAPI}}\n\n/* */" )

                # write
#                nora_writefile( "${PluginAPIPath}" "${PluginAPI}" )

                # Custom DHG options
#                set_source_files_properties( ${DHGAPIPath} PROPERTIES COMPILE_FLAGS "${DHGOptions}" )

                # add lib
                # add_library( "${Nora.Projects.${Project}.Name}" SHARED ${Nora.Projects.${Project}.Sources} ${PluginAPIPath} ${DHGAPIPath} )
                add_library( "${Nora.Projects.${Project}.Name}" SHARED ${Nora.Projects.${Project}.Sources} )

                # remove symbols
                #nora_getobjectpath( ${Nora.Projects.${Project}.Name} ${DHGAPIPath} DHGObjPath )
                # nora_getobjectpath( ${Nora.Projects.${Project}.Name})
#                add_custom_command(
#                        TARGET "${Nora.Projects.${Project}.Name}" PRE_LINK
#                        COMMAND ${CMAKE_STRIP} --strip-unneeded -w -R *.pdata* -R *.xdata* "${DHGObjPath}"
#                )

#                add_custom_command(
#                        TARGET "${Nora.Projects.${Project}.Name}" PRE_LINK
#                        COMMAND ${CMAKE_STRIP} --strip-unneeded -w -R *.pdata* -R *.xdata*
#                )

                # Configure ends
                set_target_properties( "${Nora.Projects.${Project}.Name}" PROPERTIES PREFIX "" )
                set_target_properties( "${Nora.Projects.${Project}.Name}" PROPERTIES SUFFIX ".dll" )
                set_target_properties( "${Nora.Projects.${Project}.Name}" PROPERTIES IMPORT_PREFIX "" )
                set_target_properties( "${Nora.Projects.${Project}.Name}" PROPERTIES IMPORT_SUFFIX ".lib" )
            elseif( "${Nora.Projects.${Project}.InstallType}" STREQUAL "STATIC" )
                add_library( "${Nora.Projects.${Project}.Name}" STATIC ${Nora.Projects.${Project}.Sources} )

                # Configure ends
                set_target_properties( "${Nora.Projects.${Project}.Name}" PROPERTIES PREFIX "" )
                set_target_properties( "${Nora.Projects.${Project}.Name}" PROPERTIES SUFFIX ".lib" )
            elseif( "${Nora.Projects.${Project}.InstallType}" STREQUAL "EXEC" )
                if( ExecDHG )
                    # Custom DHG options
                    set_source_files_properties( ${DHGAPIPath} PROPERTIES COMPILE_FLAGS "${DHGOptions}" )

                    # ...
                    add_executable( "${Nora.Projects.${Project}.Name}" ${Nora.Projects.${Project}.Sources} ${DHGAPIPath} )

                    # remove symbols
                    nora_object_path_get( ${Nora.Projects.${Project}.Name} ${DHGAPIPath} DHGObjPath )
                    add_custom_command(
                            TARGET "${Nora.Projects.${Project}.Name}" PRE_LINK
                            COMMAND ${CMAKE_STRIP} --strip-unneeded -w -R *.pdata* -R *.xdata* "${DHGObjPath}"
                    )
                else()
                    nora_log_warning("About to add exe ${Nora.Projects.${Project}.Name} ${Nora.Projects.${Project}.Sources}")
                    add_executable( "${Nora.Projects.${Project}.Name}" ${Nora.Projects.${Project}.Sources} )
                endif()

                # Configure ends
                set_target_properties( "${Nora.Projects.${Project}.Name}" PROPERTIES PREFIX "" )
                set_target_properties( "${Nora.Projects.${Project}.Name}" PROPERTIES SUFFIX ".exe" )

                # Custom name
                set( CustomName "Z_Mirror.${Nora.Projects.${Project}.Name}" )

                # Deduce actual dependencies
                set( ActualDependencies "" )
                foreach( Dep ${${Nora.Projects.${Project}.Package}.AllDependencies} )
                endforeach()

                # Prepare external binaries
                set( ExternBinaries ${${Nora.Projects.${Project}.Package}.ExternBinaries} )
                foreach( Dep ${${Nora.Projects.${Project}.Package}.AllDependencies} )
                    if( "${Nora.Packages.${Dep}.InstalledType}" STREQUAL "DYNAMIC" )
                        list( APPEND ExternBinaries "${Nora.Packages.${Dep}.BuildPath}${Dep}.dll" )
                    endif()

                    if( ${Dep} IN_LIST Nora.Projects )
                        list( APPEND ActualDependencies ${Dep} )
                    endif()
                endforeach()
                set( ExternBinaries "${ExternBinaries}" )
                string( REPLACE ";" " '" ExternBinaries "${ExternBinaries}" )

                # Cmake is a bit odd on string pasting as arguments, so a workaround is needed
                if( NOT "${ActualDependencies}" STREQUAL "" )
                    add_custom_target(
                            "${CustomName}"
                            ALL COMMAND ${CMAKE_COMMAND} -DPROJECT="${Nora.Projects.${Project}.Path}" -DBINARIES="${ExternBinaries}" -DPIPELINE="${NORA_PATH_PIPELINE}" -DOUTPUT="${${Nora.Projects.${Project}.Package}.BuildPath}" -P "${NORA_PATH_BUILD}/toolchain/nora.toolchain.executable.post.cmake"
                            DEPENDS ${ActualDependencies}
                    )
                else()
                    add_custom_target(
                            "${CustomName}"
                            ALL COMMAND ${CMAKE_COMMAND} -DPROJECT="${Nora.Projects.${Project}.Path}" -DBINARIES="${ExternBinaries}" -DPIPELINE="${NORA_PATH_PIPELINE}" -DOUTPUT="${${Nora.Projects.${Project}.Package}.BuildPath}" -P "${NORA_PATH_BUILD}/toolchain/nora.toolchain.executable.post.cmake"
                    )
                endif()

                # Configure post processing dependencies
                add_dependencies( "${Nora.Projects.${Project}.Name}" "${CustomName}" )
            else()
                nora_log_error( "Could not install project ${Nora.Projects.${Project}.Name}, unknown option '${Nora.Projects.${Project}.InstallType}'" )
            endif()


            if( EXISTS "${Nora.Projects.${Project}.Path}/Runtime" )
                # Runtime virtual file system
                file( WRITE "${NORA_PATH_PIPELINE}/Runtime/${Project}.dvrf" "Runtime:${Nora.Projects.${Project}.Path}/Runtime" )
            endif()

            # Install name
            set_target_properties( ${Nora.Projects.${Project}.Name} PROPERTIES OUTPUT_NAME "${Nora.Projects.${Project}.InstallName}" )

            # Set flags
            #set_target_properties(
            #        "${Nora.Projects.${project}.Name}"
            #        PROPERTIES
            #        COMPILE_FLAGS "${Nora.Projects.${project}.CxxFlags} ${Nora.Projects.${project}.CFlags}"
            #        LINK_FLAGS "${Nora.Projects.${project}.LinkerFlags}"
            #)

            message( "Setting target properties on ${Nora.Projects.${Project}.Name}" )
            set_target_properties( "${Nora.Projects.${Project}.Name}" PROPERTIES
                    CXX_STANDARD 17
                    CXX_STANDARD_REQUIRED YES
            )

            #target_compile_features("${Nora.Projects.${project}.Name}" PUBLIC cxx_std_14)
            set_target_properties(
                    "${Nora.Projects.${Project}.Name}" PROPERTIES COMPILE_FLAGS
                    "${Nora.Projects.${Project}.CxxFlags} ${Nora.Projects.${Project}.CFlags} ${Nora.Projects.${Project}.LinkerFlags} -Wl,--gc-sections"
            )
            target_link_libraries( "${Nora.Projects.${Project}.Name}" INTERFACE "${Nora.Projects.${Project}.LinkerFlags} -Wl,--gc-sections" )

            #target_compile_options(
            #        "${Nora.Projects.${project}.Name}" PUBLIC
            #        ${Nora.Projects.${project}.CxxFlags}
            #        ${Nora.Projects.${project}.CFlags}
            #        ${Nora.Projects.${project}.LinkerFlags}
            #)

            # TODO: Experimental
            set_property( TARGET "${Nora.Projects.${Project}.Name}" PROPERTY LINK_DEPENDS_NO_SHARED 1 )

            # Configure destination
            set_target_properties(
                    "${Nora.Projects.${Project}.Name}"
                    PROPERTIES
                    ARCHIVE_OUTPUT_DIRECTORY "${ArchiveDir}"
                    LIBRARY_OUTPUT_DIRECTORY "${LibraryDir}"
                    RUNTIME_OUTPUT_DIRECTORY "${RuntimeDir}"
            )

            # ...
            nora_global_set( ${Nora.Projects.${Project}.Package}.AllDefines
                    NORA_API_${Nora.Projects.${Project}.PreprocessorName}

                    # Paths (Useful for build tools)
                    "NORA_PATH_PIPELINE=\"${NORA_PATH_PIPELINE}\""
                    "NORA_PATH_EXTERN=\"${NORA_PATH_EXTERN}\""
                    "NORA_PATH_BUILD=\"${NORA_PATH_BUILD}\""

                    # Internal export
                    "NORA_EXPORT=${Nora.Cxx.DLLExport}"
                    "NORA_IMPORT=${Nora.Cxx.DLLImport}"
                    "NORA_NOEXPORT=${Nora.Cxx.DLLIgnore}"
                    "NORA_EXPORT_${Nora.Projects.${Project}.PreprocessorName}=${Nora.Cxx.DLLExport}"
                    "NORA_C_EXPORT_${Nora.Projects.${Project}.PreprocessorName}=extern \"C\" ${Nora.Cxx.DLLExport}"

                    # Exception handling
                    "NORA_THROW=throw"

                    # platform Specific
                    ${Nora.Platform.${Nora.Platform}.Preprocessors}
                    NORA_PLATFORM_${Nora.Platform.Uppercase}

                    # compiler specific
                    NORA_COMPILER_${Nora.Compiler.Uppercase}
                    ${Nora.Compiler.Preprocessors}

                    # core
                    ${Nora.Cxx.Preprocessors}

                    # Defines
                    ${${Nora.Projects.${Project}.Package}.Defines}
                    )

            # remove duplicates
            set( IndexMap "" )
            set( DefineCopy "" )
            foreach( Define ${${Nora.Projects.${Project}.Package}.AllDefines} )
                string( FIND ${Define} "=" EQINDEX )
                if( NOT ${EQINDEX} EQUAL -1 )
                    string( SUBSTRING ${Define} 0 ${EQINDEX} DEFNAME )
                    if( NOT ${DEFNAME} IN_LIST IndexMap )
                        list( APPEND DefineCopy ${Define} )
                        list( APPEND IndexMap ${DEFNAME} )
                    endif()
                elseif( NOT ${Define} IN_LIST DefineCopy )
                    list( APPEND DefineCopy ${Define} )
                endif()
            endforeach()
            nora_global_set( ${Nora.Projects.${Project}.Package}.AllDefines ${DefineCopy} )

            # Preprocessors
            target_compile_definitions(
                    "${Nora.Projects.${Project}.Name}"

                    # Locals
                    PRIVATE ${${Nora.Projects.${Project}.Package}.AllDefines}
            )

            # Header Generation
            if( "${Nora.Projects.${Project}.InstallType}" STREQUAL "DYNAMIC" OR ExecDHG )
                # set( DHGConfigPath "${APIPath}/.dhg" )

                # Setup DHG config file
#                set( DHGConfig "" )
#                set( DHGConfig "${DHGConfig}${Nora.Projects.${Project}.Name}\n" )
#                set( DHGConfig "${DHGConfig}${APIPath}\n" )
#                set( DHGConfig "${DHGConfig}#include\n" )
#                foreach( Define ${${Nora.Projects.${Project}.Package}.IncludeDirs} ${Nora.Projects.${Project}.Path}
#                        ${${Nora.Projects.${Project}.Package}.ExternIncludeDirs} ${CMAKE_EXTRA_GENERATOR_CXX_SYSTEM_INCLUDE_DIRS}
#                        ${CMAKE_EXTRA_GENERATOR_C_SYSTEM_INCLUDE_DIRS} )
#                    set( DHGConfig "${DHGConfig}${Define}\n" )
#                endforeach()
#                set( DHGConfig "${DHGConfig}#preprocessor\n" )
#                foreach( Define ${${Nora.Projects.${Project}.Package}.AllDefines} )
#                    set( DHGConfig "${DHGConfig}${Define}\n" )
#                endforeach()
#                set( Index 0 )
#                list( LENGTH CMAKE_EXTRA_GENERATOR_C_SYSTEM_DEFINED_MACROS Length )
#                while( ${Index} LESS ${Length} )
#                    math( EXPR Index2 "${Index} + 1" )
#                    list( GET CMAKE_EXTRA_GENERATOR_C_SYSTEM_DEFINED_MACROS ${Index} Name )
#                    list( GET CMAKE_EXTRA_GENERATOR_C_SYSTEM_DEFINED_MACROS ${Index2} Value )
#                    if( "${Value}" STREQUAL " " OR "${Value}" STREQUAL "" )
#                        set( Value "1" )
#                    endif()
#                    set( DHGConfig "${DHGConfig}${Name}=${Value}\n" )
#                    math( EXPR Index "${Index} + 2" )
#                endwhile()
#                set( DHGConfig "${DHGConfig}#header\n" )
#                foreach( Source ${Nora.Projects.${Project}.Sources} )
#                    if( ${Source} MATCHES "\\.(h|H|(h|H)(p|P)(p|P))$" )
#                        string( SUBSTRING ${Source} ${BaseLength} -1 Source )
#                        set( DHGConfig "${DHGConfig}${Source}\n" )
#                    endif()
#                endforeach()

                # write
                # nora_writefile( "${DHGConfigPath}" "${DHGConfig}" )

                # DHG Target name
                set( CustomName "Z_DHG.${Nora.Projects.${Project}.Name}" )

                # May be externally built
#                set( ToolsDependencies "" )
#                if( "Tools.DHG" IN_LIST Nora.Projects )
#                    set( ToolsDependencies "Tools.DHG" )
#                endif()

                # DHG Pass
#                add_custom_target(
#                        ${CustomName}
#                        ALL COMMAND "${NORA_PATH_PIPELINE}/Tools.DHG.exe" "${DHGConfigPath}"
#                        #DEPENDS ${${Nora.Projects.${project}.Package}.Dependencies}
#                        DEPENDS ${ToolsDependencies}
#                        WORKING_DIRECTORY "${Nora.Projects.${Project}.Path}"
#                )

                # Configure post processing dependencies
                # add_dependencies( "${Nora.Projects.${Project}.Name}" "${CustomName}" )
                # add_dependencies( "${Nora.Projects.${Project}.Name}" )
            endif()
        else()
            # Dummy target
            add_library( "${Nora.Projects.${Project}.Name}" INTERFACE )
            #add_custom_target("${Nora.Projects.${project}.Name}")
        endif()
    endforeach()
    nora_log_info( "!! /Ignore Warnings !!" )

    # foreach project
    foreach( Project ${Nora.Projects} )
        # Apply deps
        if( "${Nora.Projects.${Project}.InstallType}" STREQUAL "DYNAMIC" OR ExecDHG )
        else()
            foreach( Dep ${${Nora.Projects.${Project}.Package}.Dependencies} )
                # Is target?
                if( ${Dep} IN_LIST Nora.Projects )
                    add_dependencies( "${Nora.Projects.${Project}.Name}" "${Dep}" )
                endif()
            endforeach()
        endif()

        if( NOT "${Nora.Projects.${Project}.InstallType}" STREQUAL "VIRTUAL" )
            # Set linker language
            set_target_properties( "${Nora.Projects.${Project}.Name}" PROPERTIES LINKER_LANGUAGE CXX )

            # Apply
            if( NOT "${${Nora.Projects.${Project}.Package}.IncludeDirs}" STREQUAL "" )
                target_include_directories( "${Nora.Projects.${Project}.Name}" PUBLIC ${${Nora.Projects.${Project}.Package}.IncludeDirs} ${Nora.Projects.${Project}.Path} )
            endif()
            if( NOT "${${Nora.Projects.${Project}.Package}.ExternIncludeDirs}" STREQUAL "" )
                target_include_directories( "${Nora.Projects.${Project}.Name}" SYSTEM PUBLIC ${${Nora.Projects.${Project}.Package}.ExternIncludeDirs} )
            endif()
            if( NOT "${${Nora.Projects.${Project}.Package}.LinkDirs}" STREQUAL "" )
                # link_directories("${Nora.Projects.${project}.Name}" PUBLIC ${${Nora.Projects.${project}.Package}.LinkDirs})
            endif()
            if( NOT "${${Nora.Projects.${Project}.Package}.Links}" STREQUAL "" )
                set( Libs "" )
                foreach( DepLib ${${Nora.Projects.${Project}.Package}.Links} )
                    if( NOT ${DepLib} IN_LIST Nora.Projects )
                        find_library( ${DepLib}.FoundPath NAMES "${DepLib}" PATHS ${${Nora.Projects.${Project}.Package}.LinkDirs} )
                        if( ${DepLib}.FoundPath STREQUAL "${DepLib}.FoundPath-NOTFOUND" )
                            nora_log_error( "Project ${Project} failed to find library: '${DepLib}'\nAttempted to search in:\n${${Nora.Projects.${Project}.Package}.LinkDirs}" )
                        endif()
                        list( APPEND Libs ${${DepLib}.FoundPath} )
                    else()
                        # core resolves in house dependencies!
                        list( APPEND Libs ${DepLib} )
                    endif()
                endforeach()
                target_link_libraries( "${Nora.Projects.${Project}.Name}" PUBLIC ${Libs} )
                #target_link_libraries("${Nora.Projects.${project}.Name}" PUBLIC ${${Nora.Projects.${project}.Package}.Links})
            endif()
            if( NOT "${${Nora.Projects.${Project}.Package}.ExternLinks}" STREQUAL "" )
                target_link_libraries( "${Nora.Projects.${Project}.Name}" PUBLIC ${${Nora.Projects.${Project}.Package}.ExternLinks} )
            endif()

            # Additional links
            if( Nora.Platform STREQUAL Linux )
                target_link_libraries( "${Nora.Projects.${Project}.Name}" PUBLIC -ldl -pthread )
            endif()
        endif()

        # Create common file
        set( LocalProject Nora.Projects.${Project} )
        set( LocalPackage ${Nora.Projects.${Project}.Package} )
        set( TEMPLATE "" )
        # file(READ "${NORA_PATH_BUILD}/project/template/project.md" TMPL_PROJECTMD)
        include( ${NORA_PATH_BUILD}/project/template/nora.project.template.readme.cmake )
        # string(REPLACE "{NAME}" "${SAFE_DEFINE}" TMPL_PROJECTMD "${TMPL_PROJECTMD}")
        file( WRITE "${Nora.Projects.${Project}.Path}/${Nora.Projects.${Project}.Name}.config.md" "${TEMPLATE}" )

        # ...
        nora_log_info( "Configured project: ${Project}" )
    endforeach()

    # Build all project
    add_custom_target( "All" DEPENDS ${Nora.Projects} )

    # ...
    nora_log_info( "Projects configured!" )
endfunction(nora_project_configure_all)