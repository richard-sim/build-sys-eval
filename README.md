# Build Systems

The purpose of this project is to evaluate various build systems for future projects, and create examples/templates to use when setting them up.

## Premake

```
cd foobar\src
.\tools\premake\bin\win_x64\premake5.exe vs2022
.\tools\premake\bin\win_x64\premake5.exe cmake
```

Visual Studio and CMake solution and project files will be created in `foobar/src/.build/`

Build output files (executables and shared libraries/dlls) will be copied to `foobar/build/<target>/` (e.g. `foobar/build/windows-x86_64-debug/`)

## XMake

TODO

## CMake

TODO

