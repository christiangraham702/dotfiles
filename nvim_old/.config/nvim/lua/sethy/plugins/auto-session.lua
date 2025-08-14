return {
  "rmagatti/auto-session",
  config = function()
    require("auto-session").setup {
      auto_restore = false,  -- Replace any old globals
      suppressed_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
    }
  end,
}
