
local ls = require("luasnip")
-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

local date = function() return {os.date('%Y-%m-%d')} end

require('luasnip.loaders.from_vscode').lazy_load()

ls.snippets = {
    all = {
        snip({
            trig = "date",
            namr = "Date",
            dscr = "Date in the form of YYYY-MM-DD"
        },
        {
            func(date, {}),
        }),
    },
}

ls.config.set_config({
  store_selection_keys = '<C-s>',
})
