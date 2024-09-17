include "../L0a"
include "../L1a"
include "../L1b"
include "../L1c"
include "../L2a"
include "../../ThirdParty/TPa"
include "../../ThirdParty/TPb"
include "../../ThirdParty/TPc"
include "../../ThirdParty/TPd"


local rootDir = _MAIN_SCRIPT_DIR
local absProjectPath = _SCRIPT_DIR
local relProjectPath = path.rebase(absProjectPath, rootDir, rootDir)


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

        use_L0a {}
        use_L1a {}
        use_L1b {}
        use_L1c {}
        use_L2a {}
        use_TPa {}
        use_TPb {}
        use_TPc {}
        use_TPd {}

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
