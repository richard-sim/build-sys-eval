local rootDir = _MAIN_SCRIPT_DIR
local absProjectPath = _SCRIPT_DIR
local relProjectPath = path.rebase(absProjectPath, rootDir, rootDir)
local projectName = path.getname(relProjectPath)

local depInfo = DepInfo[projectName]


depInfo.use = function (options)
    options = options or {}

    filter("kind:not StaticLib", function()
        links { "L0a" }
    end)

    filter(depInfo.staticFilter, function()
        defines { "L0a_STATIC" }
    end)
    filter(depInfo.sharedFilter, function()
        defines { "L0a_SHARED" }
    end)

    externalincludedirs { relProjectPath.."/common" }
    filter("system:linux", function()
        externalincludedirs { relProjectPath.."/linux" }
    end)
    filter("system:macosx", function()
        externalincludedirs { relProjectPath.."/macos" }
    end)
    filter("system:windows", function()
        externalincludedirs { relProjectPath.."/windows" }
    end)
end


function L0a(options)
    options = options or {}

    project "L0a"
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

        -- vpaths { ["common/*"] = { relProjectPath.."/common/"..projectName } }
        files { relProjectPath.."/common/"..projectName.."/**.h", relProjectPath.."/common/"..projectName.."/**.c" }
        includedirs { relProjectPath.."/common/"..projectName }
        includedirs { relProjectPath.."/common" }

        filter("system:linux", function()
            -- vpaths { ["linux/*"] = { relProjectPath.."/linux/"..projectName } }
            files { relProjectPath.."/linux/"..projectName.."/**.h", relProjectPath.."/linux/"..projectName.."/**.c" }
            includedirs { relProjectPath.."/linux/"..projectName }
            includedirs { relProjectPath.."/linux" }
        end)
        filter("system:macosx", function()
            -- vpaths { ["macos/*"] = { relProjectPath.."/macos/"..projectName } }
            files { relProjectPath.."/macos/"..projectName.."/**.h", relProjectPath.."/macos/"..projectName.."/**.c" }
            includedirs { relProjectPath.."/macos/"..projectName }
            includedirs { relProjectPath.."/macos" }
        end)
        filter("system:windows", function()
            -- vpaths { ["windows/*"] = { relProjectPath.."/windows/"..projectName } }
            files { relProjectPath.."/windows/"..projectName.."/**.h", relProjectPath.."/windows/"..projectName.."/**.c" }
            includedirs { relProjectPath.."/windows/"..projectName }
            includedirs { relProjectPath.."/windows" }
        end)

        defines { "L0a_BUILDING" }
        filter("kind:StaticLib", function()
            defines { "L0a_STATIC" }
        end)
        filter("kind:SharedLib", function()
            defines { "L0a_SHARED" }
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
