local wk = require("which-key")

wk.register({
    name = "LSP",
    l = {
        o = { "<CMD>:AerialToggle<CR>", "Outline"},
    }
}, {prefix="<Leader>"})

