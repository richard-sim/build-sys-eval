-- Misc utility/helper functions
include "tools/premake/utils.lua"

-- Use Jarod42/premake-cmake to add a CMake action (`premake5 cmake`)
require "tools/premake/cmake"


ROOT_DIR = ".."
OUTPUT_DIR = path.join(ROOT_DIR, "build")

PRJ_FILE_DESTINATION = "!projects"

CFG_FULL_NAME = "%{cfg.system:lower()}-%{cfg.platform:lower()}-%{cfg.buildcfg:lower()}"
PRJ_OUTPUT_DIR = ".build/bin/%{CFG_FULL_NAME}/%{prj.name}"
PRJ_BIN_DIR = ".build/bin/%{CFG_FULL_NAME}/%{prj.name}"
PRJ_OBJ_DIR = ".build/obj/%{CFG_FULL_NAME}/%{prj.name}"
WKS_OUTPUT_DIR = "%{OUTPUT_DIR}/%{CFG_FULL_NAME}"


-- Toolchain and platform configuration settings

-- Library build configurations
FilterOptimizedBuilds = "configurations:Release or Profile"
FilterDebuggableBuilds = "configurations:RelDebug or Debug or Test"
DepAlwaysStatic = {
    staticFilter={},
    sharedFilter=nil,
    use=nil
}
DepAlwaysShared = {
    staticFilter=nil,
    sharedFilter={},
    use=nil
}
DepStaticWhenOptimizedOnly = {
    staticFilter=FilterOptimizedBuilds,
    sharedFilter=FilterDebuggableBuilds,
    use=nil
}


-- clang, msc, msc-clang, msc-llvm, msc-llvm-vs2022, dotnet, gcc
-- https://premake.github.io/docs/using_toolsets
-- NOTE: The "msc" toolset is the default on Windows
-- NOTE: The "gcc" toolset is the default on Linux
-- NOTE: The "clang" toolset is the default on macOS
-- NOTE: The "dotnet" toolset is the default for C# projects
-- NOTE: The "msc-clang" toolset is the default for Windows projects using clang
-- NOTE: The "msc-llvm" toolset is the default for Windows projects using llvm
-- NOTE: The "msc-llvm-vs2022" toolset is the default for Windows projects using llvm with Visual Studio 2022
-- NOTE: clang is transformed to ClangCL on Windows, whereas clang-cl is transformed to cl
--       abd msc-clang is transformed to llvm
toolset "clang"
cdialect "C17"
cppdialect "C++17"
-- stl "libc++"
strictaliasing "Level3" -- None or Level1/2/3
warnings "Extra"
flags {
    "FatalWarnings",
    "ShadowedVariables",
    "UndefinedIdentifiers",
    "MultiProcessorCompile",
    -- For some reason "OmitDefaultLibrary" (/ZI) is enabled, which prevents the use of "LinkTimeOptimization" (/GL)
    "LinkTimeOptimization"
}
filter({ "system:windows" }, function()
    staticruntime "On"
    -- entrypoint "mainCRTStartup"
    -- entrypoint "WinMainCRTStartup"
end)

-- csversion "12.0"
-- dotnetframework "8.0"
-- clr "NetCore"

dpiawareness "HighPerMonitor"
-- dynamic_cast, etc.
-- rtti "On"
rtti "Off"

-- Turn on IDE integration
-- Visual Studio plugin: https://github.com/tvandijck/PremakeExtension
editorintegration "On"
-- Enable edit-and-continue in debug builds only
filter({ FilterOptimizedBuilds }, function()
    editandcontinue "Off"
end)
filter({ FilterDebuggableBuilds }, function()
    editandcontinue "On"
end)

filter("system:linux", function()
    defines { "LINUX" }
    -- exceptionhandling "On"
    exceptionhandling "Off"
end)
filter("system:macosx", function()
    defines { "MACOSX" }
    -- exceptionhandling "On"
    exceptionhandling "Off"
end)
filter("system:windows", function()
    -- See: https://learn.microsoft.com/en-us/windows/win32/debug/structured-exception-handling?redirectedfrom=MSDN
    -- exceptionhandling "SEH"
    exceptionhandling "Off"
    systemversion "latest"
    defines { "WIN32", "_WIN32", "_CRT_SECURE_NO_WARNINGS" }
    defines { "WIN32_LEAN_AND_MEAN", "NOMINMAX", "VC_EXTRALEAN" }
end)

floatabi "hard"
fpu "Hardware"
floatingpoint "Fast"
-- floatingpointexceptions "On"
floatingpointexceptions "Off"
filter("platforms:x86_64", function()
    -- https://store.steampowered.com/hwsurvey
    -- As of 2024-09-26:
    --     100.0% of Steam users have a CPU with SSE3
    --     99.84% of Steam users have a CPU with SSSE3
    --     99.76% of Steam users have a CPU with SSE4.1
    --     99.66% of Steam users have a CPU with SSE4.2
    --     97.35% of Steam users have a CPU with AVX
    --     94.27% of Steam users have a CPU with AVX2
    -- https://stackoverflow.com/a/28186601
    --     [...] the current generation gaming consoles from Sony & Microsoft support up
    --     through AVX. The primary value of AVX is that you can use the /arch:AVX switch
    --     which allows all SSE code-generation to use the 3-operand VEX prefix which
    --     makes register scheduling more efficient.
    --     See this blog post: https://walbourn.github.io/directxmath-avx/
    vectorextensions "AVX"
end)

-- https://premake.github.io/docs/vsprops
-- language "C#"
-- vsprops {
--     -- https://devblogs.microsoft.com/visualstudio/vs-toolbox-accelerate-your-builds-of-sdk-style-net-projects/
--     AccelerateBuildsInVisualStudio = "true",
--     -- https://learn.microsoft.com/en-us/visualstudio/ide/how-to-change-the-build-output-directory?view=vs-2022
--     AppendTargetFrameworkToOutputPath = "false",
--     -- https://learn.microsoft.com/en-us/dotnet/csharp/tutorials/nullable-reference-types
--     Nullable = "enable",
-- }
-- language "C++"
-- nuget {
--     "Microsoft.Direct3D.D3D12:1.608.2"
-- }
-- vsprops {
--     -- https://devblogs.microsoft.com/directx/gettingstarted-dx12agility/#2-set-agility-sdk-parameters
--     Microsoft_Direct3D_D3D12_D3D12SDKPath = "custom_path",
-- }
