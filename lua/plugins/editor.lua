return {
  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
    opts = {
      highlighters = {
        hsl_color = {
          pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",
          group = function(_, match)
            local utils = require("solarized-osaka.hsl")
            --- @type string, string, string
            local nh, ns, nl = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")
            --- @type number?, number?, number?
            local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)
            --- @type string
            local hex_color = utils.hslToHex(h, s, l)
            return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
          end,
        },
      },
    },
  },

  {
    "dinhhuy258/git.nvim",
    event = "BufReadPre",
    opts = {
      keymaps = {
        -- Open blame window
        blame = "<Leader>gb",
        -- Open file/folder in git repository
        browse = "<Leader>go",
      },
    },
  },

  {
    "kazhala/close-buffers.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>th",
        function()
          require("close_buffers").delete({ type = "hidden" })
        end,
        "Close Hidden Buffers",
      },
      {
        "<leader>tu",
        function()
          require("close_buffers").delete({ type = "nameless" })
        end,
        "Close Nameless Buffers",
      },
    },
  },

  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      vim.b.completion = false

      Snacks.toggle({
        name = "Completion",
        get = function()
          return vim.b.completion
        end,
        set = function(state)
          vim.b.completion = state
        end,
      }):map("<leader>uk")

      opts.enabled = function()
        return vim.b.completion ~= false
      end
      return opts
    end,
    -- opts = {
    --   completion = {
    --     menu = {
    --       winblend = vim.o.pumblend,
    --     },
    --   },
    --   signature = {
    --     window = {
    --       winblend = vim.o.pumblend,
    --     },
    --   },
    -- },
  },
}
