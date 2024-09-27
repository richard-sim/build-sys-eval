-- NOTE: System configuration is in premake-system.lua


-- Library build configurations
DepInfo = {
    -- NOTE: Tables must be copied as .use() is set by each project
    ["L0a"] = table.deepcopy(DepAlwaysShared),
    ["L0b"] = table.deepcopy(DepStaticWhenOptimizedOnly),
    ["L1a"] = table.deepcopy(DepAlwaysShared),
    ["L1b"] = table.deepcopy(DepStaticWhenOptimizedOnly),
    ["L1c"] = table.deepcopy(DepStaticWhenOptimizedOnly),
    ["L2a"] = table.deepcopy(DepStaticWhenOptimizedOnly),
    ["TPa"] = table.deepcopy(DepAlwaysShared),
    ["TPb"] = table.deepcopy(DepAlwaysShared),
    ["TPc"] = table.deepcopy(DepAlwaysStatic),
    ["TPd"] = table.deepcopy(DepAlwaysStatic)
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

    location (PRJ_FILE_DESTINATION)

    -- Will be inherited by all projects, so we don't have to repeat it
    filter "kind:not StaticLib"
        postbuildcommands {
            -- "%[%{cfg.buildtarget.directory}]" is the abs path to the output directory, including a trailing slash
            "{ECHO} %{prj.name} [cfg.buildtarget.directory]: %[%{cfg.buildtarget.directory}]",
            "{ECHO} %{prj.name} cfg.buildtarget.directory: %{cfg.buildtarget.directory}",
            -- "%[%{cfg.buildtarget.relpath}]" is the rel path to the output directory relative to the obj directory(!), including a trailing slash
            "{ECHO} %{prj.name} [cfg.buildtarget.relpath]: %[%{cfg.buildtarget.relpath}]",
            "{ECHO} %{prj.name} cfg.buildtarget.relpath: %{cfg.buildtarget.relpath}",
            -- "%[%{!cfg.buildtarget.relpath}]" is the rel path to the output directory relative to the .build directory(!)
            "{ECHO} %{prj.name} [!cfg.buildtarget.relpath]: %[%{!cfg.buildtarget.relpath}]",
            "{ECHO} %{prj.name} !cfg.buildtarget.relpath: %{!cfg.buildtarget.relpath}",
            -- "%[%{cfg.buildtarget.abspath}]" is ALSO the rel path to the output directory relative to the .build directory(!)
            "{ECHO} %{prj.name} [cfg.buildtarget.abspath]: %[%{cfg.buildtarget.abspath}]",
            "{ECHO} %{prj.name} cfg.buildtarget.abspath: %{cfg.buildtarget.abspath}",
            -- "%[%{!cfg.buildtarget.abspath}]" is ALSO the rel path to the output directory relative to the .build directory(!)
            "{ECHO} %{prj.name} [!cfg.buildtarget.abspath]: %[%{!cfg.buildtarget.abspath}]",
            "{ECHO} %{prj.name} !cfg.buildtarget.abspath: %{!cfg.buildtarget.abspath}",
            -- "%[%{cfg.buildtarget.name}]" is the name of the output file, including the extension but without any path information
            "{ECHO} %{prj.name} [cfg.buildtarget.name]: %[%{cfg.buildtarget.name}]",
            "{ECHO} %{prj.name} cfg.buildtarget.name: %{cfg.buildtarget.name}",
            -- "%[%{cfg.buildtarget.basename}]" is the name of the output file, without the extension and without any path information
            "{ECHO} %{prj.name} [cfg.buildtarget.basename]: %[%{cfg.buildtarget.basename}]",
            "{ECHO} %{prj.name} cfg.buildtarget.basename: %{cfg.buildtarget.basename}",
            -- "%[%{cfg.buildtarget.extension}]" is the extension of the output file, including the dot
            "{ECHO} %{prj.name} [cfg.buildtarget.extension]: %[%{cfg.buildtarget.extension}]",
            "{ECHO} %{prj.name} cfg.buildtarget.extension: %{cfg.buildtarget.extension}",
            -- Attempt to copy the symbols first, as the postbuildcommand step will fail
            -- if the last command fails.
            "{MKDIR} %[%{WKS_OUTPUT_DIR}]",
            "{COPYFILE} %[%{cfg.buildtarget.directory}/%{cfg.buildtarget.basename}.pdb] %[%{WKS_OUTPUT_DIR}]",
            "{COPYFILE} %[%{cfg.buildtarget.directory}/%{cfg.buildtarget.basename}.map] %[%{WKS_OUTPUT_DIR}]",
            "{COPYFILE} %[%{cfg.buildtarget.directory}/%{cfg.buildtarget.name}] %[%{WKS_OUTPUT_DIR}]"
        }
    filter {}

    startproject "L3a"

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
