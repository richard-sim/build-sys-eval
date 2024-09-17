include "tools/premake5/utils.lua"


PRJ_FILE_DESTINATION = ".build"
CFG_FULL_NAME = "%{cfg.system:lower()}-%{cfg.platform:lower()}-%{cfg.buildcfg:lower()}"
PRJ_OUTPUT_DIR = ".build/bin/%{CFG_FULL_NAME}"
PRJ_BIN_DIR = ".build/bin/%{CFG_FULL_NAME}/%{prj.name}"
PRJ_OBJ_DIR = ".build/obj/%{CFG_FULL_NAME}/%{prj.name}"
WKS_OUTPUT_DIR = "../build/%{CFG_FULL_NAME}"


local FilterOptimizedBuilds = "configurations:Release or Profile"
local FilterDebuggableBuilds = "configurations:RelDebug or Debug or Test"
local DepAlwaysStatic = {
    staticFilter={},
    sharedFilter=nil
}
local DepAlwaysShared = {
    staticFilter=nil,
    sharedFilter={}
}
local DepStaticWhenOptimizedOnly = {
    staticFilter=FilterOptimizedBuilds,
    sharedFilter=FilterDebuggableBuilds
}

DepInfo = {
    ["foobar/L0a"] = DepAlwaysShared,
    ["foobar/L0b"] = DepStaticWhenOptimizedOnly,
    ["foobar/L1a"] = DepAlwaysShared,
    ["foobar/L1b"] = DepStaticWhenOptimizedOnly,
    ["foobar/L1c"] = DepStaticWhenOptimizedOnly,
    ["foobar/L2a"] = DepStaticWhenOptimizedOnly,
    ["ThirdParty/TPa"] = DepAlwaysShared,
    ["ThirdParty/TPb"] = DepAlwaysShared,
    ["ThirdParty/TPc"] = DepAlwaysStatic,
    ["ThirdParty/TPd"] = DepAlwaysStatic
}

include "foobar/L0a"
include "foobar/L0b"
include "foobar/L1a"
include "foobar/L1b"
include "foobar/L1c"
include "foobar/L2a"
include "foobar/L3a"
include "foobar/L3b"
include "ThirdParty/TPa"
include "ThirdParty/TPb"
include "ThirdParty/TPc"
include "ThirdParty/TPd"


workspace "foobar"
    -- The first configuration is the default one
    configurations { "Release", "RelDebug", "Debug", "Profile", "Test" }
    platforms { "x86_64" }

    location ".build"
    targetdir ".build/bin/%{cfg.platform}-%{cfg.buildcfg}"
    objdir ".build/obj/%{cfg.platform}-%{cfg.buildcfg}"

    -- postbuildcommands {
    --     "{MKDIR} %[%{WKS_OUTPUT_DIR}]",
    --     "{COPYFILE} %[%{PRJ_OUTPUT_DIR}/*.dll] %{WKS_OUTPUT_DIR}",
    --     "{COPYFILE} %[%{PRJ_OUTPUT_DIR}/*.exe] %{WKS_OUTPUT_DIR}",
    --     "{COPYFILE} %[%{PRJ_OUTPUT_DIR}/*.pdb] %{WKS_OUTPUT_DIR}"
    -- }

    group "Libraries"
        L0a {}
        L0b {}
        L1a {}
        L1b {}
        L1c {}
        L2a {}
    group "Applications"
        L3a {}
        L3b {}
    group "ThirdParty"
        TPa {}
        TPb {}
        TPc {}
        TPd {}


-- newaction {
--     trigger     = "dist",
--     description = "Update the distribution in %{WKS_OUTPUT_DIR}",
--     execute = function ()
--         os.mkdir(WKS_OUTPUT_DIR)
--         os.copyfile(PRJ_OUTPUT_DIR.."/*.dll", WKS_OUTPUT_DIR)
--         os.copyfile(PRJ_OUTPUT_DIR.."/*.exe", WKS_OUTPUT_DIR)
--         os.copyfile(PRJ_OUTPUT_DIR.."/*.pdb", WKS_OUTPUT_DIR)
--     end
-- }
