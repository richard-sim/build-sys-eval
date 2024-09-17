#include <stdint.h>
#include <stdio.h>

#include "L0a/L0a_common.h"
#include "L0a/platform/L0a_platform.h"

#include "L1a/L1a_common.h"

#include "L1c/L1c_common.h"

#include "L2a/L2a_common.h"

#include "TPa/TPa_common.h"

#include "TPd/TPd_common.h"


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

    printf("L1a_common_get_name() = %s\n", L1a_common_get_name());
    printf("L1a_common_variable = %d\n", L1a_common_variable);
    L1a_common_void_function();
    printf("L1a_common_variable post-fn = %d\n", L1a_common_variable);
    printf("L1a_common_uint32_function() = 0x%08X\n", L1a_common_uint32_function());

    printf("\n");

    printf("L1c_common_get_name() = %s\n", L1c_common_get_name());
    printf("L1c_common_variable = %d\n", L1c_common_variable);
    L1c_common_void_function();
    printf("L1c_common_variable post-fn = %d\n", L1c_common_variable);
    printf("L1c_common_uint32_function() = 0x%08X\n", L1c_common_uint32_function());

    printf("\n");

    printf("L2a_common_get_name() = %s\n", L2a_common_get_name());
    printf("L2a_common_variable = %d\n", L2a_common_variable);
    L2a_common_void_function();
    printf("L2a_common_variable post-fn = %d\n", L2a_common_variable);
    printf("L2a_common_uint32_function() = 0x%08X\n", L2a_common_uint32_function());

    printf("\n");

    printf("TPa_common_get_name() = %s\n", TPa_common_get_name());
    printf("TPa_common_variable = %d\n", TPa_common_variable);
    TPa_common_void_function();
    printf("TPa_common_variable post-fn = %d\n", TPa_common_variable);
    printf("TPa_common_uint32_function() = 0x%08X\n", TPa_common_uint32_function());

    printf("\n");

    printf("TPd_common_get_name() = %s\n", TPd_common_get_name());
    printf("TPd_common_variable = %d\n", TPd_common_variable);
    TPd_common_void_function();
    printf("TPd_common_variable post-fn = %d\n", TPd_common_variable);
    printf("TPd_common_uint32_function() = 0x%08X\n", TPd_common_uint32_function());

    printf("\nDone.\n");

    return 0;
}
