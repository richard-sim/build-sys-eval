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

### Opinion

Visual Studio project generation is a first-class citizen, and the design of Premake is built around the restrictions that implies.

The documentation explains the important why's behind things quite well, and the behaviour and code is quite easy to reason about as a result. Usage of the various functionality is consistent.

Custom toolchains are possible, but more involved to set up than XMake. Unknown how easy or hard it is to swap between MSVC and Clang-CL compilers.

Development is slow, with nobody currently pushing forward on major development efforts or functionality, though there are semi-frequent community contributions. There is not much traction around getting bugs fixed. Less-common or newer build targets like WDK or dotnet Core CLR are also not supported (but could be added).

The required usage and structure of `premake5.lua` scripts differs significantly from how they're described in the documentation, in order to reduce duplication of configuration across projects and dependencies. There is no concept of scoping, so you have to be careful to manually end filters since otherwise they'll apply to all subsequent code. Project-level `premake5.lua` scripts generally do not show up in the error information/callstack when they have errors, which makes it very hard to know where there are errors in the workspace, since you don't even know what project the errors are occuring in (or what the errors are).

#### Where Premake will save time

* Easy to reason about the behaviour
* Consistent behaviour
* Generation of purely native VS project files
* Easily extensible
* Documentation explains the why's and how's
* Small codebase that's easy to navigate
* Easily distributed in a repo as it's a single file and binaries are provided for common platforms

#### Where Premake will cost time

* Not very actively developed or maintained
* Limited toolchain support built-in
* No interoperability with other build systems out of the box
* No third-party library support/package management
* Configuration script errors generally don't show the file/line of the error or the error message, just that there was an error somewhere.

## XMake

```
cd foobar\src
.\tools\xmake\xmake.exe project -k vsxmake -m "debug:releasedbg:release:profile:minsizerel" ".build"
.\tools\xmake\xmake.exe project -k cmake -m "debug:releasedbg:release:profile:minsizerel" ".build"
```

Visual Studio and CMake solution and project files will be created in `foobar/src/.build/`

```
cd foobar\src
.\tools\xmake\xmake.exe project -k compile_commands
```

Create a new `compile_commands.json` file for VSCode. Must be manually moved from `foobar/src/` to `.vscode/`.

```
cd foobar\src
.\tools\xmake\xmake.exe config -m releasedbg
.\tools\xmake\xmake.exe
.\tools\xmake\xmake.exe install
```

Build output files (executables and shared libraries/dlls) will be copied to `foobar/build/<target>/bin/` (e.g. `foobar/build/x64-windows-releasedbg/bin/`). Public headers will be copied to `include` and libs will be copied to `lib`. The only way to avoid copying the includes and libs is to specify `xmake install L3a` and `xmake install L3b` (or create a `Phony` target with deps of both), but that will not copy the pdb's of the DLLs, only for the executables.

### Opinion

There are a lot of good features in xmake, but I find it very hard to reason about how things work, and the documentation, while plentiful, is lacking sufficient detail for anything beyond the basic usage, and there are a lot of gaps (e.g. command line arguments, which are rather complex). The project has a lot of hidden gotchas and unexplained inconsistencies, and there's surprisingly few discussions on the projects Github Issues about them. The author is very active, but hard to understand due to language barriers.

The package management feature is very appealing, as it looks like it has sorted out strategies for building some quite annoying packages, and assuming they work, it'll save quite a lot of pain. It is concerning that it appears that the packages are all locked at very specific versions, which may well be outdated. It looks quite easy to create custom package repositories, however.
There are built-in integrations with many major build systems like Cmake and Ninja, and package managers like vcpkg and conan.

Upon testing, both package management with both Conan and VCPkg are broken when following the basic zlib examples from the docs. Bug reports have been submitted, but that's very worrying.

Visual Studio project/solution generation is a second-class citizen to the build-system functionality of xmake. The generated VS projects shell out to xmake rather than use the compilers directly, to get around issues with xmake's design not being oriented to this use case.

Toolchain management and configuration is easy. Switching between MSVC and Clang-CL compilers is a simple one-liner. There is built-in support for many toolchains, including Cuda.

There is limited support for specifying where to output build and project artifacts, with most having at least partially hard-coded paths.

The resulting `xmake.lua` scripts are shorter and simpler than the corresponding `premake5.lua` scripts, mostly due to the built-in support for specifying includes and defines as public or not, which allows xmake to handle those automatically for dependencies.

#### Where XMake will save time

* Built-in interoperability with most major build systems
* Many third-party libraries are included in the package manager
* Package manager can act as a reference for integrating other libaries
* Actively developed and maintained.
* Configuration script errors provide the file/line of the error and the error message

#### Where XMake will cost time

* Appears to be very buggy and releases are made without sufficient testing.
* Documentation does not explain the why's or how's, and has many gaps
* Author is not a native English speaker, so support is difficult to understand
* Very difficult to reason about how things work, as it's not explained anywhere
* Not much control over where it puts files, with many hardcoded paths
* Generated VS projects are a kludge that call XMake rather than the build toolchain directly
* Generated CMake projects are monoliths, so may not be the most usable in IDEs like CLion
* Large codebase with many features that are unneeded.
* Command lines are poorly documented and can be quite long for common operations
* Not easily distributed in a repo as many files are required and not all platforms provide pre-built packages

## CMake

TODO

### Opinion

#### Where CMake will save time

#### Where CMake will cost time

