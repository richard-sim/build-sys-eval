#ifndef TPa_H
#define TPa_H

#include <stdint.h>

#include "TPa_library_config.h"

TPa_API uint32_t TPa_common_variable;

TPa_API void TPa_common_void_function();
TPa_API uint32_t TPa_common_uint32_function();

TPa_API const char* TPa_common_get_name();

#endif // TPa_H
