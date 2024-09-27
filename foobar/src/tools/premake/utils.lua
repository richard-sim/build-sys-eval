-- Patch the filter() function to add block scoping
local monkeypatched_filter = filter
local function filterWrapper(terms)
    -- local termsStr = terms
    -- if type(terms) == "table" then
    --     if #terms > 0 then
    --         termsStr = table.concat(terms, ", ")
    --     else
    --         termsStr = "{}"
    --     end
    -- end
    -- local caller = filelineinfo(3)
    -- print(caller.."/filter: "..termsStr)

    monkeypatched_filter(terms)
end

function filter(terms, scopedBlock)
    -- The orignal filter function does nothing if terms is nil, but we
    -- don't want to run scopedBlock in that case. This is a change in
    -- behaviour where previously the code that's now inside scopedBlock
    -- would have been run and affected the outer scope's configuration.
    if terms then
        filterWrapper(terms)
        if scopedBlock then
            scopedBlock()
            filterWrapper({})
        end
    -- else
    --     local caller = filelineinfo(2)
    --     print(caller.."/filter: nil (ignoring block)")
    end
end


-- Print contents of `tbl`, with indentation.
-- `indent` sets the initial level of indentation.
function tprint(tbl, indent)
    if not indent then indent = 0 end
    for k, v in pairs(tbl) do
        formatting = string.rep("  ", indent) .. k .. ": "
        if type(v) == "table" then
            print(formatting)
            tprint(v, indent+1)
        elseif type(v) == 'boolean' then
            print(formatting .. tostring(v))      
        else
            print(formatting .. v)
        end
    end
end
