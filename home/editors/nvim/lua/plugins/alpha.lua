return {
  "goolord/alpha-nvim",
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    local logo = [[
    ██╗  ██╗███╗   ███╗ █████╗ ███╗   ██╗██╗  ██╗███╗   ██╗ ██████╗           Z
    ██║  ██║████╗ ████║██╔══██╗████╗  ██║██║  ██║████╗  ██║██╔════╝       Z    
    ███████║██╔████╔██║███████║██╔██╗ ██║███████║██╔██╗ ██║██║  ███╗   z       
    ██╔══██║██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══██║██║╚██╗██║██║   ██║ z         
    ██║  ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║██║  ██║██║ ╚████║╚██████╔╝           
    ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝            
    ]]
    dashboard.section.header.val = vim.split(logo, "\n")
    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. " Find file", ":FzfLua files <CR>"),
      dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", " " .. " Recent files", ":FzfLua oldfiles <CR>"),
      dashboard.button("g", " " .. " Find text", ":FzfLua live_grep <CR>"),
      dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
      dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
      dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy <CR>"),
      dashboard.button("q", " " .. " Quit", ":qa <CR>"),
    }
  end,
}
