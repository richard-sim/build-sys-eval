#ifndef TPc_H
#define TPc_H

#include <stdint.h>

#include "TPc_library_config.h"

TPc_API extern uint32_t TPc_common_variable;

TPc_API void TPc_common_void_function();
TPc_API uint32_t TPc_common_uint32_function();

TPc_API const char* TPc_common_get_name();

#endif // TPc_H
