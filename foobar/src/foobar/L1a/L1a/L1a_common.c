#include <stdint.h>

#include "L0a/L0a_common.h"
#include "TPa/TPa_common.h"
#include "TPb/TPb_common.h"

#include "L1a_common.h"

uint32_t L1a_common_variable = 42;

void L1a_common_void_function() {
    L1a_common_variable += 1 + L0a_common_variable + TPa_common_variable + TPb_common_variable;
}

uint32_t L1a_common_uint32_function() {
    return 0xDEADBEEF;
}

const char* L1a_common_get_name() {
    return "L1a_common";
}
