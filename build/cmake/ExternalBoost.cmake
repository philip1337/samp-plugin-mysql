# Output directories
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/build/library)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/build/library)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/build/binary)

SET(BOOST_SRC_LIB_PATH ${BOOST_LIB_PATH}/libs)

#################################
# Boost library
#################################
add_library(boost INTERFACE)

target_include_directories(
    boost
    INTERFACE
    "$<BUILD_INTERFACE:${BOOST_LIB_PATH}>"
    "$<INSTALL_INTERFACE:include>"
)

#################################
# System
#################################
SET(BOOST_SYSTEM_FILES
	${BOOST_SRC_LIB_PATH}/system/src/error_code.cpp
)

add_library(
	boost-system-lib
	${BOOST_SYSTEM_FILES}
)

target_include_directories(boost-system-lib PRIVATE ${BOOST_LIB_PATH})

#################################
# Chrono
#################################
SET(BOOST_CHRONO_FILES
	${BOOST_SRC_LIB_PATH}/chrono/src/chrono.cpp
	${BOOST_SRC_LIB_PATH}/chrono/src/process_cpu_clocks.cpp
	${BOOST_SRC_LIB_PATH}/chrono/src/thread_clock.cpp
)

add_library(
	boost-chrono-lib
	${BOOST_CHRONO_FILES}
)

target_include_directories(boost-chrono-lib PRIVATE ${BOOST_LIB_PATH})

#################################
# Filesystem
#################################
SET(BOOST_FS_FILES
	${BOOST_SRC_LIB_PATH}/filesystem/src/codecvt_error_category.cpp
	${BOOST_SRC_LIB_PATH}/filesystem/src/operations.cpp
	${BOOST_SRC_LIB_PATH}/filesystem/src/path.cpp
	${BOOST_SRC_LIB_PATH}/filesystem/src/path_traits.cpp
	${BOOST_SRC_LIB_PATH}/filesystem/src/portability.cpp
	${BOOST_SRC_LIB_PATH}/filesystem/src/unique_path.cpp
	${BOOST_SRC_LIB_PATH}/filesystem/src/utf8_codecvt_facet.cpp
	${BOOST_SRC_LIB_PATH}/filesystem/src/windows_file_codecvt.cpp
	${BOOST_SRC_LIB_PATH}/filesystem/src/windows_file_codecvt.hpp
)

add_library(
	boost-filesystem-lib
	${BOOST_FS_FILES}
)

target_include_directories(boost-filesystem-lib PRIVATE ${BOOST_LIB_PATH})

target_compile_definitions(
	boost-filesystem-lib
	PRIVATE
	BOOST_ALL_NO_LIB
	BOOST_CHRONO_HEADER_ONLY
)

#################################
# iostreams
#################################
SET(BOOST_IOSTREAMS_FILES
	${BOOST_SRC_LIB_PATH}/iostreams/src/bzip2.cpp
	${BOOST_SRC_LIB_PATH}/iostreams/src/file_descriptor.cpp
	${BOOST_SRC_LIB_PATH}/iostreams/src/gzip.cpp
	${BOOST_SRC_LIB_PATH}/iostreams/src/mapped_file.cpp
	${BOOST_SRC_LIB_PATH}/iostreams/src/zlib.cpp
)

#add_library(
#	boost-iostreams-lib
#	${BOOST_IOSTREAMS_FILES}
#)

#target_include_directories(boost-iostreams-lib PRIVATE ${BOOST_LIB_PATH})

#################################
# program_options
#################################
SET(BOOST_PO_FILES
	${BOOST_SRC_LIB_PATH}/program_options/src/cmdline.cpp
	${BOOST_SRC_LIB_PATH}/program_options/src/config_file.cpp
	${BOOST_SRC_LIB_PATH}/program_options/src/convert.cpp
	${BOOST_SRC_LIB_PATH}/program_options/src/options_description.cpp
	${BOOST_SRC_LIB_PATH}/program_options/src/parsers.cpp
	${BOOST_SRC_LIB_PATH}/program_options/src/positional_options.cpp
	${BOOST_SRC_LIB_PATH}/program_options/src/split.cpp
	${BOOST_SRC_LIB_PATH}/program_options/src/utf8_codecvt_facet.cpp
	${BOOST_SRC_LIB_PATH}/program_options/src/value_semantic.cpp
	${BOOST_SRC_LIB_PATH}/program_options/src/variables_map.cpp
	${BOOST_SRC_LIB_PATH}/program_options/src/winmain.cpp
)

add_library(
	boost-po-lib
	${BOOST_PO_FILES}
)

target_compile_definitions(boost-po-lib PRIVATE _CPPUNWIND)
target_include_directories(boost-po-lib PRIVATE ${BOOST_LIB_PATH})


#################################
# python
#################################
SET(BOOST_PYTHON_FILES
	${BOOST_SRC_LIB_PATH}/python/src/dict.cpp
	${BOOST_SRC_LIB_PATH}/python/src/errors.cpp
	${BOOST_SRC_LIB_PATH}/python/src/exec.cpp
	${BOOST_SRC_LIB_PATH}/python/src/import.cpp
	${BOOST_SRC_LIB_PATH}/python/src/list.cpp
	${BOOST_SRC_LIB_PATH}/python/src/long.cpp
	${BOOST_SRC_LIB_PATH}/python/src/module.cpp
	${BOOST_SRC_LIB_PATH}/python/src/numeric.cpp
	${BOOST_SRC_LIB_PATH}/python/src/object_operators.cpp
	${BOOST_SRC_LIB_PATH}/python/src/object_protocol.cpp
	${BOOST_SRC_LIB_PATH}/python/src/slice.cpp
	${BOOST_SRC_LIB_PATH}/python/src/str.cpp
	${BOOST_SRC_LIB_PATH}/python/src/tuple.cpp
	${BOOST_SRC_LIB_PATH}/python/src/wrapper.cpp
	${BOOST_SRC_LIB_PATH}/python/src/object/class.cpp
	${BOOST_SRC_LIB_PATH}/python/src/object/enum.cpp
	${BOOST_SRC_LIB_PATH}/python/src/object/function.cpp
	${BOOST_SRC_LIB_PATH}/python/src/object/function_doc_signature.cpp
	${BOOST_SRC_LIB_PATH}/python/src/object/inheritance.cpp
	${BOOST_SRC_LIB_PATH}/python/src/object/iterator.cpp
	${BOOST_SRC_LIB_PATH}/python/src/object/life_support.cpp
	${BOOST_SRC_LIB_PATH}/python/src/object/pickle_support.cpp
	${BOOST_SRC_LIB_PATH}/python/src/object/stl_iterator.cpp
	${BOOST_SRC_LIB_PATH}/python/src/converter/arg_to_python_base.cpp
	${BOOST_SRC_LIB_PATH}/python/src/converter/builtin_converters.cpp
	${BOOST_SRC_LIB_PATH}/python/src/converter/from_python.cpp
	${BOOST_SRC_LIB_PATH}/python/src/converter/registry.cpp
	${BOOST_SRC_LIB_PATH}/python/src/converter/type_id.cpp
)

#add_library(
#	boost-python-lib
#	${BOOST_PYTHON_FILES}
#)

#target_include_directories(boost-python-lib PRIVATE ${BOOST_LIB_PATH})

#################################
# thread
#################################
SET(BOOST_THREAD_FILES
	${BOOST_SRC_LIB_PATH}/thread/src/tss_null.cpp
	${BOOST_SRC_LIB_PATH}/thread/src/future.cpp
)

if (WIN32)
	SET(BOOST_THREAD_FILES
		${BOOST_THREAD_FILES}
		${BOOST_SRC_LIB_PATH}/thread/src/win32/thread.cpp
		${BOOST_SRC_LIB_PATH}/thread/src/win32/tss_dll.cpp
		${BOOST_SRC_LIB_PATH}/thread/src/win32/tss_pe.cpp
	)
else()
	SET(BOOST_THREAD_FILES
		${BOOST_THREAD_FILES}
		${BOOST_SRC_LIB_PATH}/thread/src/pthread/once.cpp
		${BOOST_SRC_LIB_PATH}/thread/src/pthread/once_atomic.cpp
		${BOOST_SRC_LIB_PATH}/thread/src/pthread/thread.cpp
	)
endif()

#add_library(
#	boost-thread-lib
#	${BOOST_THREAD_FILES}
#)

#target_include_directories(boost-thread-lib PRIVATE ${BOOST_LIB_PATH})

#################################
# timer
#################################
SET(BOOST_TIMER_FILES
	${BOOST_SRC_LIB_PATH}/timer/src/auto_timers_construction.cpp
	${BOOST_SRC_LIB_PATH}/timer/src/cpu_timer.cpp
)

add_library(
	boost-timer-lib
	${BOOST_TIMER_FILES}
)

target_include_directories(boost-timer-lib PRIVATE ${BOOST_LIB_PATH})
