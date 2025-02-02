# Copyright (C) 2008 - 2025 Execute Software, LLC.  All rights reserved.

####
## Prepares the internal project system
####

# project List
set( Nora.Projects "" CACHE INTERNAL "" FORCE )

# Includes
include( ${NORA_PATH_BUILD}/project/nora.project.cmake )
include( ${NORA_PATH_BUILD}/project/nora.project.configuration.cmake )