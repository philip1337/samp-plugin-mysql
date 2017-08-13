#pragma once

#ifdef WIN32
# include <WinSock2.h>
# undef ERROR
#endif

#include <mysql.h>
#ifdef rest
	#undef rest
#endif
