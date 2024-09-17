#include <stdint.h>

#include "L0a/L0a_common.h"
#include "L1a/L1a_common.h"
#include "L1b/L1b_common.h"

#include "L2a_common.h"

uint32_t L2a_common_variable = 42;

void L2a_common_void_function() {
    L2a_common_variable += 1 + L0a_common_variable + L1a_common_variable + L1b_common_variable;
}

uint32_t L2a_common_uint32_function() {
    return 0xDEADBEEF;
}

const char* L2a_common_get_name() {
    return "L2a_common";
}
