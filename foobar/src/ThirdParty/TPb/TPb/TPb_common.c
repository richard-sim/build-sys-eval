#include <stdint.h>

#include "TPb_common.h"

uint32_t TPb_common_variable = 42;

void TPb_common_void_function() {
    TPb_common_variable++;
}

uint32_t TPb_common_uint32_function() {
    return 0xDEADBEEF;
}

const char* TPb_common_get_name() {
    return "TPb_common";
}
