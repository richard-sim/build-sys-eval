#ifndef TPc_LIBRARY_CONFIG_H
#define TPc_LIBRARY_CONFIG_H

#if defined(TPc_STATIC)
    #define TPc_API
#elif defined(TPc_SHARED)
    #if defined(_WIN32)
        #if defined(TPc_BUILDING)
            #define TPc_API __declspec(dllexport)
        #else
            #define TPc_API __declspec(dllimport)
        #endif
    #elif defined(__linux__) || defined(__APPLE__)
        #if defined(TPc_BUILDING)
            #define TPc_API __attribute__((visibility("default")))
        #else
            #define TPc_API
        #endif
    #else
        #error Unknown platform.
    #endif
#else
    #error Unknown build type. TPc_STATIC or TPc_SHARED must be defined before including any headers.
#endif

#endif // TPc_LIBRARY_CONFIG_H
