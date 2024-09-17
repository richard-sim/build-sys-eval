#include <stdint.h>

#include "L0a/L0a_common.h"
#include "TPc/TPc_common.h"

#include "L1b_common.h"

uint32_t L1b_common_variable = 42;

void L1b_common_void_function() {
    L1b_common_variable += 1 + L0a_common_variable + TPc_common_variable;
}

uint32_t L1b_common_uint32_function() {
    return 0xDEADBEEF;
}

const char* L1b_common_get_name() {
    return "L1b_common";
}
