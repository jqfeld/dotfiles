local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local s, i, t, c, f = ls.snippet, ls.insert_node, ls.text_node, ls.choice_node, ls.function_node

return {
 s(
    "td",
    fmt("{} {} {} {} {}",{
      c(1,{t"(D)", t"(C)", t"(B)", t"(A)"}),
      f(function ()
        return os.date("%Y-%m-%d")
      end),
      i(2, "Todo"),
      c(3, {t"@M", t"@S", t"@L"}),
      c(4, {t"", fmt(" +{}", i(1))})
    } )
  ),
}

