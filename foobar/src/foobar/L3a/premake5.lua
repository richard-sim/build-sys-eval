local rootDir = _MAIN_SCRIPT_DIR
local absProjectPath = _SCRIPT_DIR
local relProjectPath = path.rebase(absProjectPath, rootDir, rootDir)
local projectName = path.getname(relProjectPath)


function L3a(options)
    options = options or {}

    project "L3a"
        kind ("ConsoleApp")
        language "C"

        -- NOTE: These are relative to the root premake5.lua file (not this file), becuase
        --       this function is called from the root premake5.lua file rather than the
        --       project being directly defined here.
        location (PRJ_FILE_DESTINATION)
        objdir (PRJ_OBJ_DIR)
        targetdir (PRJ_OUTPUT_DIR)

        files { relProjectPath.."/L3a/**.h", relProjectPath.."/L3a/**.c" }
        includedirs { relProjectPath.."/L3a" }
        includedirs { relProjectPath }

        DepInfo["L0a"].use {}
        DepInfo["L1a"].use {}
        DepInfo["L1b"].use {}
        DepInfo["L1c"].use {}
        DepInfo["L2a"].use {}
        DepInfo["TPa"].use {}
        DepInfo["TPb"].use {}
        DepInfo["TPc"].use {}
        DepInfo["TPd"].use {}

        filter("configurations:Release", function()
            defines { "NDEBUG" }
            symbols "Off"
            optimize "On"
        end)
        filter("configurations:RelDebug", function()
            defines { "DEBUG" }
            symbols "On"
            optimize "On"
        end)
        filter("configurations:Debug", function()
            defines { "DEBUG" }
            symbols "On"
            optimize "Off"
        end)
        filter("configurations:Profile", function()
            defines { "NDEBUG" }
            symbols "On"
            optimize "On"
        end)
        filter("configurations:Test", function()
            defines { "DEBUG" }
            symbols "On"
            optimize "Off"
        end)
end
