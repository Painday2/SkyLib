SkyLib.Utils = SkyLib.Utils or {}
local Utils = SkyLib.Utils
--
--  Snippet from Michal Kottman
--  v

function Utils:nb_pairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function Utils:remove_from_table_with_ending(tabley, ending)
    local output_table = {}

    for index, value in pairs(tabley) do
        if ( not (ending == "" or value:sub(-#ending) == ending) ) then
            table.insert(output_table, value)
        end
    end

    return output_table
end

function Utils:remove_from_table(tabley, ending)
    local output_table = {}

    for index, value in pairs(tabley) do
        if ( not (ending == "" or value:match(ending) == ending) ) then
            table.insert(output_table, value)
        end
    end

    return output_table
end
function Utils:index_from_value(table, value)
    local index = {}

    for i, v in ipairs(table) do
        index[v] = i
    end
    
    return index[value]
end