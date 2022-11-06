-- SUBVERSIVE SETUP

local cmd = vim.api.nvim_command

-- TODO: find lua solution for <plug>
cmd [[
  nmap s <plug>(SubversiveSubstitute)
  nmap ss <plug>(SubversiveSubstituteLine)
  map S <plug>(SubversiveSubstituteToEndOfLine)

  nmap <Leader>s <plug>(SubversiveSubstituteRange)
  xmap <Leader>s <plug>(SubversiveSubstituteRange)
  nmap <Leader>ss <plug>(SubversiveSubstituteWordRange)

  xmap s <plug>(SubversiveSubstitute)
  xmap p <plug>(SubversiveSubstitute)
  xmap P <plug>(SubversiveSubstitute)
]]

