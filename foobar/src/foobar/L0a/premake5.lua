local rootDir = _MAIN_SCRIPT_DIR
local absProjectPath = _SCRIPT_DIR
local relProjectPath = path.rebase(absProjectPath, rootDir, rootDir)


function use_L0a(options)
    options = options or {}
    local depInfo = DepInfo[relProjectPath]

    filter "kind:not StaticLib"
        links { "L0a" }
    filter {}

    if depInfo.staticFilter then
        filter { depInfo.staticFilter }
            defines { "L0a_STATIC" }
    end
    if depInfo.sharedFilter then
        filter { depInfo.sharedFilter }
            defines { "L0a_SHARED" }
    end
    filter {}

    externalincludedirs { relProjectPath.."/common" }
    filter "system:linux"
        externalincludedirs { relProjectPath.."/linux" }
    filter "system:macosx"
        externalincludedirs { relProjectPath.."/macos" }
    filter "system:windows"
        externalincludedirs { relProjectPath.."/windows" }
end


function L0a(options)
    options = options or {}

    project "L0a"
        local depInfo = DepInfo[relProjectPath]
        if depInfo.staticFilter then
            filter { depInfo.staticFilter }
                kind "StaticLib"
        end
        if depInfo.sharedFilter then
            filter { depInfo.sharedFilter }
                kind "SharedLib"
        end
        if not depInfo.staticFilter and not depInfo.sharedFilter then
            error "No staticFilter or sharedFilter defined in DepInfo"
        end
        filter {}

        language "C"

        -- NOTE: These are relative to the root premake5.lua file (not this file), becuase
        --       this function is called from the root premake5.lua file rather than the
        --       project being directly defined here.
        location (PRJ_FILE_DESTINATION)
        objdir (PRJ_OBJ_DIR)
        filter "kind:StaticLib"
            targetdir (PRJ_BIN_DIR)
        filter "kind:not StaticLib"
            targetdir (PRJ_OUTPUT_DIR)
        filter {}

        files { relProjectPath.."/common/**.h", relProjectPath.."/common/**.c" }
        includedirs { relProjectPath.."/common/L0a" }
        includedirs { relProjectPath.."/common" }

        filter "system:linux"
            files { relProjectPath.."/linux/**.h", relProjectPath.."/linux/**.c" }
            includedirs { relProjectPath.."/linux/L0a" }
            includedirs { relProjectPath.."/linux" }
        filter "system:macosx"
            files { relProjectPath.."/macos/**.h", relProjectPath.."/macos/**.c" }
            includedirs { relProjectPath.."/macos/L0a" }
            includedirs { relProjectPath.."/macos" }
        filter "system:windows"
            files { relProjectPath.."/windows/**.h", relProjectPath.."/windows/**.c" }
            includedirs { relProjectPath.."/windows/L0a" }
            includedirs { relProjectPath.."/windows" }
        filter {}

        defines { "L0a_BUILDING" }
        filter "kind:StaticLib"
            defines { "L0a_STATIC" }
        filter "kind:SharedLib"
            defines { "L0a_SHARED" }
        filter {}

        filter "configurations:Release"
            defines { "NDEBUG" }
            symbols "Off"
            optimize "On"
        filter "configurations:RelDebug"
            defines { "DEBUG" }
            symbols "On"
            optimize "On"
        filter "configurations:Debug"
            defines { "DEBUG" }
            symbols "On"
            optimize "Off"
        filter "configurations:Profile"
            defines { "NDEBUG" }
            symbols "On"
            optimize "On"
        filter "configurations:Test"
            defines { "DEBUG" }
            symbols "On"
            optimize "Off"
end
