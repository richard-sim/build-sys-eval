#ifndef L2a_LIBRARY_CONFIG_H
#define L2a_LIBRARY_CONFIG_H

#if defined(L2a_STATIC)
    #define L2a_API
#elif defined(L2a_SHARED)
    #if defined(_WIN32)
        #if defined(L2a_BUILDING)
            #define L2a_API __declspec(dllexport)
        #else
            #define L2a_API __declspec(dllimport)
        #endif
    #elif defined(__linux__) || defined(__APPLE__)
        #if defined(L2a_BUILDING)
            #define L2a_API __attribute__((visibility("default")))
        #else
            #define L2a_API
        #endif
    #else
        #error Unknown platform.
    #endif
#else
    #error Unknown build type. L2a_STATIC or L2a_SHARED must be defined before including any headers.
#endif

#endif // L2a_LIBRARY_CONFIG_H
