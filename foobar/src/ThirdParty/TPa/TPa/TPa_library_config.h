#ifndef TPa_LIBRARY_CONFIG_H
#define TPa_LIBRARY_CONFIG_H

#if defined(TPa_STATIC)
    #define TPa_API
#elif defined(TPa_SHARED)
    #if defined(_WIN32)
        #if defined(TPa_BUILDING)
            #define TPa_API __declspec(dllexport)
        #else
            #define TPa_API __declspec(dllimport)
        #endif
    #elif defined(__linux__) || defined(__APPLE__)
        #if defined(TPa_BUILDING)
            #define TPa_API __attribute__((visibility("default")))
        #else
            #define TPa_API
        #endif
    #else
        #error Unknown platform.
    #endif
#else
    #error Unknown build type. TPa_STATIC or TPa_SHARED must be defined before including any headers.
#endif

#endif // TPa_LIBRARY_CONFIG_H
