local libName = "TPa"
target(libName, function ()
    set_kind(DepKind[libName])
    set_group("ThirdParty")
    set_languages("c99")

    add_defines(libName.."_BUILDING")
    on_load(function (target)
        if target:kind() == "static" then
            target:add("defines", libName.."_STATIC", {public = true})
        elseif target:kind() == "shared" then
            target:add("defines", libName.."_SHARED", {public = true})
        end
    end)

    add_files(libName.."/**.c")
    add_headerfiles(libName.."/**.h")
    add_includedirs(libName)
    add_includedirs(".", {public = true})
end)
