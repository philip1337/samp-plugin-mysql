include(AMXConfig)
include(AddSAMPPlugin)

set(MYSQL_PLUGIN_CONFIG_INCLUDE_DIR "${CMAKE_CURRENT_BINARY_DIR}/config_headers")
include_directories(
	${SAMPSDK_INCLUDE_DIR}
	${MYSQL_PLUGIN_CONFIG_INCLUDE_DIR}
)

configure_file(
	"../include/a_mysql.inc.in"
	"include/a_mysql.inc"
	@ONLY
)

configure_file(
	"version.hpp.in"
	"${MYSQL_PLUGIN_CONFIG_INCLUDE_DIR}/version.hpp"
	@ONLY
)

if (SAMP_MYSQL_INCLUDE_PLUGIN)
	add_samp_plugin(mysql 
		CCallback.cpp
		CCallback.hpp
		CConnection.cpp
		CConnection.hpp
		CDispatcher.cpp
		CDispatcher.hpp
		CError.hpp
		CHandle.cpp
		CHandle.hpp
		CLog.cpp
		CLog.hpp
		COptions.cpp
		COptions.hpp
		COrm.cpp
		COrm.hpp
		CQuery.cpp
		CQuery.hpp
		CResult.cpp
		CResult.hpp
		natives.cpp
		natives.hpp
		CSingleton.hpp
		main.cpp
		misc.hpp
		mysql.hpp
		sdk.hpp
		types.hpp
		plugin.def
	)

	target_compile_features(mysql PUBLIC 
		cxx_auto_type 
		cxx_decltype 
		cxx_defaulted_functions 
		cxx_default_function_template_args
		cxx_delegating_constructors
		cxx_deleted_functions
		cxx_enum_forward_declarations
		cxx_explicit_conversions
		cxx_extended_friend_declarations
		cxx_lambdas
		cxx_inheriting_constructors
		cxx_noexcept
		cxx_nonstatic_member_init
		cxx_nullptr
		cxx_range_for
		cxx_reference_qualified_functions
		cxx_right_angle_brackets
		cxx_rvalue_references
		cxx_strong_enums
		cxx_variadic_templates
	)

	add_dependencies(mysql spdlog fmt sampsdk mariadbclient)

	if(MSVC)
		add_definitions(-D_CRT_SECURE_NO_WARNINGS -DNOMINMAX -D_ENABLE_ATOMIC_ALIGNMENT_FIX)
	endif()

	target_link_libraries(mysql spdlog fmt sampsdk 
		mariadbclient
		boost::system 
		boost::any
		boost::spirit
		boost::variant
		boost::lockfree
	)

	if(UNIX)
		if(NOT APPLE)
			target_link_libraries(mysql rt)
		endif()
		
		set_target_properties(mysql PROPERTIES
			INSTALL_RPATH "$ORIGIN/..:$ORIGIN/")
	endif()

	# MySQL
	target_include_directories(mysql 
		PRIVATE 
			${SAMP_MYSQL_EXTERNAL}/mariadb/include
			${SAMP_MYSQL_EXTERNAL_BIN}/mariadb/include
	)

	target_compile_definitions(
		mysql
		PRIVATE
	)

	install(TARGETS mysql DESTINATION "plugins/")
	install(FILES "${CMAKE_CURRENT_BINARY_DIR}/include/a_mysql.inc" DESTINATION "pawno/include/")
	install(FILES "${PROJECT_SOURCE_DIR}/LICENSE" DESTINATION "./")
	if(WIN32 AND MYSQLCAPI_LIBRARY_SHARED)
		install(FILES "${MYSQLCAPI_LIBRARY_SHARED}" DESTINATION "./")
	endif()
endif()

##########################
# blueg lib
#########################

add_library(samp-plugin-mysql-lib
	CCallback.cpp
	CCallback.hpp
	CConnection.cpp
	CConnection.hpp
	CDispatcher.cpp
	CDispatcher.hpp
	CError.hpp
	CHandle.cpp
	CHandle.hpp
	CLog.cpp
	CLog.hpp
	COptions.cpp
	COptions.hpp
	COrm.cpp
	COrm.hpp
	CQuery.cpp
	CQuery.hpp
	CResult.cpp
	CResult.hpp
	natives.cpp
	natives.hpp
	CSingleton.hpp
	misc.hpp
	mysql.hpp
	sdk.hpp
	types.hpp
)

target_compile_features(samp-plugin-mysql-lib PUBLIC 
	cxx_auto_type 
	cxx_decltype 
	cxx_defaulted_functions 
	cxx_default_function_template_args
	cxx_delegating_constructors
	cxx_deleted_functions
	cxx_enum_forward_declarations
	cxx_explicit_conversions
	cxx_extended_friend_declarations
	cxx_lambdas
	cxx_inheriting_constructors
	cxx_noexcept
	cxx_nonstatic_member_init
	cxx_nullptr
	cxx_range_for
	cxx_reference_qualified_functions
	cxx_right_angle_brackets
	cxx_rvalue_references
	cxx_strong_enums
	cxx_variadic_templates
)

add_dependencies(samp-plugin-mysql-lib spdlog fmt sampsdk mariadbclient)

if(MSVC)
	add_definitions(-D_CRT_SECURE_NO_WARNINGS -DNOMINMAX -D_ENABLE_ATOMIC_ALIGNMENT_FIX)
endif()

target_link_libraries(samp-plugin-mysql-lib 
	spdlog 
	fmt 
	sampsdk 
	mariadbclient 
	boost::system 
	boost::any
	boost::spirit
	boost::variant
	boost::lockfree
)

if(UNIX)
	if(NOT APPLE)
		target_link_libraries(samp-plugin-mysql-lib rt)
	endif()
endif()

target_include_directories(samp-plugin-mysql-lib 
	PRIVATE 
		${MARIADB_EXTERNAL_INCLUDE}
		${MARIADB_EXTERNAL_INCLUDE_BIN}
	PUBLIC
		${CMAKE_CURRENT_SOURCE_DIR}
)


# Plattform specified definitions
if (WIN32)
	target_compile_definitions(
		samp-plugin-mysql-lib
		PRIVATE
		NOMINMAX
		WIN32
	)
else()
	target_compile_definitions(
		samp-plugin-mysql-lib
		PRIVATE
		LINUX
		NDEBUG
	)
endif()	

