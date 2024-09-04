return {

  {
    'neovim/nvim-lspconfig',
    tag = nil,
    version = nil,
    branch = 'master',
    event = "BufReadPre",
    dependencies = {
      { "williamboman/mason-lspconfig.nvim" },
      { "williamboman/mason.nvim" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "folke/neodev.nvim",                opt = {} },
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup {
        automatic_installation = { exclude = { "julials" } },
        -- automatic_installation = true,
      }

      local lspconfig = require('lspconfig')
      local cmp_nvim_lsp = require('cmp_nvim_lsp')
      local util = require("lspconfig.util")

      local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
        local opts = { noremap = true, silent = true }

        buf_set_keymap('n', 'gS', '<cmd>Telescope lsp_document_symbols<CR>', opts)
        buf_set_keymap('n', 'gD', '<cmd>Telescope lsp_type_definitions<CR>', opts)
        buf_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
        buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<leader>ll', '<cmd>lua vim.lsp.codelens.run()<cr>', opts)
        buf_set_keymap('n', '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        client.server_capabilities.document_formatting = true
      end

      local on_attach_qmd = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
        local opts = { noremap = true, silent = true }

        -- buf_set_keymap('n', 'gS', '<cmd>Telescope lsp_document_symbols<CR>', opts)
        -- buf_set_keymap('n', 'gD', '<cmd>Telescope lsp_type_definitions<CR>', opts)
        -- buf_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
        -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
        -- buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
        buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<leader>ll', '<cmd>lua vim.lsp.codelens.run()<cr>', opts)
        buf_set_keymap('n', '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        client.server_capabilities.document_formatting = true
      end


      local lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
      }

      -- Some styling
      local signs = { Error = " ", Warn = "⚠", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      })
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover,
        { border = require 'misc.style'.border })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
        { border = require 'misc.style'.border })

      -- Setting capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      -- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
      -- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
      capabilities.workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      }

      lspconfig.markdown_oxide.setup({
        capabilities = capabilities, -- again, ensure that capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
        on_attach = on_attach        -- configure your on attach config
      })

      -- refresh codelens on TextChanged and InsertLeave as well
      -- vim.api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave', 'CursorHold', 'LspAttach' }, {
      --   buffer = bufnr,
      --   callback = vim.lsp.codelens.refresh,
      -- })

      -- trigger codelens refresh
      -- vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })

      -- also needs:
      -- $home/.config/marksman/config.toml :
      -- [core]
      -- markdown.file_extensions = ["md", "markdown", "qmd"]
      -- lspconfig.marksman.setup {
      --   on_attach = on_attach_qmd,
      --   capabilities = capabilities,
      --   filetypes = { 'markdown' },
      --   root_dir = util.root_pattern(".git", ".marksman.toml"),
      -- }

      lspconfig.emmet_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags
      }

      lspconfig.cssls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags
      }

      lspconfig.html.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags
      }

      lspconfig.yamlls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags
      }

      local function strsplit(s, delimiter)
        local result = {}
        for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
          table.insert(result, match)
        end
        return result
      end


      -- not upadated yet in automatic mason-lspconfig install,
      -- open mason manually with `<space>vm` and `/` search for lua.
      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace"
            },
            runtime = {
              version = 'LuaJIT',
              plugin = lua_plugin_paths,
            },
            diagnostics = {
              globals = { 'vim', 'pandoc', 'io', 'string', 'print', 'require', 'table', },
              disable = { 'trailing-space' },
            },
            workspace = {
              library = lua_library_files,
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      }

      lspconfig.pyright.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = false,
              diagnosticMode = 'openFilesOnly',
            },
          },
        },
        root_dir = function(fname)
          return util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(fname) or
              util.path.dirname(fname)
        end
      }

      lspconfig.julials.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
        cmd = { "/home/jk/.local/bin/julia", "--startup-file=no",
          "--history-file=no", "--project=~/.julia/environments/nvim-lspconfig",
          "-e", 'using LanguageServer; runserver()' },
      }

      lspconfig.bashls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
        filetypes = { 'sh', 'bash' }
      }

      lspconfig.rust_analyzer.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
      }

      lspconfig.zls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
      }

      -- Add additional languages here.
      -- See `:h lspconfig-all` for the configuration.
      -- Like e.g. Haskell:
      -- lspconfig.hls.setup {
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      --   flags = lsp_flags
      -- }

      lspconfig.texlab.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
        filetypes = { 'tex', 'latex' },
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
                -- "-x",
                -- "nvim --server " .. vim.fn.serverlist()[1] .. " --remote-send ':e %{input} | normal %{line}G0<CR>'",
                "--synctex-forward=%l:%c:%f",
                "%p", },
            }
          }
        }
      }

      local dictionary = { ["en-US"] = {} }
      local path = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
      for word in io.open(path, "r"):lines() do
        table.insert(dictionary["en-US"], word)
      end

      lspconfig.ltex.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
        root_dir = util.root_pattern("something_impossible"), -- util.find_git_ancestor,
        single_file_support = true,
        settings = {
          ltex = {
            enabled = { 'latex', 'tex', 'bib', 'markdown' },
            language = 'en-US',
            -- language = 'de-DE',
            diagnosticSeverity = 'information',
            setenceCacheSize = 10000,
            additionalRules = {
              enablePickyRules = true,
              motherTongue = 'de-DE',
              languageModel = '~/.local/share/language_models/ngram',
              word2VecModel = '~/.local/share/language_models/word2vec'
            },
            dictionary = dictionary,
            trace = { server = 'verbose' },
            -- languageToolOrg = {
            --   username = require("tokens").language_tool.email,
            --   apiKey = require("tokens").language_tool.token,
            -- },
            -- languageToolHttpServerUri = "https://api.languagetoolplus.com/",
            checkFrequency = "save",
          },
        },

      }
      lspconfig.nushell.setup {}
      lspconfig.ccls.setup {}
      lspconfig.openscad_lsp.setup {}
      lspconfig.tinymist.setup {}
    end
  },

}
