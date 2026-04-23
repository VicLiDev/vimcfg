require("auto-session").setup({
  log_level = "warn",
  auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
  auto_session_use_git_branch = true,
  pre_save_cmds = { "NERDTreeClose" },
})
