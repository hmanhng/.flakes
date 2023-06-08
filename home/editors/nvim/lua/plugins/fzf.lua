return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    { "<leader>,", "<cmd>FzfLua buffers<cr>", desc = "Switch Buffer" },
    { "<leader><space>", "<cmd>FzfLua files<cr>", desc = "Find Files" },
    { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
    { "<leader>ff", "<cmd>FzfLua<cr>", desc = "FzfLua" },
    { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent Files" },
    { "<leader>bs", "<cmd>FzfLua blines<cr>", desc = "Search in Buffer" },
    { "<leader>bS", "<cmd>FzfLua lines<cr>", desc = "Search in Buffers" },

    --[[ search ]]
    { "<leader>ss", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "Grep Buffer" },
    { "<leader>sS", "<cmd>FzfLua live_grep<cr>", desc = "Grep Project" },
    { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },

    --[[ git ]]
    { "<leader>gf", "<cmd>FzfLua git_files<cr>", desc = "Files in Git" },
    { "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "Files in Git status" },

    --[[ misc ]]
    { "<leader>uC", "<cmd>FzfLua colorschemes<cr>", desc = "Colorschemes" },
  },
  opts = {
    "fzf-native",
    winopts = {
      height = 0.9, -- window height
      width = 0.8, -- window width
      row = 0.30, -- window row position (0=top, 1=bottom)
      col = 0.50, -- window col position (0=left, 1=right)
      border = "single", -- 'none', 'single', 'double', 'thicc' or 'rounded' (default)
      preview = {
        border = "border",
        horizontal = "right:65%", -- right|left:size
        title_align = "center",
        scrollbar = "float",
      },
      hl = {
        normal = "Normal", -- window normal color (fg+bg)
        border = "Keyword", -- border color
        help_normal = "Normal", -- <F1> window normal
        help_border = "FloatBorder", -- <F1> window border
        -- Only used with the builtin previewer:
        cursor = "Cursor", -- cursor highlight (grep/LSP matches)
        cursorline = "CursorLine", -- cursor line
        cursorlinenr = "CursorLineNr", -- cursor line number
        search = "IncSearch", -- search matches (ctags|help)
        title = "Normal", -- preview border title (file/buffer)
        -- Only used with 'winopts.preview.scrollbar = 'float'
        scrollfloat_e = "PmenuSbar", -- scrollbar "empty" section highlight
        scrollfloat_f = "PmenuThumb", -- scrollbar "full" section highlight
        -- Only used with 'winopts.preview.scrollbar = 'border'
        scrollborder_e = "FloatBorder", -- scrollbar "empty" section highlight
        scrollborder_f = "FloatBorder", -- scrollbar "full" section highlight
      },
    },
    fzf_colors = {
      ["fg"] = { "fg", "CursorLine" },
      ["bg"] = { "bg", "Normal" },
      ["hl"] = { "fg", "Comment" },
      ["fg+"] = { "fg", "Normal" },
      ["bg+"] = { "bg", "CursorLine" },
      ["hl+"] = { "fg", "Statement" },
      ["info"] = { "fg", "PreProc" },
      ["prompt"] = { "fg", "Conditional" },
      ["pointer"] = { "fg", "Exception" },
      ["marker"] = { "fg", "Keyword" },
      ["spinner"] = { "fg", "Label" },
      ["header"] = { "fg", "Comment" },
      ["gutter"] = { "bg", "Normal" },
    },
    previewers = {
      bat = {
        theme = "Catppuccin-macchiato",
        args = "--style=numbers,changes,header --color always",
      },
    },
    keymap = {
      fzf = {
        -- fzf '--bind=' options
        ["ctrl-z"] = "abort",
        ["ctrl-u"] = "unix-line-discard",
        ["ctrl-f"] = "half-page-down",
        ["ctrl-b"] = "half-page-up",
        ["ctrl-a"] = "beginning-of-line",
        ["ctrl-e"] = "end-of-line",
        --[[ ["alt-a"] = "toggle-all", ]]
        -- Only valid with fzf previewers (bat/cat/git/etc)
        ["f3"] = "toggle-preview-wrap",
        ["f4"] = "toggle-preview",
        ["alt-j"] = "preview-page-down",
        ["alt-k"] = "preview-page-up",
      },
    },
  },
}
