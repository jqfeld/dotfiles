
local iron = require('iron.core')

iron.setup {
    config = {
        -- scratch_repl = true,
        -- close_window_on_exit = true,
        repl_definition = {
            julia = {
                command = {"julia", "--threads=8", "-O3", "--project=@."}
            },
        },
        -- repl_open_cmd = require('iron.view').bottom(40),
    }
}

