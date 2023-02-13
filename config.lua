--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
-- general
lvim.log.level = "warn"
-- lvim.log.level = "debug"
lvim.format_on_save = false
-- lvim.colorscheme = "tokyonight-night"
lvim.colorscheme = "gruvbox"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false
vim.opt.fileencodings = { "utf-8", "sjis", "euc-jp" }
vim.opt.cursorline = true
vim.opt.cursorcolumn = true


-- lualine
lvim.builtin.lualine.style = "default"
-- lvim.builtin.lualine.style = "lvim"
local filename = {
  "filename",
  file_status = true,
  path = 1,
}
lvim.builtin.lualine.sections.lualine_c = { filename, }


-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-h>"] = ":bp<cr>"
lvim.keys.normal_mode["<S-l>"] = ":bn<cr>"

lvim.keys.normal_mode["j"] = "gj"
lvim.keys.normal_mode["k"] = "gk"

-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
}

lvim.builtin.which_key.mappings["y"] = {
  name = "+Yank",
  a = { 'ggVG"+y', "yank all" },
  r = { "<cmd>YankyRingHistory<cr>", "yanky ring history" },
  h = { "<cmd>Telescope yank_history<cr>", "yanky history" },
}
lvim.builtin.which_key.mappings["S"] = {
  name = "+Sidebar",
  t = { "<cmd>SidebarNvimToggle<cr>", "Toggle sidebar" },
}

lvim.builtin.which_key.mappings["s"]["m"] = {
  "<cmd>Telescope marks<cr>", "marks"
}

lvim.builtin.which_key.mappings["f"] = {
  "<cmd>Telescope find_files<cr>", "find files"
}
lvim.builtin.which_key.mappings["b"]["f"] = {
  "<cmd>Telescope buffers<cr>", "find buffers"
}
lvim.builtin.which_key.mappings["h"] = {
  "<cmd>HopWord<cr>", "Hop word"
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
-- lvim.builtin.notify.active = true -- Deprecated
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
--
-- null-ls pyproject.toml
lvim.lsp.null_ls.setup.root_dir = function(fname)
  local util = require "lspconfig.util"
  local root_files = {
    "pyproject.toml",
    "package.json",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "manage.py",
    "pyrightconfig.json",
    "go.mod",
    "package.json",
    ".git",
  }
  return util.root_pattern(unpack(root_files))(fname) or util.root_pattern ".git" (fname) or util.path.dirname(fname)
end
-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright", "pylsp", "null-ls" })
--
local opts = {}
require("lvim.lsp.manager").setup("pyright", opts)

-- local pylsp_opts = {
--   settings = {
--     pylsp = {
--       plugins = {
--         pycodestyle = { enabled = false },
--         -- flake8 = { executable = "pflake8", enabled = true },

--         pylsp_mypy = { executable = "mypy", enabled = true },
--       }
--     },
--   }
-- }
-- require("lvim.lsp.manager").setup("pylsp", pylsp_opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
--

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "isort", filetypes = { "python" } },
  { command = "black", filetypes = { "python" } },
  { command = "remark", filetypes = { "markdown" } },
  -- {
  --   -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  --   command = "prettier",
  --   ---@usage arguments to pass to the formatter
  --   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  --   extra_args = { "--print-with", "100" },
  --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --   filetypes = { "typescript", "typescriptreact" },
  -- },
}

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "pyproject-flake8", filetypes = { "python" } },
  { command = "mypy", filetypes = { "python" } },
  { command = "textlint", filetypes = { "text" } },
  { command = "jsonlint", filetypes = { "json" } },

  -- {
  --   command = "mypy", filetypes = { "python" },
  --   extra_argss = { "--strict", },
  -- },
  -- {
  --   -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  --   command = "shellcheck",
  --   ---@usage arguments to pass to the formatter
  --   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  --   extra_args = { "--severity", "warning" },
  -- },
  -- {
  --   command = "codespell",
  --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --   filetypes = { "javascript", "python" },
  -- },
}

-- Additional Plugins
lvim.plugins = {
  -- colorscheme
  -- { "folke/tokyonight.nvim" }, -- core plugin
  --
  { "morhetz/gruvbox" },
  { "rebelot/kanagawa.nvim" },

  -- dependencies
  { "tyru/open-browser.vim" },

  -- utils
  -- { "tpope/vim-repeat" },
  -- { "tpope/vim-surround" },

  { "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },

  { "t9md/vim-quickhl" },
  { "gbprod/yanky.nvim",
    requires = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("yanky").setup {
        -- highlight = {
        --   on_put = true,
        --   on_yank = true,
        --   timer = 500,
        -- }
      }
      require("telescope").load_extension("yank_history")
    end },

  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },

  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },

  -- markdown
  { "preservim/vim-markdown",
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
    end,
    require = "godlygeek/tabular",
  },
  { "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = { "markdown" },
  },
  { "mattn/vim-maketable" },

  -- plantuml
  { "weirongxu/plantuml-previewer.vim" },
  { "aklt/plantuml-syntax" },

  -- csv
  { "mechatroner/rainbow_csv" },

  -- github
  { "pwntester/octo.nvim",
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require("octo").setup()
    end,
  },

  -- treesitter
  { -- 関数名を表示
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
          },
        },
      }
    end
  },
  -- typo file
  { "tyru/stoptypofile.vim" },

  -- quickfix preview
  { "kevinhwang91/nvim-bqf" },

  -- mark
  { "chentoast/marks.nvim",
    config = function()
      require 'marks'.setup {
        -- whether to map keybinds or not. default true
        default_mappings = true,
        -- which builtin marks to show. default {}
        builtin_marks = { ".", "<", ">", "^" },
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = false,
        -- how often (in ms) to redraw signs/recompute mark positions.
        -- higher values will have better performance but may cause visual lag,
        -- while lower values may cause performance penalties. default 150.
        refresh_interval = 250,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {},
        -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
        -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
        bookmark_0 = {
          sign = "⚑",
          virt_text = "hello world"
        },
        mappings = {}
      }
    end },


  -- sidebar
  { "sidebar-nvim/sidebar.nvim",
    config = function()
      local sidebar = require("sidebar-nvim")
      sidebar.setup({
        -- open = true,
      })
    end,
  },

  -- buffer
  { "kwkarlwang/bufresize.nvim" },

  -- asterisk
  { "rapan931/lasterisk.nvim",
    config = function()
      vim.keymap.set('n', '*', function() require("lasterisk").search() end)
      vim.keymap.set('n', 'g*', function() require("lasterisk").search({ is_whole = false }) end)
      vim.keymap.set('x', 'g*', function() require("lasterisk").search({ is_whole = false }) end)
    end,
  },

  -- matchup
  { "andymass/vim-matchup",
    setup = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      lvim.builtin.treesitter.matchup.enable = true
    end,
  },

  { "CRAG666/code_runner.nvim",
    filetype = {
      -- java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
      python = "python3 -u",
      -- typescript = "deno run",
      rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt"
    },
    config = function()
      local _opts = { noremap = true, silent = false }
      vim.keymap.set('n', '<leader>r', ':RunCode<CR>', _opts)
      vim.keymap.set('n', '<leader>rf', ':RunFile<CR>', _opts)
      vim.keymap.set('n', '<leader>rft', ':RunFile tab<CR>', _opts)
      vim.keymap.set('n', '<leader>rp', ':RunProject<CR>', _opts)
      vim.keymap.set('n', '<leader>rc', ':RunClose<CR>', _opts)
      vim.keymap.set('n', '<leader>crf', ':CRFiletype<CR>', _opts)
      vim.keymap.set('n', '<leader>crp', ':CRProjects<CR>', _opts)
    end
  },

  -- cursor move highlight

  -- { 'edluffy/specs.nvim',
  --   config = function()
  --     require('specs').setup {
  --       show_jumps       = true,
  --       min_jump         = 5,
  --       popup            = {
  --         delay_ms = 0, -- delay before popup displays
  --         inc_ms = 10, -- time increments used for fade/resize effects
  --         blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
  --         width = 10,
  --         winhl = "PMenu",
  --         fader = require('specs').linear_fader,
  --         resizer = require('specs').shrink_resizer
  --       },
  --       ignore_filetypes = {},
  --       ignore_buftypes  = {
  --         nofile = true,
  --       },
  --     }
  --   end },

  { "stonelasley/flare.nvim",
    config = function()
      require('flare').setup {
        enabled = true, -- disable highlighting
        hl_group = "IncSearch", -- set highlight group used for highlight
        x_threshold = 20, -- column changes greater than this number trigger highlight
        y_threshold = 5, -- row changes greater than this number trigger highlight
        expanse = 2, -- highlight will expand to the left and right of cursor up to this amount (depending on space available)
        file_ignore = { -- suppress highlighting for files of this type
          "NvimTree",
          "fugitive",
          "TelescopePrompt",
          "TelescopeResult",
        },
        fade = true, -- if false will flash highlight for entire area similar to 'vim.highlight.on_yank'
        underline = false, -- if true will use more subtle underline highlight. Underline highlight can also be accomplished by setting hl_group
        timeout = 100, -- timeout delay
      }
    end },


  -- outline
  { "stevearc/aerial.nvim",
    config = function()
      require('aerial').setup({
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
          vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
        end
      })

      -- You probably also want to set a keymap to toggle aerial
      vim.keymap.set('n', '<leader>o', '<cmd>AerialToggle!<CR>')
    end
  },

  -- typo
  { 'poljar/typos.nvim',
    -- config = function() require("typo").setup() end,
  },

  -- hop
  {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  },

  -- git commit comment
  { "rhysd/committia.vim" },

  -- easy-align
  { "junegunn/vim-easy-align",
    config = function()
      local _opts = { noremap = true, silent = false }
      vim.keymap.set('v', '<leader><leader>\\', ':EasyAlign*<Bar><CR>', _opts)
    end }

}

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#252525" })
    vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#252525" })
  end,
})

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
