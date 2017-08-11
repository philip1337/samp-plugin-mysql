#include "CLog.hpp"

Log* gLog = nullptr;

Log::Log() {
	size_t q_size = 4096;
	spdlog::set_async_mode(q_size);
	m_log = spdlog::basic_logger_mt("async_file_logger", "mysql.log");
	m_log->flush_on(spdlog::level::err);
}

std::shared_ptr<spdlog::logger> Log::Handler() {
	return m_log;
}

void Log::Drop() {
	spdlog::drop_all();
}