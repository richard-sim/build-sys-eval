#ifndef L1a_H
#define L1a_H

#include <stdint.h>

#include "L1a_library_config.h"

L1a_API extern uint32_t L1a_common_variable;

L1a_API void L1a_common_void_function();
L1a_API uint32_t L1a_common_uint32_function();

L1a_API const char* L1a_common_get_name();

#endif // L1a_H
