local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local s, i, t, c, f = ls.snippet, ls.insert_node, ls.text_node, ls.choice_node, ls.function_node

return {
  -- A snippet that expands the trigger "hi" into the string "Hello, world!".
  s(
    { trig = "watson" },
        { t({"using DrWatson", "@quickactivate"}) }
  ),
  s(
    {trig="vvv", snippetType = "autosnippet"},
    fmt("var\"{}\"{}", {
      i(1),
      i(0)
    }
    )
  )

}
