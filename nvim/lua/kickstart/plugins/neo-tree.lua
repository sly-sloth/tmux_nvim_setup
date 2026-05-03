-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

---@module 'lazy'
---@type LazySpec LazySpec
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  ---@module 'neo-tree'
  ---@type neotree.Config
  opts = {
    event_handlers = {
      {
        event = 'neo_tree_buffer_enter',
        handler = function()
          vim.opt_local.number = true
          vim.opt_local.relativenumber = true
        end,
      },
    },
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          
          ['O'] = 'expand_all_nodes', -- Opens all nodes in the current dir
          ['E'] = function(state)
            local node = state.tree:get_node()
            require("neo-tree.sources.filesystem.commands").expand_all_nodes(state, node)
          end,

          ['W'] = 'close_node',       -- Closes the currently selected folder
          ['Q'] = 'close_all_nodes',  -- Closes/collapses all nodes
        },
      },
    },
  },
}
