local wk = require("which-key")

local iron = require('iron.core')


local opt = vim.opt

iron.setup {
    config = {
        scratch_repl = true,
        close_window_on_exit = true,
        repl_definition = {
            julia = {
                command = {"julia", "-O3", "--project=@."}
            },
        },
        repl_open_cmd = "rightbelow split",
    }
}
-- with leader
wk.register({
    i = {
        name = "Iron/Julia", -- optional group name
        l = { iron.send_line, "Send line to REPL" },
        -- i = { "<Plug>(iron-interrupt)", "Interrupt REPL" },
        -- TODO: this is very hacky, can probably be done much nicer
        a = { [[<CMD>:w <bar> :call luaeval("require('iron').core.send(_A[1], _A[2])", [&ft, "include(\"".expand("%")."\")"])<CR>"]], "Run include(this_file) in REPL" },
        e = { [[<Cmd>:w <bar> :call luaeval("require('iron').core.send(_A[1], _A[2])", [&ft, join(getline(1,'$'), "\n")])<CR>]], "Save and send each line to REPL" },
        f = { "<CMD>:IronFocus<CR>", "Focus on REPL" },
        r = { iron.repl_restart, "Restart REPL" },
        q = { function() iron.close_repl("julia") end, "Close REPL"},
        -- c = { "<Plug>(iron-clear)<CR>", "Clear REPL" },
    },
}, { prefix = "<leader>" })

wk.register({
    i = {
        name = "Iron/Julia", -- optional group name
        v = { function() iron.mark_visual() iron.send_mark() end, "Send selection to REPL" },
    },
}, { prefix = "<leader>" , mode = "v"})



wk.register({
    t = {
        name = "Kitty/Julia", -- optional group name
        s = { "<CMD>KittySendLines<CR>", "Send line to REPL" },
        a = { [[<CMD>:w <bar> :call luaeval("require('kitty-runner').run_command({1,-1})")<CR>"]], "Send all lines to REPL" },
        o = { [[<CMD>KittyOpenRunner<CR>]], "Open REPL" },
        q = { [[<CMD>KittyKillRunner<CR>]], "Close REPL" },
        -- c = { "<Plug>(iron-clear)<CR>", "Clear REPL" },
    },
}, { prefix = "<leader>" })

wk.register({
    t = {
        name = "Kitty/Julia", -- optional group name
        s = { [[:'<,'>KittySendLines<CR>]], "Send line to REPL" },
    },
}, { prefix = "<leader>" , mode = "v"})


