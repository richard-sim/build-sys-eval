local rootDir = _MAIN_SCRIPT_DIR
local absProjectPath = _SCRIPT_DIR
local relProjectPath = path.rebase(absProjectPath, rootDir, rootDir)
local projectName = path.getname(relProjectPath)

local depInfo = DepInfo[projectName]


depInfo.use = function (options)
    options = options or {}

    filter("kind:not StaticLib", function()
        links { "L2a" }
    end)

    filter(depInfo.staticFilter, function()
        defines { "L2a_STATIC" }
    end)
    filter(depInfo.sharedFilter, function()
        defines { "L2a_SHARED" }
    end)

    externalincludedirs { relProjectPath }
end


function L2a(options)
    options = options or {}

    project "L2a"
        filter(depInfo.staticFilter, function()
            kind "StaticLib"
        end)
        filter(depInfo.sharedFilter, function()
            kind "SharedLib"
        end)

        language "C"

        -- NOTE: These are relative to the root premake5.lua file (not this file), becuase
        --       this function is called from the root premake5.lua file rather than the
        --       project being directly defined here.
        location (PRJ_FILE_DESTINATION)
        objdir (PRJ_OBJ_DIR)
        filter("kind:StaticLib", function()
            targetdir (PRJ_BIN_DIR)
        end)
        filter("kind:not StaticLib", function()
            targetdir (PRJ_OUTPUT_DIR)
        end)

        files { relProjectPath.."/L2a/**.h", relProjectPath.."/L2a/**.c" }
        includedirs { relProjectPath.."/L2a" }
        includedirs { relProjectPath }

        DepInfo["L0a"].use {}
        DepInfo["L1a"].use {}
        DepInfo["L1b"].use {}

        defines { "L2a_BUILDING" }
        filter("kind:StaticLib", function()
            defines { "L2a_STATIC" }
        end)
        filter("kind:SharedLib", function()
            defines { "L2a_SHARED" }
        end)

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
