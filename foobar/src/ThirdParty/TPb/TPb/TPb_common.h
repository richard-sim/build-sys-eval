#ifndef TPb_H
#define TPb_H

#include <stdint.h>

#include "TPb_library_config.h"

TPb_API extern uint32_t TPb_common_variable;

TPb_API void TPb_common_void_function();
TPb_API uint32_t TPb_common_uint32_function();

TPb_API const char* TPb_common_get_name();

#endif // TPb_H
