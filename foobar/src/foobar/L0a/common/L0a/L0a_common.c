#include <stdint.h>

#include "L0a_common.h"

uint32_t L0a_common_variable = 42;

void L0a_common_void_function() {
    L0a_common_variable++;
}

uint32_t L0a_common_uint32_function() {
    return 0xDEADBEEF;
}

const char* L0a_common_get_name() {
    return "L0a_common";
}
