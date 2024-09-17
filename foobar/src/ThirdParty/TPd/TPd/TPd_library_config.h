#ifndef TPd_LIBRARY_CONFIG_H
#define TPd_LIBRARY_CONFIG_H

#if defined(TPd_STATIC)
    #define TPd_API
#elif defined(TPd_SHARED)
    #if defined(_WIN32)
        #if defined(TPd_BUILDING)
            #define TPd_API __declspec(dllexport)
        #else
            #define TPd_API __declspec(dllimport)
        #endif
    #elif defined(__linux__) || defined(__APPLE__)
        #if defined(TPd_BUILDING)
            #define TPd_API __attribute__((visibility("default")))
        #else
            #define TPd_API
        #endif
    #else
        #error Unknown platform.
    #endif
#else
    #error Unknown build type. TPd_STATIC or TPd_SHARED must be defined before including any headers.
#endif

#endif // TPd_LIBRARY_CONFIG_H
