local rootDir = _MAIN_SCRIPT_DIR
local absProjectPath = _SCRIPT_DIR
local relProjectPath = path.rebase(absProjectPath, rootDir, rootDir)


function L3b(options)
    options = options or {}

    project "L3b"
        kind ("ConsoleApp")
        language "C"

        -- NOTE: These are relative to the root premake5.lua file (not this file), becuase
        --       this function is called from the root premake5.lua file rather than the
        --       project being directly defined here.
        location (PRJ_FILE_DESTINATION)
        objdir (PRJ_OBJ_DIR)
        targetdir (PRJ_OUTPUT_DIR)

        files { relProjectPath.."/L3b/**.h", relProjectPath.."/L3b/**.c" }
        includedirs { relProjectPath.."/L3b" }
        includedirs { relProjectPath }

        use_L0a {}
        use_L0b {}
        use_L1b {}

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
