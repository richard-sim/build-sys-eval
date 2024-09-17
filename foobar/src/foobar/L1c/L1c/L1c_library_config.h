#ifndef L1c_LIBRARY_CONFIG_H
#define L1c_LIBRARY_CONFIG_H

#if defined(L1c_STATIC)
    #define L1c_API
#elif defined(L1c_SHARED)
    #if defined(_WIN32)
        #if defined(L1c_BUILDING)
            #define L1c_API __declspec(dllexport)
        #else
            #define L1c_API __declspec(dllimport)
        #endif
    #elif defined(__linux__) || defined(__APPLE__)
        #if defined(L1c_BUILDING)
            #define L1c_API __attribute__((visibility("default")))
        #else
            #define L1c_API
        #endif
    #else
        #error Unknown platform.
    #endif
#else
    #error Unknown build type. L1c_STATIC or L1c_SHARED must be defined before including any headers.
#endif

#endif // L1c_LIBRARY_CONFIG_H
