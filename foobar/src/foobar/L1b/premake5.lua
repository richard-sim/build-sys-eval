local rootDir = _MAIN_SCRIPT_DIR
local absProjectPath = _SCRIPT_DIR
local relProjectPath = path.rebase(absProjectPath, rootDir, rootDir)
local projectName = path.getname(relProjectPath)

local depInfo = DepInfo[projectName]


depInfo.use = function (options)
    options = options or {}

    filter("kind:not StaticLib", function()
        links { "L1b" }
    end)

    filter(depInfo.staticFilter, function()
        defines { "L1b_STATIC" }
    end)
    filter(depInfo.sharedFilter, function()
        defines { "L1b_SHARED" }
    end)

    externalincludedirs { relProjectPath }
end


function L1b(options)
    options = options or {}

    project "L1b"
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

        files { relProjectPath.."/L1b/**.h", relProjectPath.."/L1b/**.c" }
        includedirs { relProjectPath.."/L1b" }
        includedirs { relProjectPath }

        DepInfo["L0a"].use {}
        DepInfo["TPc"].use {}

        defines { "L1b_BUILDING" }
        filter("kind:StaticLib", function()
            defines { "L1b_STATIC" }
        end)
        filter("kind:SharedLib", function()
            defines { "L1b_SHARED" }
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
