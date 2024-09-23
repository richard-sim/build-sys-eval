set_xmakever("2.9.5")

set_project("foobar")
set_version("1.0.0", {build = "%Y%m%d%H%M"})

CFG_FULL_NAME = "$(arch)-$(plat)-$(mode)"
set_targetdir(".build/bin/"..CFG_FULL_NAME.."/$(projname)")
set_objectdir(".build/obj")
set_dependir(".build/deps")
set_autogendir(".build/generated/"..CFG_FULL_NAME)
set_configdir(".build/.xmake/"..CFG_FULL_NAME)
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
-- set_config("sdk", "/home/xxx/toolsdk")
-- set_config("cc", "clang")
-- set_config("ld", "clang")
-- set_config("ldflags", "-L/usr/local/lib")
-- set_config("includedirs", "/usr/local/include")
-- set_config("linkdirs", "/usr/local/lib")
-- set_config("links", "pthread", "dl", "m", "stdc++", "stdc++fs")
-- set_config("syslinks", "pthread", "dl", "m", "stdc++", "stdc++fs")
-- set_config("defines", "NDEBUG")
-- set_config("cflags", "-O2")
-- set_config("cxxflags", "-std=c++17")
-- set_config("cxflags", "-O2")
-- set_config("asflags", "-O2")
-- set_config("ldflags", "-O2")
-- set_config("shflags", "-O2")
-- set_config("arflags", "rcs")
-- set_config("cuflags", "-O2")
-- set_config("culdflags", "-O2")

-- add_cflags("-fPIC")
-- add_cxxflags("-fPIC")
-- add_cxflags("-fPIC")

add_rules("mode.debug", "mode.releasedbg", "mode.release", "mode.minsizerel", "mode.profile", "mode.coverage", "mode.check", "mode.asan", "mode.tsan", "mode.ubsan")
if is_mode("release") then
    add_defines("NDEBUG")
--     set_symbols("hidden")
--     set_optimize("fastest")
--     add_cxflags("-fomit-frame-pointer")
--     set_strip("all")
elseif is_mode("minsizerel") then
    add_defines("NDEBUG")
--     set_symbols("hidden")
--     set_optimize("fastest")
--     add_cxflags("-fomit-frame-pointer")
--     set_strip("all")
elseif is_mode("releasedbg") then
    add_defines("NDEBUG")
--     set_symbols("debug")
--     set_optimize("fastest")
elseif is_mode("debug") then
    add_defines("DEBUG")
--     set_symbols("debug")
--     set_optimize("none")
elseif is_mode("profile") then
    add_defines("NDEBUG")
--     set_symbols("debug")
--     set_optimize("fastest")
--     add_cxflags("-fomit-frame-pointer")
--     set_strip("all")
-- elseif is_mode("coverage") then
--     add_defines("DEBUG")
--     set_symbols("debug")
--     set_optimize("none")
--     set_coverage("gcov")
-- elseif is_mode("asan") then
--     add_defines("DEBUG")
--     set_symbols("debug")
--     set_optimize("none")
--     set_sanitizer("address")
-- elseif is_mode("tsan") then
--     add_defines("DEBUG")
--     set_symbols("debug")
--     set_optimize("none")
--     set_sanitizer("thread")
-- elseif is_mode("msan") then
--     add_defines("DEBUG")
--     set_symbols("debug")
--     set_optimize("none")
--     set_sanitizer("memory")
-- elseif is_mode("lsan") then
--     add_defines("DEBUG")
--     set_symbols("debug")
--     set_optimize("none")
--     set_sanitizer("leak")
-- elseif is_mode("ubsan") then
--     add_defines("DEBUG")
--     set_symbols("debug")
--     set_optimize("none")
--     set_sanitizer("undefined")
end

-- add_vectorexts("sse2", "sse3", "ssse3", "mmx")

-- task("foo", function ()
--     set_values("bar", "baz")
--     set_default("baz")
--     set_showmenu(true)
--     set_description("Is foo bar or baz?")
-- end)
-- if has_config("foo") then
--     print("foo is enabled")
-- end
-- if is_config("foo", "bar") then
--     print("foo is bar")
-- elseif is_config("foo", "baz") then
--     print("foo is baz")
-- end
-- if is_config("foo", "bar", "baz") then
--     print("foo is bar or baz")
-- end
-- if is_config("foo", "ba*") then
--     print("foo starts with ba and is " .. get_config("foo"))
-- end


-- before_run(function (target)
--     print("before_run: " .. target:name())
-- end)
-- on_run(function (target)
--     print("on_run: " .. target:name())
-- end)
-- after_run(function (target)
--     print("after_run: " .. target:name())
-- end)
-- before_test(function (target)
--     print("before_test: " .. target:name())
-- end)
-- on_test(function (target)
--     print("on_test: " .. target:name())
-- end)
-- after_test(function (target)
--     print("after_test: " .. target:name())
-- end)
-- on_load(function (target)
--     print("on_load: " .. target:name())
-- end)
-- after_load(function (target)
--     print("after_load: " .. target:name())
-- end)
-- on_config(function (target)
--     print("on_config: " .. target:name())
-- end)
-- before_link(function (target)
--     print("before_link: " .. target:name())
-- end)
-- on_link(function (target)
--     print("on_link: " .. target:name())
-- end)
-- after_link(function (target)
--     print("after_link: " .. target:name())
-- end)
-- before_build(function (target)
--     print("before_build: " .. target:name())
-- end)
-- on_build(function (target)
--     print("on_build: " .. target:name())
-- end)
-- after_build(function (target)
--     print("after_build: " .. target:name())
-- end)
-- before_build_file(function (target)
--     print("before_build_file: " .. target:name())
-- end)
-- on_build_file(function (target)
--     print("on_build_file: " .. target:name())
-- end)
-- after_build_file(function (target)
--     print("after_build_file: " .. target:name())
-- end)
-- before_build_files(function (target)
--     print("before_build_files: " .. target:name())
-- end)
-- on_build_files(function (target)
--     print("on_build_files: " .. target:name())
-- end)
-- after_build_files(function (target)
--     print("after_build_files: " .. target:name())
-- end)
-- before_clean(function (target)
--     print("before_clean: " .. target:name())
-- end)
-- on_clean(function (target)
--     print("on_clean: " .. target:name())
-- end)
-- after_clean(function (target)
--     print("after_clean: " .. target:name())
-- end)
-- before_package(function (target)
--     print("before_package: " .. target:name())
-- end)
-- on_package(function (target)
--     print("on_package: " .. target:name())
-- end)
-- after_package(function (target)
--     print("after_package: " .. target:name())
-- end)
-- before_install(function (target)
--     print("before_install: " .. target:name())
-- end)
-- on_install(function (target)
--     print("on_install: " .. target:name())
-- end)
-- after_install(function (target)
--     print("after_install: " .. target:name())
-- end)
-- before_installcmd(function (target)
--     print("before_installcmd: " .. target:name())
-- end)
-- on_installcmd(function (target)
--     print("on_installcmd: " .. target:name())
-- end)
-- after_installcmd(function (target)
--     print("after_installcmd: " .. target:name())
-- end)
-- before_uninstall(function (target)
--     print("before_uninstall: " .. target:name())
-- end)
-- on_uninstall(function (target)
--     print("on_uninstall: " .. target:name())
-- end)
-- after_uninstall(function (target)
--     print("after_uninstall: " .. target:name())
-- end)
-- before_uninstallcmd(function (target)
--     print("before_uninstallcmd: " .. target:name())
-- end)
-- on_uninstallcmd(function (target)
--     print("on_uninstallcmd: " .. target:name())
-- end)
-- after_uninstallcmd(function (target)
--     print("after_uninstallcmd: " .. target:name())
-- end)

-- if is_plat("windows") then
--     add_defines("WIN32_LEAN_AND_MEAN")
--     add_defines("NOMINMAX")
--     add_defines("VC_EXTRALEAN")
--     add_defines("STRICT")
--     add_defines("WIN32")
--     add_defines("_WIN32")
--     add_defines("_WIN64")
--     add_defines("_CRT_SECURE_NO_WARNINGS")
--     add_defines("_SCL_SECURE_NO_WARNINGS")
--     add_defines("_CRT_NONSTDC_NO_DEPRECATE")
--     add_defines("_CRT_NON_CONFORMING_SWPRINTFS")
--     add_defines("_WINSOCK_DEPRECATED_NO_WARNINGS")
--     add_defines("_SILENCE_CXX17_CODECVT_HEADER_DEPRECATION_WARNING")
--     add_defines("_SILENCE_CXX17_ITERATOR_BASE_CLASS_DEPRECATION_WARNING")
--     add_defines("_SILENCE_CXX17_OLD_ALLOCATOR_MEMBERS_DEPRECATION_WARNING")
--     add_defines("_SILENCE_CXX17_RESULT_OF_DEPRECATION_WARNING")
--     add_defines("_SILENCE_CXX17_ADAPTOR_TYPEDEFS_DEPRECATION_WARNING")
--     add_defines("_SILENCE_CXX17_ALLOCATOR_VOID_DEPRECATION_WARNING")
--     add_defines("_SILENCE_CXX17_IS_LITERAL_TYPE_DEPRECATION_WARNING")
--     add_defines("_SILENCE_CXX17_NEGATORS_DEPRECATION_WARNING")
--     add_defines("_SILENCE_CXX17_OLD_ALLOCATOR_MEMBERS_DEPRECATION_WARNING")
--     add_defines("_SILENCE_CXX17_RAW_STORAGE_ITERATOR_DEPRECATION_WARNING")
--     add_defines("_SILENCE_CXX17_UNORDERED_MAP_DEPRECATION_WARNING")
--     add_defines("_SILENCE_CXX17_UNORDERED_SET_DEPRECATION_WARNING")
--     add_defines("_SILENCE_CXX17_ITERATOR_BASE_CLASS_DEPRECATION_WARNING")
-- end

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
