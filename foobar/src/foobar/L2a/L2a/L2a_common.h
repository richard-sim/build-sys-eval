#ifndef L2a_H
#define L2a_H

#include <stdint.h>

#include "L2a_library_config.h"

L2a_API extern uint32_t L2a_common_variable;

L2a_API void L2a_common_void_function();
L2a_API uint32_t L2a_common_uint32_function();

L2a_API const char* L2a_common_get_name();

#endif // L2a_H
