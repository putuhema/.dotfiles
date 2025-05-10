return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- Extend the formatters_by_ft table to include Biome for JavaScript
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft["javascript"] = { "biome" }
      opts.formatters_by_ft["javascriptreact"] = { "biome" }
      opts.formatters_by_ft["typescript"] = { "biome" }
      opts.formatters_by_ft["typescriptreact"] = { "biome" }

      -- Configure Biome formatter options
      opts.formatters = opts.formatters or {}
      opts.formatters.biome = {
        -- Require a Biome configuration file (biome.json) in the project
        require_cwd = true,
        -- Use correct arguments for Biome to format via stdin
        args = {
          "format",
          "--stdin-file-path",
          "$FILENAME",
        },
      }
    end,
  },
}
