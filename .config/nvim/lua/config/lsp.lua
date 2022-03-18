
-- vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
-- vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = {
      {"🭽", "FloatBorder"},
      {"▔", "FloatBorder"},
      {"🭾", "FloatBorder"},
      {"▕", "FloatBorder"},
      {"🭿", "FloatBorder"},
      {"▁", "FloatBorder"},
      {"🭼", "FloatBorder"},
      {"▏", "FloatBorder"},
}
-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local function create_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.preselectSupport = true
    capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
    capabilities.textDocument.completion.completionItem.deprecatedSupport = true
    capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
    capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
    capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
            properties = { "documentation", "detail", "additionalTextEdits" },
        }
    capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown" }
    capabilities.textDocument.codeAction = {
        dynamicRegistration = true,
        codeActionLiteralSupport = {
            codeActionKind = {
                valueSet = (function()
                    local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
                    table.sort(res)
                    return res
                    end)(),
                },
            },
        }
    return capabilities
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        underline = true,
        signs = true,
        update_in_insert = false,
    })

local wk = require("which-key")
local on_attach = function(client, bufnr)
    -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
    -- Mappings.
    local opts = {buffer=bufnr, prefix="<Leader>", noremap=true, silent=true }

    wk.register({
        name = "LSP",
        l = {
            name = "LSP",
            f = {'<cmd>lua vim.lsp.buf.formatting()<CR>', "Format"},
            r = {'<cmd>lua vim.lsp.buf.rename()<CR>', "Rename"},
            a = {'<cmd>lua vim.lsp.buf.code_action()<CR>', "Code Action"},
        }
    },opts
    )
    opts = {buffer=bufnr,  noremap=true, silent=true, mode="n"}
    wk.register({
        name = "LSP",
        K = { '<cmd>lua vim.lsp.buf.hover()<CR>', "Hover"},
        ["<C-k>"] = { '<cmd>lua vim.lsp.buf.signature_help()<CR>', "Signature help"},
    }, opts
    )
end

local lspconfig = require("lspconfig")

local function lsp_setup(name, config)
    lspconfig[name].setup(config)
end

lsp_setup("julials", {
    on_attach = on_attach,
    capabilities = create_capabilities(),
})

lsp_setup("rust_analyzer", {
    on_attach = on_attach,
    capabilities = create_capabilities(),
})

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lsp_setup("sumneko_lua",{
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
    on_attach = on_attach,
    capabilities = create_capabilities(),
})
lsp_setup("texlab", {
    on_attach = on_attach,
    capabilities = create_capabilities(),
})
lsp_setup("ltex", {
    on_attach = on_attach,
    capabilities = create_capabilities(),
})
