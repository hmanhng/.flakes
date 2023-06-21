return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }
    local C = require("catppuccin.palettes").get_palette()
    local colors = {
      bg = "#3B4252",
      fg = "#D6DCE7",
      yellow = "#ECBE7B",
      cyan = "#008080",
      darkblue = "#081633",
      green = "#A6E3A1",
      orange = "#FF8800",
      violet = "#a9a1e1",
      magenta = "#c678dd",
      blue = "#61afef",
      red = "#ec5f67",
      custom = "#B38DAC",
    }

    opts.options.theme = {
      normal = {
        a = { bg = colors.blue, fg = C.mantle, gui = "bold" },
        b = { fg = colors.blue },
        --[[ c = { bg = transparent_bg, fg = C.text }, ]]
      },

      insert = {
        a = { bg = C.green, fg = C.base, gui = "bold" },
        b = { fg = C.green },
      },

      terminal = {
        a = { bg = C.green, fg = C.base, gui = "bold" },
        b = { fg = C.teal },
      },

      command = {
        a = { bg = C.peach, fg = C.base, gui = "bold" },
        b = { fg = C.peach },
      },

      visual = {
        a = { bg = C.mauve, fg = C.base, gui = "bold" },
        b = { fg = C.mauve },
      },

      replace = {
        a = { bg = C.red, fg = C.base, gui = "bold" },
        b = { fg = C.red },
      },

      inactive = {
        a = { bg = transparent_bg, fg = C.blue },
        b = { bg = transparent_bg, fg = C.surface1, gui = "bold" },
        c = { bg = transparent_bg, fg = C.overlay0 },
      },
    }
    opts.options.component_separators = ""
    opts.options.section_separators = { left = "", right = "" }
    opts.sections.lualine_a = {}
    --[[ opts.sections.lualine_b = {} ]]
    --[[ opts.sections.lualine_y = {} ]]
    opts.sections.lualine_z = {}
    local function ins_left(component)
      table.insert(opts.sections.lualine_c, component)
    end
    local function ins_x(component)
      table.insert(opts.sections.lualine_x, component)
    end
    local function ins_y(component)
      table.insert(opts.sections.lualine_y, component)
    end
    opts.sections.lualine_b = {
      function()
        local mode_map = {
          ["n"] = "N",
          ["no"] = "O-PENDING",
          ["nov"] = "O-PENDING",
          ["noV"] = "O-PENDING",
          ["no�"] = "O-PENDING",
          ["niI"] = "N",
          ["niR"] = "N",
          ["niV"] = "N",
          ["nt"] = "N",
          ["v"] = "V",
          ["vs"] = "V",
          ["V"] = "V-LINE",
          ["Vs"] = "V-LINE",
          ["�"] = "V-BLOCK",
          ["�s"] = "V-BLOCK",
          ["s"] = "SELECT",
          ["S"] = "S-LINE",
          ["�"] = "S-BLOCK",
          ["i"] = "I",
          ["ic"] = "I",
          ["ix"] = "I",
          ["R"] = "REPLACE",
          ["Rc"] = "REPLACE",
          ["Rx"] = "REPLACE",
          ["Rv"] = "V-REPLACE",
          ["Rvc"] = "V-REPLACE",
          ["Rvx"] = "V-REPLACE",
          ["c"] = "COMMAND",
          ["cv"] = "EX",
          ["ce"] = "EX",
          ["r"] = "REPLACE",
          ["rm"] = "MORE",
          ["r?"] = "CONFIRM",
          ["!"] = "SHELL",
          ["t"] = "TERMINAL",
        }
        return mode_map[vim.api.nvim_get_mode().mode] or "__"
      end,
      --[[ padding = { right = 0 }, ]]
    }
    opts.sections.lualine_c[3] = {
      "filename",
      path = 0,
      cond = conditions.buffer_not_empty,
      color = { gui = "italic" },
      symbols = { modified = " ", readonly = "󰈡 ", unnamed = "" },
    }

    -- RIGHT
    ins_x({
      function()
        local msg = "No Active Lsp"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      icon = " ",
      color = { gui = "bold" },
    })
    ins_y({ "branch", icon = "", color = { gui = "bold" } })
    table.insert(opts.extensions, "fzf")
  end,
}
