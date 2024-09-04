return {
  -- A simple "Hello, world!" text node
  s({ trig = '([^%a])ff', regTrig = true, wordTrig = false },
    fmta(
      [[<>\frac{<>}{<>}]],
      {
        f(function(_, snip) return snip.captures[1] end),
        i(1),
        i(2)
      }
    )
  ),
  s({ trig = ";(", snippetType = "autosnippet" },
    fmta(
      [[ \left(<>\right) ]],
      {
        i(1),
      }
    )
  ),
  s({ trig = ";[", snippetType = "autosnippet" },
    fmta(
      [[ \left[<>\right] ]],
      {
        i(1),
      }
    )
  ),
  s({ trig = ";v", snippetType = "autosnippet" },
    fmta(
      [[ \vec{<>} ]],
      {
        i(1),
      }
    )
  ),
  s({ trig = ";rm", snippetType = "autosnippet" },
    fmta(
      [[ \mathrm{<>} ]],
      {
        i(1),
      }
    )
  ),

  s({ trig = ";ga", snippetType = "autosnippet" },
    {
      t("\\alpha"),
    }
  ),
  s({ trig = ";gb", snippetType = "autosnippet" },
    {
      t("\\beta"),
    }
  ),
  s({ trig = ";gg", snippetType = "autosnippet" },
    {
      t("\\gamma"),
    }
  ),
  s({ trig = ";gm", snippetType = "autosnippet" },
    {
      t("\\mu"),
    }
  ),
  s({ trig = ";nab", snippetType = "autosnippet" },
    {
      t("\\nabla"),
    }
  ),
  s({ trig = ";dd", snippetType = "autosnippet" },
    {
      t("\\mathrm{d}"),
    }
  ),
  s({ trig = ";pd", snippetType = "autosnippet" },
    {
      t("\\partial"),
    }
  ),
}
