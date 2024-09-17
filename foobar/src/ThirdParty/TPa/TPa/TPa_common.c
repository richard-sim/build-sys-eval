#include <stdint.h>

#include "TPa_common.h"

uint32_t TPa_common_variable = 42;

void TPa_common_void_function() {
    TPa_common_variable++;
}

uint32_t TPa_common_uint32_function() {
    return 0xDEADBEEF;
}

const char* TPa_common_get_name() {
    return "TPa_common";
}
