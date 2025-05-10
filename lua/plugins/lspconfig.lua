return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua", -- Lua formatter
        "selene", -- Lua linter
        "luacheck", -- Lua linter
        "shellcheck", -- Shell script linter
        "biome", -- Biome formatter
        "shfmt", -- Shell script formatter
        "prettierd", -- JS/TS/JSX/TSX formatter
        "eslint_d", -- JS/TS linter
        "php-cs-fixer", -- PHP formatter
        "phpstan", -- PHP static analysis
        "css-lsp", -- CSS language server
        "typescript-language-server", -- TypeScript/JavaScript (React, Next.js, Astro, Vue, Svelte
      })
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "cssls", -- CSS
          "html", -- HTML
          "yamlls", -- YAML
          "lua_ls", -- Lua
          "eslint", -- JS/TS linting
          "phpactor", -- PHP (Laravel, general PHP)
          "astro", -- Astro
          "svelte", -- Svelte
          "vuels", -- Vue
        },
        automatic_installation = true,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- TypeScript/JavaScript (React, Next.js, Astro, Vue, Svelte)
      lspconfig.tsserver.setup({
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false -- Let prettier handle formatting
        end,
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      })

      -- ESLint for linting JavaScript/TypeScript
      lspconfig.eslint.setup({
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
        end,
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "svelte",
          "astro",
        },
      })

      -- PHP (Laravel, general PHP)
      lspconfig.phpactor.setup({
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false -- Let php-cs-fixer handle formatting
        end,
        filetypes = { "php" },
        init_options = {
          ["language_server_php_cs_fixer.enabled"] = true,
          ["language_server_phpstan.enabled"] = true,
        },
      })

      -- Astro
      lspconfig.astro.setup({
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
        end,
      })

      -- Svelte
      lspconfig.svelte.setup({
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
        end,
      })

      -- Vue
      lspconfig.vuels.setup({
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
        end,
      })

      -- CSS
      lspconfig.cssls.setup({
        settings = {
          css = {
            validate = true,
            lint = {
              unknownAtRules = "ignore", -- Support modern CSS frameworks
            },
          },
        },
      })

      -- HTML
      lspconfig.html.setup({})

      -- YAML (useful for Laravel configs, GitHub Actions)
      lspconfig.yamlls.setup({
        settings = {
          yaml = {
            keyOrdering = false,
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["https://json.schemastore.org/composer.json"] = "/composer.json",
            },
          },
        },
      })

      -- Lua (for Neovim config)
      lspconfig.lua_ls.setup({
        single_file_support = true,
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            completion = { workspaceWord = true, callSnippet = "Both" },
            format = { enable = false }, -- Let stylua handle formatting
            diagnostics = {
              globals = { "vim" }, -- Recognize Neovim globals
            },
          },
        },
      })

      -- Enable inlay hints globally
      vim.lsp.inlay_hint.enable(true)
    end,
  },

  -- Custom keymaps for LSP
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      vim.list_extend(keys, {
        {
          "gd",
          function()
            require("telescope.builtin").lsp_definitions({ reuse_win = true })
          end,
          desc = "Goto Definition",
          has = "definition",
        },
        { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References", nowait = true },
        {
          "gI",
          function()
            require("telescope.builtin").lsp_implementations({ reuse_win = true })
          end,
          desc = "Goto Implementation",
        },
        {
          "gy",
          function()
            require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
          end,
          desc = "Goto T[y]pe Definition",
        },
        {
          "<leader>ca",
          vim.lsp.buf.code_action,
          desc = "Code Action",
          mode = { "n", "v" },
          has = "codeAction",
        },
        {
          "<leader>rn",
          vim.lsp.buf.rename,
          desc = "Rename",
          has = "rename",
        },
      })
    end,
  },
}
