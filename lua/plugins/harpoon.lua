return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim", -- Add Telescope as a dependency
    },
    config = function()
      local harpoon = require("harpoon")

      -- Initialize Harpoon
      harpoon:setup()

      -- Keybindings for Harpoon
      vim.keymap.set("n", "<leader>a", function()
        harpoon:list():add()
      end, { desc = "Harpoon: Add file to list" })

      -- Navigate to specific files in the Harpoon list
      vim.keymap.set("n", "<C-h>", function()
        harpoon:list():select(1)
      end, { desc = "Harpoon: Go to file 1" })
      vim.keymap.set("n", "<C-t>", function()
        harpoon:list():select(2)
      end, { desc = "Harpoon: Go to file 2" })
      vim.keymap.set("n", "<C-n>", function()
        harpoon:list():select(3)
      end, { desc = "Harpoon: Go to file 3" })
      vim.keymap.set("n", "<C-s>", function()
        harpoon:list():select(4)
      end, { desc = "Harpoon: Go to file 4" })

      -- Navigate previous/next in the Harpoon list
      vim.keymap.set("n", "<C-S-P>", function()
        harpoon:list():prev()
      end, { desc = "Harpoon: Previous file" })
      vim.keymap.set("n", "<C-S-N>", function()
        harpoon:list():next()
      end, { desc = "Harpoon: Next file" })

      -- Telescope integration for Harpoon
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end
        require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          })
          :find()
      end

      -- Use Telescope for Harpoon quick menu
      vim.keymap.set("n", "<C-e>", function()
        toggle_telescope(harpoon:list())
      end, { desc = "Open Harpoon window in Telescope" })
    end,
  },
}
