return {
  -- A simple "Hello, world!" text node
  s({ trig = 'watson', },
    t({
      "using DrWatson",
      "@quickactivate",
      ""
    })
  ),
  s({ trig = "cairo"},
    t({"using CairoMakie; CairoMakie.activate!(pt_per_unit = 1)",""})
  ),
  s({ trig = "gl"},
    t({"using GLMakie; GLMakie.activate!()", ""})
  )

}
