SkyHook = SkyHook or {}

SkyHook._POST_HOOK_TABLE = {}
SkyHook._PRE_HOOK_TABLE = {}

function SkyHook:Post(class, func, replacement)
    local current_index = #SkyHook._POST_HOOK_TABLE
    local baked_func_name = tostring(class) .. tostring(func) .. "_Post_SkyLib_" .. current_index
    table.insert(SkyHook._POST_HOOK_TABLE, baked_func_name)

    Hooks:PostHook(class, func, baked_func_name, replacement)
end

function SkyHook:Pre(class, func, replacement)
    local current_index = #SkyHook._PRE_HOOK_TABLE
    local baked_func_name = tostring(class) .. tostring(func) .. "_Pre_SkyLib_" .. current_index
    table.insert(SkyHook._PRE_HOOK_TABLE, baked_func_name)

    Hooks:PreHook(class, func, baked_func_name, replacement)
end