#ifndef L0a_H
#define L0a_H

#include <stdint.h>

#include "L0a_library_config.h"

L0a_API extern uint32_t L0a_common_variable;

L0a_API void L0a_common_void_function();
L0a_API uint32_t L0a_common_uint32_function();

L0a_API const char* L0a_common_get_name();

#endif // L0a_H
