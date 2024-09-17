#include <stdint.h>

#include "TPd_common.h"

uint32_t TPd_common_variable = 42;

void TPd_common_void_function() {
    TPd_common_variable++;
}

uint32_t TPd_common_uint32_function() {
    return 0xDEADBEEF;
}

const char* TPd_common_get_name() {
    return "TPd_common";
}
