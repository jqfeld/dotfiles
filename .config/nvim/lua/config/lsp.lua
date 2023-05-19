-- vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
-- vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  -- opts.max_width= vim.api.nvim_win_get_width(0) - 4
  -- opts.max_height= vim.api.nvim_win_get_height(0) - 4
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local synIDattr = vim.fn.synIDattr
local synIDtrans = vim.fn.synIDtrans
local hlID = vim.fn.hlID
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })

  --get fg and bg of highlight group
  local hlfg = synIDattr(synIDtrans(hlID(hl)), "fg")
  local hlbg = synIDattr(synIDtrans(hlID(hl)), "bg")
  vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. type,
    { fg = hlfg, bg = hlbg, italic = true })
end

local function create_capabilities()
  -- local capabilities = vim.lsp.protocol.make_client_capabilities()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.preselectSupport = false
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
  virtual_text = false,
  underline = true,
  signs = true,
  update_in_insert = false,
})

local wk = require("which-key")
local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, prefix = "<Leader>", noremap = true, silent = true }
  wk.register({
    name = "LSP",
    l = {
      name = "LSP",
      f = { function() vim.lsp.buf.format { async = true } end, "Format" },
      r = { vim.lsp.buf.rename, "Rename" },
      a = { vim.lsp.buf.code_action, "Code Action" },
      q = { vim.diagnostic.setloclist, "Diagnostic loc list" },
      e = { vim.diagnostic.open_float, "Open diagnostics float" },
    },
    w = {
      a = { vim.lsp.buf.add_workspace_folder, "Add workspace folder" },
      r = { vim.lsp.buf.remove_workspace_folder, "Remove workspace folder" },
      l = { function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "List workspace folder" },
    }
  }, opts
  )
  opts = { buffer = bufnr, noremap = true, silent = true, mode = "n" }
  wk.register({
    name = "LSP",
    K = { vim.lsp.buf.hover, "Hover" },
    -- ["<C-k>"] = { vim.lsp.buf.signature_help, "Signature help" },
    ["]d"] = { vim.diagnostic.goto_next, "Jump to next diagnostic" },
    ["[d"] = { vim.diagnostic.goto_prev, "Jump to previous diagnostic" },
    g = {
      d = { vim.lsp.buf.definition, "Go to definition" },
      D = { vim.lsp.buf.declaration, "Go to declaration" },
      r = { vim.lsp.buf.references, "Go to references" },
    },
  }, opts
  )
  opts = { buffer = bufnr, noremap = true, silent = true, mode = "i" }
  wk.register({
    name = "LSP",
    -- ["<C-k>"] = { vim.lsp.buf.signature_help, "Signature help"},
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
  cmd = { "julia", "--startup-file=no",
    "--history-file=no", "--project=~/.julia/environments/nvim-lspconfig",
    "-e", 'using LanguageServer; runserver()' }
})

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lsp_setup("lua_ls", {
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
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
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
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)

  end,
  capabilities = create_capabilities(),
  on_init = function(client)
    client.config.settings["texlab"].forwardSearch.args = {
      "-x",
      -- TODO: make that the command is not shown in nvim
      "nvim --server " ..
      vim.fn.serverlist()[1] .. " --remote-send '<C-\\><C-N>:silent! e %{input} | normal %{line}G0<CR>'",
      "--synctex-forward=%l:%c:%f",
      "%p", }
    client.notify("workspace/didChangeConfiguration")
    return true
  end,
  settings = {
    texlab = {
      build = {
        executable = 'latexmk',
        args = { '-pdflua', '-interaction=nonstopmode', '-synctex=1', '%f' },
        onSave = true,
        forwardSearchAfter = false,
      },
      forwardSearch = {
        executable = "zathura",
        -- args is reset in on_init (not strictly necessary, as servername can
        -- be already read when lsp.lua is executed)
        args = {
          "-x",
          "nvim --server " .. vim.fn.serverlist()[1] .. " --remote-send ':e %{input} | normal %{line}G0<CR>'",
          "--synctex-forward=%l:%c:%f",
          "%p", },
      }
    }
  }
})

lsp_setup("rust_analyzer", {
  on_attach = on_attach,
  capabilities = create_capabilities(),
  cmd = { "rustup", "run", "nightly", "rust-analyzer" }
})
