#include <stdint.h>

#include "L0b_common.h"

uint32_t L0b_common_variable = 42;

void L0b_common_void_function() {
    L0b_common_variable++;
}

uint32_t L0b_common_uint32_function() {
    return 0xDEADBEEF;
}

const char* L0b_common_get_name() {
    return "L0b_common";
}
