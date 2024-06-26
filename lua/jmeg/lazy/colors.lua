return {
  -- add gruvbox
  {
    "ellison/gruvbox.nvim",
    config = true,
    opts = {
        transparent_mode = true,
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
