#pragma once

#include <spdlog/spdlog.h>

class Log {
public:
	Log();

	std::shared_ptr<spdlog::logger> Handler();
	void Drop();

private:
	std::shared_ptr<spdlog::logger> m_log;
};

extern Log* gLog;
