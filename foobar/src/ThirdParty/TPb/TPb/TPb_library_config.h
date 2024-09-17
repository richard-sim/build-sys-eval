#ifndef TPb_LIBRARY_CONFIG_H
#define TPb_LIBRARY_CONFIG_H

#if defined(TPb_STATIC)
    #define TPb_API
#elif defined(TPb_SHARED)
    #if defined(_WIN32)
        #if defined(TPb_BUILDING)
            #define TPb_API __declspec(dllexport)
        #else
            #define TPb_API __declspec(dllimport)
        #endif
    #elif defined(__linux__) || defined(__APPLE__)
        #if defined(TPb_BUILDING)
            #define TPb_API __attribute__((visibility("default")))
        #else
            #define TPb_API
        #endif
    #else
        #error Unknown platform.
    #endif
#else
    #error Unknown build type. TPb_STATIC or TPb_SHARED must be defined before including any headers.
#endif

#endif // TPb_LIBRARY_CONFIG_H
