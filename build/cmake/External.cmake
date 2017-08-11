#################################################
# Boost lib settings
#################################################

if ("${BOOST_LIB_PATH}" STREQUAL "")
	# Set paths
	SET(BOOST_LIB_PATH ${SAMP_MYSQL_EXTERNAL}/boost)
endif()

##################################################
# AMXLib / sampsdk
##################################################

# SAMPSDK path
SET(SAMPSDK_DIR ${SAMP_MYSQL_EXTERNAL}/sampsdk)
set(SAMPSDK_INCLUDE_DIR ${SAMPSDK_DIR})

# Definitions
add_definitions(-DSAMPSDK_INCLUDE_DIR=${SAMPSDK_INCLUDE_DIR})
add_definitions(-DSAMPSDK_DIR=${SAMPSDK_DIR})

add_library(sampsdk 
	${SAMPSDK_DIR}/amxplugin.cpp
	${SAMPSDK_DIR}/amxplugin2.cpp
	${SAMPSDK_DIR}/plugin.h
	${SAMPSDK_DIR}/plugincommon.h
)

target_include_directories(sampsdk PUBLIC ${SAMPSDK_INCLUDE_DIR})
if (WIN32)
	target_compile_definitions(sampsdk PRIVATE WIN32)
else()
	target_include_directories(sampsdk PUBLIC ${SAMPSDK_INCLUDE_DIR}/amx)
	target_compile_definitions(sampsdk PRIVATE LINUX)
endif()

if(CMAKE_COMPILER_IS_GNUCC OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
	set_property(TARGET sampsdk APPEND_STRING PROPERTY COMPILE_FLAGS " -m32")
	set_property(TARGET sampsdk APPEND_STRING PROPERTY LINK_FLAGS    " -m32")
endif()

add_subdirectory(${SAMP_MYSQL_EXTERNAL}/mariadb)
add_subdirectory(${SAMP_MYSQL_EXTERNAL}/fmt)
add_subdirectory(${SAMP_MYSQL_EXTERNAL}/spdlog)

