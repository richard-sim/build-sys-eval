#include <stdint.h>

#include "TPc_common.h"

uint32_t TPc_common_variable = 42;

void TPc_common_void_function() {
    TPc_common_variable++;
}

uint32_t TPc_common_uint32_function() {
    return 0xDEADBEEF;
}

const char* TPc_common_get_name() {
    return "TPc_common";
}
