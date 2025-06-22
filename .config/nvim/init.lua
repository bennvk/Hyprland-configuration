vim.opt.number = true
vim.o.mouse = "a"
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2

vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("themes.pywal").setup()

    if vim.fn.argc() == 0 then
      vim.defer_fn(function()
        vim.cmd("enew")
        vim.wo.number = false
        vim.cmd("normal! i")

        local content_width = 32
        local function pad_center(str, width)
          local total_padding = width - vim.fn.strdisplaywidth(str)
          local left = math.floor(total_padding / 2)
          local right = total_padding - left
          return string.rep(" ", left) .. str .. string.rep(" ", right)
        end

        local content = {
          "╭" .. string.rep("─", content_width) .. "╮",
          "│" .. pad_center("👋 Bienvenue benn", content_width) .. "│",
          "╰" .. string.rep("─", content_width) .. "╯",
          "",
          " [n] Nouveau fichier",
          " [f] Ouvrir fichier",
          " [r] Dernier fichier",
          " [q] Quitter Neovim",
          "",
          " Tape une touche pour continuer...",
        }

        local top_padding = 4
        local left_padding = 15

        local function pad_left(line)
          return string.rep(" ", left_padding) .. line
        end

        local padded = {}
        for _, line in ipairs(content) do
          table.insert(padded, pad_left(line))
        end

        for _ = 1, top_padding do
          table.insert(padded, 1, "")
        end

        vim.api.nvim_buf_set_lines(0, 0, -1, false, padded)
        vim.cmd("stopinsert")

        local opts = { buffer = true, silent = true }
        vim.keymap.set("n", "n", ":enew<CR>", opts)

        vim.keymap.set("n", "r", function()
          local last = vim.fn.expand("#")
          if last == "" then
            print("Pas de dernier fichier.")
          else
            vim.cmd("edit #")
          end
        end, opts)

        vim.keymap.set("n", "q", ":q!<CR>", opts)

        vim.keymap.set("n", "f", function()
          vim.cmd("enew")
          vim.bo.buftype = "nofile"
          vim.bo.bufhidden = "wipe"
          vim.bo.swapfile = false
          vim.bo.modifiable = true
          vim.wo.number = true
          vim.wo.relativenumber = false
          vim.opt.wrap = false

          local oldfiles = vim.v.oldfiles
          local max_files = 10
          local list = {}

          for i = 1, math.min(max_files, #oldfiles) do
            table.insert(list, string.format("%2d: %s", i, oldfiles[i]))
          end

          vim.api.nvim_buf_set_lines(0, 0, -1, false, list)
          vim.bo.modifiable = false

          vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "", {
            noremap = true,
            silent = true,
            callback = function()
              local line = vim.api.nvim_get_current_line()
              local file = line:match("%d+: (.+)")
              if file and file ~= "" then
                vim.cmd("edit " .. file)
              else
                print("Fichier invalide")
              end
            end,
          })
        end, opts)
      end, 10)
    end
  end,
})
