set_xmakever("2.9.5")

set_project("foobar")
set_version("1.0.0", {build = "%Y%m%d%H%M"})

CFG_FULL_NAME = "$(arch)-$(plat)-$(mode)"
set_targetdir(".build/bin/"..CFG_FULL_NAME.."/$(projname)")
set_objectdir(".build/obj")
set_dependir(".build/deps")
set_autogendir(".build/generated/"..CFG_FULL_NAME)
set_configdir(".build/config/"..CFG_FULL_NAME)
set_installdir("../build/"..CFG_FULL_NAME)
set_rundir("../build")


set_defaultmode("debug")
set_defaultplat("windows")
set_defaultarchs("linux|x86_64", "macosx|x86_64", "windows|x64", "wasm|wasm64", "iphoneos|arm64", "android|arm64-v8a")

set_warnings("all", "error")

if is_plat("windows") then
    set_toolchains("clang-cl")
    -- set_toolchains("msvc")
    if is_mode("debug") then
        set_runtimes("MTd")
    else
        set_runtimes("MT")
    end
else
    set_toolchains("clang")
end

add_rules("mode.debug", "mode.releasedbg", "mode.release", "mode.minsizerel", "mode.profile", "mode.coverage")
if is_mode("releasedbg") then
elseif is_mode("debug") then
    -- add_defines("DEBUG")
end


-- add_requires("zlib 1.2.11", {alias = "zlib-xmake"})
-- -- add_requires("conan::zlib/1.2.11", {alias = "zlib-conan"})
-- add_requires("conan::zlib/1.2.11", {
--     alias = "zlib-conan",
--     configs = {
--         settings = {
--             "compiler.version=194"
--         }
--     }
-- })
-- add_requires("vcpkg::zlib 1.2.11", {alias = "zlib-vcpkg"})


DepKind = {
    ["L0a"] = "shared",
    ["L0b"] = "shared",
    ["L1a"] = "shared",
    ["L1b"] = "shared",
    ["L1c"] = "shared",
    ["L2a"] = "shared",
    ["TPa"] = "shared",
    ["TPb"] = "shared",
    ["TPc"] = "static",
    ["TPd"] = "static"
}
if is_mode("release", "minsizerel", "profile") then
    DepKind["L0b"] = "static"
    DepKind["L1b"] = "static"
    DepKind["L1c"] = "static"
    DepKind["L2a"] = "static"
elseif is_mode("debug", "releasedbg") then
end

includes("foobar/L0a")
includes("foobar/L0b")
includes("foobar/L1a")
includes("foobar/L1b")
includes("foobar/L1c")
includes("foobar/L2a")
includes("foobar/L3a")
includes("foobar/L3b")
includes("ThirdParty/TPa")
includes("ThirdParty/TPb")
includes("ThirdParty/TPc")
includes("ThirdParty/TPd")

target("deps", function ()
    set_kind("phony")
    -- add_deps("L0a", "L0b", "L1a", "L1b", "L1c", "L2a", "L3a", "L3b", "TPa", "TPb", "TPc", "TPd")
    add_deps("L3a", "L3b")
    -- add_packages("zlib-xmake", "zlib-conan", "zlib-vcpkg")
end)
