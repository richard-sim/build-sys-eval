#ifndef TPd_H
#define TPd_H

#include <stdint.h>

#include "TPd_library_config.h"

TPd_API uint32_t TPd_common_variable;

TPd_API void TPd_common_void_function();
TPd_API uint32_t TPd_common_uint32_function();

TPd_API const char* TPd_common_get_name();

#endif // TPd_H
