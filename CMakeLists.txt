cmake_minimum_required(VERSION 3.1)

project(samp-plugin-mysql)

SET(MYSQL_PLUGIN_VERSION "R41-3")

option(BUILD_TESTS "Build tests" OFF)
option(SAMP_MYSQL_INCLUDE_PLUGIN "Build tests" OFF)
option(SAMP_MYSQL_USE_FOREIGN_EXTERNAL "Use foreign externals" ON)

# Base path constants
set(SAMP_MYSQL_ROOT ${CMAKE_CURRENT_SOURCE_DIR})
set(SAMP_MYSQL_BIN_ROOT ${CMAKE_BINARY_DIR})

# Externals
set(SAMP_MYSQL_EXTERNAL ${SAMP_MYSQL_ROOT}/external)
set(SAMP_MYSQL_EXTERNAL_BIN ${SAMP_MYSQL_BIN_ROOT}/external)

# Module
SET(CMAKE_MODULE_PATH
	${CMAKE_MODULE_PATH}
	${SAMP_MYSQL_ROOT}/build/cmake
	${SAMP_MYSQL_EXTERNAL}/sampcmake
)

if (NOT SAMP_STREAMER_USE_FOREIGN_EXTERNAL)
	include(External)
endif()

add_subdirectory(src)


