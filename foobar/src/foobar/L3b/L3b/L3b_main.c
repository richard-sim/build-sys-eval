#include <stdint.h>
#include <stdio.h>

#include "L0a/L0a_common.h"
#include "L0a/platform/L0a_platform.h"

#include "L0b/L0b_common.h"

#include "L1b/L1b_common.h"


int main(int argc, char *argv[])
{
    printf(__FILE__ "\n");
    printf(__DATE__ " " __TIME__ "\n");

    printf("\n");

    printf("L0a_common_get_name() = %s\n", L0a_common_get_name());
    printf("L0a_common_variable = %d\n", L0a_common_variable);
    L0a_common_void_function();
    printf("L0a_common_variable post-fn = %d\n", L0a_common_variable);
    printf("L0a_common_uint32_function() = 0x%08X\n", L0a_common_uint32_function());

    printf("\n");

    printf("L0a_platform_get_name() = %s\n", L0a_platform_get_name());
    printf("L0a_platform_variable = %d\n", L0a_platform_variable);
    L0a_platform_void_function();
    printf("L0a_platform_variable post-fn = %d\n", L0a_platform_variable);
    printf("L0a_platform_uint32_function() = 0x%08X\n", L0a_platform_uint32_function());

    printf("\n");

    printf("L0b_common_get_name() = %s\n", L0b_common_get_name());
    printf("L0b_common_variable = %d\n", L0b_common_variable);
    L0b_common_void_function();
    printf("L0b_common_variable post-fn = %d\n", L0b_common_variable);
    printf("L0b_common_uint32_function() = 0x%08X\n", L0b_common_uint32_function());

    printf("\n");

    printf("L1b_common_get_name() = %s\n", L1b_common_get_name());
    printf("L1b_common_variable = %d\n", L1b_common_variable);
    L1b_common_void_function();
    printf("L1b_common_variable post-fn = %d\n", L1b_common_variable);
    printf("L1b_common_uint32_function() = 0x%08X\n", L1b_common_uint32_function());

    printf("\nDone.\n");

    return 0;
}
