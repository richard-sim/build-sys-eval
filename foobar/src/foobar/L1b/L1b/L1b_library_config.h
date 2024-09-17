#ifndef L1b_LIBRARY_CONFIG_H
#define L1b_LIBRARY_CONFIG_H

#if defined(L1b_STATIC)
    #define L1b_API
#elif defined(L1b_SHARED)
    #if defined(_WIN32)
        #if defined(L1b_BUILDING)
            #define L1b_API __declspec(dllexport)
        #else
            #define L1b_API __declspec(dllimport)
        #endif
    #elif defined(__linux__) || defined(__APPLE__)
        #if defined(L1b_BUILDING)
            #define L1b_API __attribute__((visibility("default")))
        #else
            #define L1b_API
        #endif
    #else
        #error Unknown platform.
    #endif
#else
    #error Unknown build type. L1b_STATIC or L1b_SHARED must be defined before including any headers.
#endif

#endif // L1b_LIBRARY_CONFIG_H
