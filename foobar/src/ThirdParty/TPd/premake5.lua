local rootDir = _MAIN_SCRIPT_DIR
local absProjectPath = _SCRIPT_DIR
local relProjectPath = path.rebase(absProjectPath, rootDir, rootDir)


function use_TPd(options)
    options = options or {}
    local depInfo = DepInfo[relProjectPath]

    filter "kind:not StaticLib"
        links { "TPd" }
    filter {}

    if depInfo.staticFilter then
        filter { depInfo.staticFilter }
            defines { "TPd_STATIC" }
    end
    if depInfo.sharedFilter then
        filter { depInfo.sharedFilter }
            defines { "TPd_SHARED" }
    end
    filter {}

    externalincludedirs { relProjectPath }
end


function TPd(options)
    options = options or {}

    project "TPd"
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

        files { relProjectPath.."/TPd/**.h", relProjectPath.."/TPd/**.c" }
        includedirs { relProjectPath.."/TPd" }
        includedirs { relProjectPath }

        defines { "TPd_BUILDING" }
        filter "kind:StaticLib"
            defines { "TPd_STATIC" }
        filter "kind:SharedLib"
            defines { "TPd_SHARED" }
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
        filter {}
end
