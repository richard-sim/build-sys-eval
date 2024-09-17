#include <stdint.h>

#include "L0a_platform.h"

uint32_t L0a_platform_variable = 100;

void L0a_platform_void_function() {
    L0a_platform_variable++;
}

uint32_t L0a_platform_uint32_function() {
    return 0xDEADBEEF;
}

const char* L0a_platform_get_name() {
    return "L0a_platform_linux"
#if defined(L0a_STATIC)
        " (static)"
#elif defined(L0a_SHARED)
        " (shared)"
#endif
        ;
}
