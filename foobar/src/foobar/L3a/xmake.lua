local libName = "L3a"
target(libName, function ()
    set_kind("binary")
    set_group("Applications")
    set_languages("c99")

    add_files(libName.."/**.c")
    add_headerfiles(libName.."/**.h")
    add_includedirs(libName.."")
    add_includedirs(".")

    add_deps("L0a", "L1a", "L1c", "L2a", "TPa", "TPd")

    -- add_syslinks("user32")
end)
