#ifndef L1a_LIBRARY_CONFIG_H
#define L1a_LIBRARY_CONFIG_H

#if defined(L1a_STATIC)
    #define L1a_API
#elif defined(L1a_SHARED)
    #if defined(_WIN32)
        #if defined(L1a_BUILDING)
            #define L1a_API __declspec(dllexport)
        #else
            #define L1a_API __declspec(dllimport)
        #endif
    #elif defined(__linux__) || defined(__APPLE__)
        #if defined(L1a_BUILDING)
            #define L1a_API __attribute__((visibility("default")))
        #else
            #define L1a_API
        #endif
    #else
        #error Unknown platform.
    #endif
#else
    #error Unknown build type. L1a_STATIC or L1a_SHARED must be defined before including any headers.
#endif

#endif // L1a_LIBRARY_CONFIG_H
