local libName = "L3b"
target(libName, function ()
    set_kind("binary")
    set_group("Applications")
    set_languages("c99")

    add_files(libName.."/**.c")
    add_headerfiles(libName.."/**.h")
    add_includedirs(libName.."")
    add_includedirs(".")

    add_deps("L0a", "L0b", "L1b")

    -- add_syslinks("user32")
end)
