local libName = "L0a"
target(libName, function ()
    set_kind(DepKind[libName])
    set_group("Libraries")
    set_languages("c99")

    add_defines(libName.."_BUILDING")
    on_load(function (target)
        if target:kind() == "static" then
            target:add("defines", libName.."_STATIC", {public = true})
        elseif target:kind() == "shared" then
            target:add("defines", libName.."_SHARED", {public = true})
        end
    end)

    add_files("common/"..libName.."/**.c")
    add_headerfiles("common/"..libName.."/**.h")
    add_includedirs("common/"..libName)
    add_includedirs("common", {public = true})

    local osDir = ""
    if is_plat("linux") then
        osDir = "linux"
    elseif is_plat("macosx") then
        osDir = "macos"
    elseif is_plat("windows") then
        osDir = "windows"
    end

    if osDir ~= "" then
        add_files(osDir.."/"..libName.."/**.c")
        add_headerfiles(osDir.."/"..libName.."/**.h")
        add_includedirs(osDir.."/"..libName)
        add_includedirs(osDir, {public = true})
    end
end)
