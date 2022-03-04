
-- nmap <localleader>it    <Plug>(iron-send-motion)
-- vmap <localleader>iv    <Plug>(iron-visual-send)
-- nmap <localleader>ir    <CMD>:IronRestart<CR>
-- nmap <localleader>il    <Plug>(iron-send-line)
-- nmap <localleader><CR> <Plug>(iron-cr)
-- nmap <localleader>ii    <plug>(iron-interrupt)
-- nmap <localleader>iq    <Plug>(iron-exit)
-- nmap <localleader>ic    <Plug>(iron-clear)
-- nmap <localleader>ij    <Cmd>:w <bar> :call luaeval("require('iron').core.send(_A[1], _A[2])", [&ft, "include(\"".expand("%")."\")"])<CR>
-- nmap <localleader>ia    <Cmd>:w <bar> :call luaeval("require('iron').core.send(_A[1], _A[2])", [&ft, join(getline(1,'$'), "\n")])<CR>
-- nmap <localleader>if    <CMD>:IronFocus<CR>
local wk = require("which-key")

-- with leader
wk.register({
    i = {
        name = "Iron/Julia", -- optional group name
        l = { "<Plug>(iron-send-line)", "Send line to REPL" },
        i = { "<Plug>(iron-interrupt)", "Interrupt REPL" },
        -- TODO: this is very hacky, can probably be done much nicer
        a = { [[<CMD>:w <bar> :call luaeval("require('iron').core.send(_A[1], _A[2])", [&ft, "include(\"".expand("%")."\")"])<CR>"]], "Run include(this_file) in REPL" },
        e = { [[<Cmd>:w <bar> :call luaeval("require('iron').core.send(_A[1], _A[2])", [&ft, join(getline(1,'$'), "\n")])<CR>]], "Save and send each line to REPL" },
        f = { "<CMD>:IronFocus<CR>", "Focus on REPL" },
        r = { "<CMD>:IronRestart<CR>", "Restart REPL" },
        c = { "<Plug>(iron-clear)<CR>", "Clear REPL" },
    },
}, { prefix = "<leader>" })

wk.register({
    i = {
        name = "Iron/Julia", -- optional group name
        v = { "<Plug>(iron-visual-send)", "Send selection to REPL" },
    },
}, { prefix = "<leader>" , mode = "v"})



