#ifndef L0a_LIBRARY_CONFIG_H
#define L0a_LIBRARY_CONFIG_H

#if defined(L0a_STATIC)
    #define L0a_API
#elif defined(L0a_SHARED)
    #if defined(_WIN32)
        #if defined(L0a_BUILDING)
            #define L0a_API __declspec(dllexport)
        #else
            #define L0a_API __declspec(dllimport)
        #endif
    #elif defined(__linux__) || defined(__APPLE__)
        #if defined(L0a_BUILDING)
            #define L0a_API __attribute__((visibility("default")))
        #else
            #define L0a_API
        #endif
    #else
        #error Unknown platform.
    #endif
#else
    #error Unknown build type. L0a_STATIC or L0a_SHARED must be defined before including any headers.
#endif

#endif // L0a_LIBRARY_CONFIG_H
