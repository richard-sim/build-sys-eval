#ifndef L0b_LIBRARY_CONFIG_H
#define L0b_LIBRARY_CONFIG_H

#if defined(L0b_STATIC)
    #define L0b_API
#elif defined(L0b_SHARED)
    #if defined(_WIN32)
        #if defined(L0b_BUILDING)
            #define L0b_API __declspec(dllexport)
        #else
            #define L0b_API __declspec(dllimport)
        #endif
    #elif defined(__linux__) || defined(__APPLE__)
        #if defined(L0b_BUILDING)
            #define L0b_API __attribute__((visibility("default")))
        #else
            #define L0b_API
        #endif
    #else
        #error Unknown platform.
    #endif
#else
    #error Unknown build type. L0b_STATIC or L0b_SHARED must be defined before including any headers.
#endif

#endif // L0b_LIBRARY_CONFIG_H
